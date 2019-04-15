#!/bin/bash
# script to create user services.


# login
cf login -u $CF_USER -p $CF_PASS -o ccs-report-management-info -s bobtest

# source environment variables
pwd
source .env.cf.bobtest
#create user service for skylight
echo "{\"SKYLIGHT_ENV\":\"$SKYLIGHT_ENV\",\"SKYLIGHT_AUTHENTICATION\":\"$SKYLIGHT_AUTHENTICATION\"}" > /tmp/skylight.json
if ! cf services | grep -q SKYLIGHT
then
  cf create-user-provided-service SKYLIGHT -p /tmp/skylight.json
else

cf update-user-provided-service SKYLIGHT -p /tmp/skylight.json
fi
rm /tmp/skylight.json

#create user service for Rollbar
echo "{\"ROLLBAR_ENV\":\"$ROLLBAR_ENV\",\"ROLLBAR_ACCESS_TOKEN\":\"$ROLLBAR_ACCESS_TOKEN\"}" > /tmp/rollbar.json
if ! cf services | grep -q ROLLBAR
then
  cf create-user-provided-service ROLLBAR -p /tmp/rollbar.json
else
  cf update-user-provided-service ROLLBAR -p /tmp/rollbar.json
fi
rm /tmp/rollbar.json
#create user service for AUTH0
echo "{\"AUTH0_DOMAIN\":\"$AUTH0_DOMAIN\",\"AUTH0_CLIENT_ID\":\"$AUTH0_CLIENT_ID\",\"AUTH0_CLIENT_SECRET\":\"$AUTH0_CLIENT_SECRET\"}" >/tmp/AUTH0.json
if ! cf services | grep -q AUTH0
then
  cf create-user-provided-service AUTH0 -p /tmp/AUTH0.json
else
  cf update-user-provided-service AUTH0 -p /tmp/AUTH0.json
fi
rm /tmp/AUTH0.json
#create user service for API
echo "{\"API_ROOT\":\"$API_ROOT\",\"API_PASSWORD\":\"$API_PASSWORD\"}" > /tmp/api.json
if ! cf services | grep -q DSSAPI
then
  cf create-user-provided-service DSSAPI -p /tmp/api.json
else
cf update-user-provided-service DSSAPI -p /tmp/api.json
  fi
rm /tmp/api.json 

#create user service for APP_SECRETBASE
echo "{\"SECRET_KEY_BASE\":\"$SECRET_KEY_BASE\"}" > /tmp/appsecretbase.json
if ! cf services | grep -q APP_SECRETBASE
then
  cf create-user-provided-service APP_SECRETBASE -p /tmp/appsecretbase.json
else
cf update-user-provided-service APP_SECRETBASE -p /tmp/appsecretbase.json
fi
rm /tmp/appsecretbase.json
# create google auth service
echo "{\"GOOGLE_CLIENT_ID\":\"$GOOGLE_CLIENT_ID\",\"GOOGLE_CLIENT_SECRET\":\"$GOOGLE_CLIENT_SECRET\"}" > /tmp/googleclient.json

if ! cf services | grep -q GOOGLE_CLIENT
then
  cf create-user-provided-service GOOGLE_CLIENT -p /tmp/googleclient.json
else
cf update-user-provided-service GOOGLE_CLIENT -p /tmp/googleclient.json
fi
rm /tmp/googleclient.json
# create workday service
echo "{\"WORKDAY_API_USERNAME\":\"$WORKDAY_API_USERNAME\",\"WORKDAY_API_PASSWORD\":\"$WORKDAY_API_PASSWORD\"}" > /tmp/workday.json

if ! cf services | grep -q WORKDAY_API
then
  cf create-user-provided-service WORKDAY_API -p /tmp/workday.json
else
cf update-user-provided-service WORKDAY_API -p /tmp/workday.json
fi
rm /tmp/workday.json
# create sidekiq service
echo "{\"SIDEKIQ_USERNAME\":\"$SIDEKIQ_USERNAME\",\"SIDEKIQ_PASSWORD\":\"$SIDEKIQ_PASSWORD\"}" > /tmp/sidekiq.json

if ! cf services | grep -q SIDEKIQ
then
  cf create-user-provided-service SIDEKIQ -p /tmp/sidekiq.json
else
cf update-user-provided-service SIDEKIQ -p /tmp/sidekiq.json
fi
rm /tmp/sidekiq.json
