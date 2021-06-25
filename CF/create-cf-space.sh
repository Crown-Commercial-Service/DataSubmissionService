#!/bin/bash

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

POSTGRES_SIZE="tiny-unencrypted-10"
REDIS_SIZE="tiny-3.2"

if [[ "$CF_SPACE" == "staging" || "$CF_SPACE" == "conclave-development" || "$CF_SPACE" == "prod" ]]; then
  echo " *********************************************"
  echo "    The '$CF_SPACE' space will be selected"
  echo "     This deploys the apps as HA with"
  echo "      production like resource sizes"
  echo " For feature testing, choose a space with a"
  echo "      name other than staging / conclave-development / prod"
  echo " *********************************************"

  POSTGRES_SIZE="small-ha-10"
  REDIS_SIZE="medium-ha-3.2"
fi

# login (all users should have access to the sandbox/development space)
cf login -u "$CF_USER" -p "$CF_PASS" -o "$CF_ORG" -a "$CF_API_ENDPOINT" -s development

# create and target space (user must be org admin)
cf create-space "$CF_SPACE"
cf target -o "$CF_ORG" -s "$CF_SPACE"

# This is a fix for the environment being renamed - all apps and services are still ending with "-preprod".
# It's easier to manually adjust this here, after the env has been selected already as conclave-development, so set it back.
if [[ "$CF_SPACE" == "conclave-development" ]]
then
  "$CF_SPACE" = "preprod"
fi

# install cf-blue-green-deploy plugin
cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org
cf install-plugin blue-green-deploy -r CF-Community

# create ingest S3 bucket
cf create-service aws-s3-bucket default ingest-bucket-"$CF_SPACE"

# create postgres services for app/api
cf create-service postgres "$POSTGRES_SIZE" ccs-rmi-app-"$CF_SPACE"
cf create-service postgres "$POSTGRES_SIZE" ccs-rmi-api-"$CF_SPACE"

# create redit service
cf create-service redis "$REDIS_SIZE" ccs-rmi-redis-"$CF_SPACE"

# create external domains for org
set +o pipefail
if [[ $CF_SPACE == 'staging' || $CF_SPACE == 'preprod' || $CF_SPACE == 'prod' ]]
then
  if cf domains | grep -q ${CF_SPACE}.rmi-paas.ai-cloud.uk
  then
    echo "domain ${CF_SPACE}.rmi-paas.ai-cloud.uk already exists"
  else
    cf create-domain ccs-report-management-info "$CF_SPACE".rmi-paas.ai-cloud.uk
  fi

# create cdn route for space
  if cf service ccs-rmi-cdn-"$CF_SPACE" > /dev/null
  then
    echo "ccs-rmi-cdn-$CF_SPACE already exists"
  else
    cf create-service cdn-route cdn-route ccs-rmi-cdn-"$CF_SPACE" -c ccs-rmi-cdn-"$CF_SPACE".json
    sleep 10
    cf service ccs-rmi-cdn-"$CF_SPACE"
    echo "!!! create DNS records for CDN routes !!!"
  fi

fi

set -o pipefail
