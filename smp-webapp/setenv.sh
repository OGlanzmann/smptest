#!/usr/bin/env bash
#Please change CATALINA_HOME to the right folder
export CATALINA_HOME=/usr/local/tomcat
export JAVA_OPTS="$JAVA_OPTS -Dsmp.config.properties=$CATALINA_HOME/smp/conf"
# Set CLASSPATH to include $CATALINA_HOME/smp/conf
# where the smp ‘smp.config.properties’ is located
export CLASSPATH=$CATALINA_HOME/smp/conf

CATALINA_OPTS="-Djava.net.preferIPv4Stack=true"
