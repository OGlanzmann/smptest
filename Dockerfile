FROM tomcat:8-jdk8
MAINTAINER Digg
RUN apt-get update
RUN apt-get install mysql-client
RUN mkdir /usr/local/tomcat/smp
RUN mkdir /usr/local/tomcat/smp/keystores
RUN mkdir /usr/local/tomcat/smp/conf
COPY ./smp-webapp/smp.config.properties /usr/local/tomcat/smp/conf/smp.config.properties
COPY ./smp-webapp/hibernate.properties /usr/local/tomcat/smp/conf/hibernate.properties

COPY ./smp-webapp/setenv.sh /usr/local/tomcat/bin/setenv.sh

COPY ./smp-webapp/mysql-connector-java-5.1.45-bin.jar /usr/local/tomcat/lib/mysql-connector-java-5.1.45-bin.jar

# TODO: Make sure this lives in a persistent volume in production and test
COPY ./smp-webapp/sample_signatures_keystore.jks /usr/local/tomcat/smp/keystores/sample_signatures_keystore.jks

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
COPY ./smp-webapp/smp-4.1.0.war /usr/local/tomcat/webapps/ROOT.war

#ENV CLASSPATH=${CLASSPATH} /usr/local/tomcat/smp/conf
#ENV JAVA_OPTS="${JAVA_OPTS} -Dsmp.config.properties=/usr/local/tomcat/smp/conf"
CMD ["catalina.sh", "run"]