FROM tomcat:8-jdk8
MAINTAINER Digg

RUN mkdir /usr/local/tomcat/smp
RUN mkdir /usr/local/tomcat/smp/keystores
COPY ./smp-webapp/smp.config.properties /usr/local/tomcat/smp/smp.config.properties

COPY ./smp-webapp/mysql-connector-java-5.1.48-bin.jar /usr/local/tomcat/lib/mysql-connector-java-5.1.48-bin.jar

# TODO: Make sure this lives in a persistent volume in production and test
COPY ./smp-webapp/sample_signatures_keystore.jks /usr/local/tomcat/smp/keystores/sample_signatures_keystore.jks

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
COPY ./smp-webapp/smp.war /usr/local/tomcat/webapps/ROOT.war

ENV CLASSPATH=/usr/local/tomcat/smp

CMD ["catalina.sh", "run"]