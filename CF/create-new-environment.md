# Create a new environment

First provision https://docs.cloud.service.gov.uk/deploying_services/postgresql/#set-up-a-postgresql-service

```
cf create-service postgres small-ha-10 ccs-rmi-api -c '{"enable_extensions": ["pgcrypto"]}'
```

manifest.yml must be bound to all services

Create a CDN file in the frontend's CF directory for the new routing

Allow your environment name as a trusted environment to the if conditions in CF/create-cf-space.sh script.

```
./create-cf-space.sh -u <YOUR_PAAS_EMAIL> -p '<YOUR_PAAS_PASSWORD>' -o ccs-report-management-info -s sandbox
```

This outputs some CDN configuration that we need to share with dxw's DNS by deploying a change to this file https://git.govpress.com/ops/BytemarkDNS/blob/master/data/dxw.net#L755:

```
status:    create in progress
message:   Provisioning in progress
           [api.sandbox.rmi-paas.dxw.net,www.sandbox.rmi-paas.dxw.net =>
           london.cloudapps.digital]; CNAME or ALIAS domain
           api.sandbox.rmi-paas.dxw.net,www.sandbox.rmi-paas.dxw.net to
           d1ltkl96cllw58.cloudfront.net and create TXT record(s):
name:
           _acme-challenge.api.sandbox.rmi-paas.dxw.net., value:
           xxx, ttl: 120
name:
           _acme-challenge.www.sandbox.rmi-paas.dxw.net., value:
           xxx, ttl: 120
started:   2019-08-15T10:01:15Z
updated:   2019-08-15T10:01:17Z
```

The CDN service will be stuck with a `provisioning` status until this change is deployed: https://git.govpress.com/ops/BytemarkDNS/merge_requests/102/diffs

When the database is created for the first time for both API and Frontend, there will be Postgres permission errors that prevent the apps from starting. We believe that this is because the Database has already been created, but the schema has not been loaded. To get around this you can follow these steps or do a database restore.

1. remove `rake db:create` from the docker-entrypoint.sh  
2. build a new docker image locally with this change `docker build . -t thedxw/ccs-rmi-api:pg-fix`
3. push this docker image to the docker repository `docker push thedxw/ccs-rmi-api:pg-fix`
4. deploy this change to gpaas `cf v3-zdt-push ccs-rmi-api-"$CF_SPACE" --docker-image thedxw/ccs-rmi-api:pg-fix`
5. check the logs to see if Puma started `cf logs ccs-rmi-api --recent`

You need to add some additional routing in order to all users access of the /admin section of the API, which is otherwise thought of as a "private" application within gpaas.

https://github.com/dxw/DataSubmissionService/pull/238/files

There is also a router service that you will need to deploy. Check this out locally, allow the new space name in the if conditions and deploy the app from your local machine using the CF/deploy script: https://github.com/dxw/DataSubmissionServiceRouter
