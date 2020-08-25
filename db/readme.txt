create mysql:

oc new-app mysql -e MYSQL_ROOT_PASSWORD=root centos/mysql-57-centos7

oc cp .\mysql5innodb-4.1.0.ddl mysql-57-centos7-846f6cf96c-7c8nq:/tmp/init.sql

mysql -h localhost -u root_user –-password=root_password -e "drop schema if exists smp_schema;create schema smp_schema;alter database smp_schema charset=utf8; create user smp_dbuser@% identified by 'smp_password';grant all on smp_schema.* to smp_dbuser@%;"

mysql -h localhost -uroot_user --password=root_password smp_schema < /tmp/init.sql