#!/bin/sh
. /etc/profile
source ~/.bashrc

APPHOME=/rgd/OntoSolr/bin
cd $APPHOME

set -e

$APPHOME/create_ontosolr_index.sh > $APPHOME/daily.log

$APPHOME/update_servers_except_prod.sh >> $APPHOME/daily.log

# tr id '\r' removes CR characters from daily.log, in order Outlook display the summary email properly
cat $APPHOME/daily.log  |  tr -d '\r'  |  mailx -s "[GARAK] OntoSolr daily" mtutaj@mcw.edu

 
