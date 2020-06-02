#!/bin/sh
. /etc/profile
source ~/.bashrc

APPHOME=/rgd/OntoSolr/bin
cd $APPHOME

set -e

$APPHOME/create_ontosolr_index.sh

echo "--UPDATE ALL SERVERS"
$APPHOME/update_all_servers.sh

echo "DONE!"
 
