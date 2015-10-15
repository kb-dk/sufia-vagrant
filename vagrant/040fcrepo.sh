#!/bin/bash


set -e
set -x

if [ -f ~/fcrepo ]; then
    exit
fi


if [ ! -d ~/tomcat80 ]; then
  get_tomcat.sh
fi

SOLR_HOME=~/solr/
TOMCAT_LIBS=~/tomcat80/lib/
SOLR_VERSION=4.10.3
DOWNLOAD_DIR=/tmp/
WEBAPPS_DIR=~/tomcat80/webapps/

mkdir -p ~/tomcat80/webapps/

#SOLR
if [ ! -f "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" ]; then
  echo "Downloading Solr"
  wget -c -q -O "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" "http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz"
fi

cd $DOWNLOAD_DIR
tar -xzf solr-"$SOLR_VERSION".tgz
cp "solr-$SOLR_VERSION/dist/solr-$SOLR_VERSION.war" ${WEBAPPS_DIR}/solr.war

if [ ! -f ${TOMCAT_LIBS}/commons-logging-1.1.2.jar ]; then
  wget -c -q -O ${TOMCAT_LIBS}/commons-logging-1.1.2.jar "http://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.2/commons-logging-1.1.2.jar"
fi
cp /tmp/solr-${SOLR_VERSION}/example/lib/ext/slf4j* ${TOMCAT_LIBS}
cp /tmp/solr-${SOLR_VERSION}/example/lib/ext/log4j* ${TOMCAT_LIBS}

mkdir -p ${SOLR_HOME}
cp -R /tmp/solr-${SOLR_VERSION}/example/solr/* ${SOLR_HOME} #Default stuff
cp -vRf /vagrant/solr/* ${SOLR_HOME} #Our overrides
cp /tmp/solr-${SOLR_VERSION}/dist/solr-${SOLR_VERSION}.war ~/tomcat80/webapps/

#Fedora
if [ ! -f ${WEBAPPS_DIR}/fedora.war ]; then
    wget -c -O ${WEBAPPS_DIR}/fedora.war https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-4.4.0/fcrepo-webapp-4.4.0.war
fi
cp /vagrant/tomcat-users.xml ~/tomcat80/conf

cd ~/ #Because solr finds its base dir relative to tomcats working dir...
~/tomcat80/bin/startup.sh

touch ~/fcrepo