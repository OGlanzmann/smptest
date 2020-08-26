FROM tomcat:8-jdk8
MAINTAINER Digg

RUN mkdir /usr/local/tomcat/smp
RUN mkdir /usr/local/tomcat/smp/keystores
RUN mkdir /usr/local/tomcat/smp/conf

COPY ./smp-webapp/smp.config.properties /usr/local/tomcat/smp/conf/smp.config.properties
COPY ./smp-webapp/hibernate.properties /usr/local/tomcat/smp/conf/hibernate.properties

COPY ./smp-webapp/setenv.sh /usr/local/tomcat/bin/setenv.sh

COPY ./smp-webapp/mysql-connector-java-5.1.45-bin.jar /usr/local/tomcat/lib/mysql-connector-java-5.1.45-bin.jar

# TODO: Make sure this lives in a persistent volume in production and test
COPY ./smp-webapp/sample_signatures_keystore.jks /usr/local/tomcat/smp/keystores/sample_signatures_keystore.jks

RUN chmod -R 755 /usr/local/tomcat/smp

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
COPY ./smp-webapp/smp-4.1.0.war /usr/local/tomcat/webapps/ROOT.war

#ENV CLASSPATH=${CLASSPATH} /usr/local/tomcat/smp/conf
#ENV JAVA_OPTS="${JAVA_OPTS} -Dsmp.config.properties=/usr/local/tomcat/smp/conf"

ENV SMP_DB_NAME="smp_schema"
ENV SMP_DB_HOST="mysql"
ENV SMP_DB_PORT="3306"
ENV SMP_DB_RECONNECT="true"
ENV SMP_DB_USE_SSL="false"

ENV SMP_DB_USER="root"
ENV SMP_DB_PASS="root"


ENV SMP_SIGN_KEYSTORE_PATH="/usr/local/tomcat/smp/keystores/sample_signatures_keystore.jks"
ENV SMP_SIGN_KEYSTORE_PASS="secure123"

ENV SMP_BDMSL_ENABLED="false"
ENV SMP_BDMSL_URL="https://acc.edelivery.tech.ec.europa.eu/edelivery-sml/manageparticipantidentifier"
ENV SMP_BDMSL_KEYSTORE_PATH="/usr/local/tomcat/smp/keystores/smp_01_test_keystore.jks"
ENV SMP_BDMSL_KEYSTORE_PASS="secure123"


CMD ["catalina.sh", "run"]