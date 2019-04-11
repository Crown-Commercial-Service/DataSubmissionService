
get backups from prod bastion host
```
gunzip production-backup-api-20190410.tar.gz
pg_restore production-backup-api-20190410.tar > production-backup-api-20190410.sql
cf conduit ccs-rmi-api-bobtest -- psql < production-backup-api-20190410.sql
```

currently not working for API due to UUID things. there is a open support request for this.

