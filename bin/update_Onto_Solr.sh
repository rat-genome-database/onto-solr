#!/bin/sh

if [ "$1" == "" ]; then
  echo "USAGE: update_Onto_Solr.sh <hostname> <.tgz file>"
  echo "  f.e. update_Onto_Solr.sh hansen /data/OntoSolr_data/OntoSolrData.tgz"
  exit
fi
if [ "$2" == "" ]; then
  echo "USAGE: update_Onto_Solr.sh <hostname> <.tgz file>"
  echo "  f.e. update_Onto_Solr.sh hansen /data/OntoSolr_data/OntoSolrData.tgz"
  exit
fi

# replace OntoSolr index on given server
echo "Updating OntoSolr index on $1"

/rgd/bin/run_on_server.sh $1 rgdpub "rm -rf /data/OntoSolr/*"
scp $2 $1:/data/OntoSolr/OntoSolrData.tgz
/rgd/bin/run_on_server.sh $1 rgdpub "cd /data/OntoSolr;tar -xzf OntoSolrData.tgz;rm /data/OntoSolr/OntoSolrData.tgz"
echo "Updating OntoSolr index on $1 finished!"

/rgd/bin/run_on_server.sh $1 rgdpub "touch /usr/local/tomcat/webapps/OntoSolr.war;touch /usr/local/tomcat/webapps/phenotypes.war"
echo "Restarted OntoSolr and phenominer web apps on tomcat on $1"
