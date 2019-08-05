#!/bin/bash
# script to create user services.

# exit on failures
set -e
set -o pipefail

usage() {
  echo "Usage: $(basename "$0") [OPTIONS]" 1>&2
  echo "  -h                    - help"
  echo "  -u <CF_USER>          - CloudFoundry user             (required)"
  echo "  -p <CF_PASS>          - CloudFoundry password         (required)"
  echo "  -o <CF_ORG>           - CloudFoundry org              (required)"
  echo "  -s <CF_SPACE>         - CloudFoundry space to create  (required)"
  echo "  -a <CF_API_ENDPOINT>  - CloudFoundry API endpoint     (default: https://api.london.cloud.service.gov.uk)"
  exit 1
}

CF_API_ENDPOINT="https://api.london.cloud.service.gov.uk"

while getopts "a:u:p:o:s:h" opt; do
  case $opt in
    u)
      CF_USER=$OPTARG
      ;;
    p)
      CF_PASS=$OPTARG
      ;;
    o)
      CF_ORG=$OPTARG
      ;;
    s)
      CF_SPACE=$OPTARG
      ;;
    a)
      CF_API_ENDPOINT=$OPTARG
      ;;
    h)
      usage
      exit;;
    *)
      usage
      exit;;
  esac
done

if [[ -z "$CF_USER" || -z "$CF_PASS" || -z "$CF_ORG" || -z "$CF_SPACE" ]]; then
  usage
fi

# login
cf login -u "$CF_USER" -p "$CF_PASS" -o "$CF_ORG" -s "$CF_SPACE" -a "$CF_API_ENDPOINT"

# source environment variables
source .env.cf."$CF_SPACE"

# create user services from user-services.json
USER_SERVICES=$(cat user-services.json)
USER_SERVICES_LENGTH=$(echo $USER_SERVICES | jq -r 'length')

for i in `seq 0 $(($USER_SERVICES_LENGTH - 1))`; do
  SERVICE_NAME=$(echo $USER_SERVICES | jq -r --argjson i "$i" '.[$i].service_name')
  SERVICE_ENV=$(echo $USER_SERVICES | jq -r --argjson i "$i" '.[$i].env')
  SERVICE_ENV_LENGTH=$(echo $SERVICE_ENV | jq -r 'length')
  LINE="{"
  for j in `seq 0 $(($SERVICE_ENV_LENGTH - 1))`; do
    SE=$(echo $SERVICE_ENV | jq -r --argjson j "$j" '.[$j]')
    LINE+="\"$SE\":\"${!SE}\""
    if [[ $j == $(($SERVICE_ENV_LENGTH - 1)) ]]; then
      LINE+="}"
    else
      LINE+=","
    fi
  done
  echo "$LINE" > /tmp/$CF_SPACE.$SERVICE_NAME.json
  if cf service $SERVICE_NAME > /dev/null; then
    cf update-user-provided-service $SERVICE_NAME -p /tmp/$CF_SPACE.$SERVICE_NAME.json
    rm /tmp/$CF_SPACE.$SERVICE_NAME.json
  else
    cf create-user-provided-service $SERVICE_NAME -p /tmp/$CF_SPACE.$SERVICE_NAME.json
    rm /tmp/$CF_SPACE.$SERVICE_NAME.json
  fi
done

# create route to api admin via router
if cf service ccs-rmi-api-admin-route-$CF_SPACE > /dev/null; then
  cf update-user-provided-service ccs-rmi-api-admin-route-$CF_SPACE -r https://ccs-rmi-api-admin-router-$CF_SPACE.london.cloudapps.digital
else
  cf create-user-provided-service ccs-rmi-api-admin-route-$CF_SPACE -r https://ccs-rmi-api-admin-router-$CF_SPACE.london.cloudapps.digital
fi
# create route to api admin via router
if cf service ccs-rmi-logging-$CF_SPACE > /dev/null; then
  cf update-user-provided-service ccs-rmi-logging-$CF_SPACE -l syslog-tls://$LOGS_ENDPOINT
else
  cf create-user-provided-service ccs-rmi-logging-$CF_SPACE -l syslog-tls://$LOGS_ENDPOINT
fi
