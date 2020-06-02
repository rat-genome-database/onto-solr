#!/bin/sh

echo "--Creating tar ball for OntoSolr"
ONTOSOLR_TGZ=/data/OntoSolr_data/OntoSolrData.tgz

rm -f $ONTOSOLR_TGZ
pushd /data/OntoSolr
tar -czf $ONTOSOLR_TGZ *
popd
echo "--OntoSolr tar ball created at $ONTOSOLR_TGZ"


./update_Onto_Solr.sh hansen $ONTOSOLR_TGZ
./update_Onto_Solr.sh reed $ONTOSOLR_TGZ

./update_Onto_Solr.sh owen $ONTOSOLR_TGZ
./update_Onto_Solr.sh hancock $ONTOSOLR_TGZ
