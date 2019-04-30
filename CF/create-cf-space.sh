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

if [[ "$CF_SPACE" == "staging" || "$CF_SPACE" == "prod" ]]; then
  echo " *********************************************"
  echo "    The '$CF_SPACE' space will be selected"
  echo "     This deploys the apps as HA with"
  echo "      production like resource sizes"
  echo " For feature testing, choose a space with a"
  echo "      name other than staging / prod"
  echo " *********************************************"

  POSTGRES_SIZE="small-ha-10"
  REDIS_SIZE="medium-ha-3.2"
fi

# login (all users should have access to the sandbox)
cf login -u "$CF_USER" -p "$CF_PASS" -o "$CF_ORG" -a "$CF_API_ENDPOINT" -s sandbox

# create and target space (user must be org admin)
cf create-space "$CF_SPACE"
cf target -o "$CF_ORG" -s "$CF_SPACE"

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
