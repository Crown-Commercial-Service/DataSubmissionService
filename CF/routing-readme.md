## Routing

Once the cdn service is set up and the apps have been deployed we need to set up
some final routing.

```
cf target -s staging
cf map-route ccs-rmi-api-staging --hostname api staging.rmi-paas.ai-cloud.uk
cf map-route ccs-rmi-app-staging --hostname www staging.rmi-paas.ai-cloud.uk
cf bind-route-service staging.rmi-paas.ai-cloud.uk ccs-rmi-api-admin-route-staging --hostname api
cf target -s prod
cf map-route ccs-rmi-api-prod --hostname api prod.rmi-paas.ai-cloud.uk
cf map-route ccs-rmi-app-prod --hostname www prod.rmi-paas.ai-cloud.uk
cf bind-route-service prod.rmi-paas.ai-cloud.uk ccs-rmi-api-admin-route-prod --hostname api
```
