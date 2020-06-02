#!/bin/sh
. /etc/profile
source ~/.bashrc

host=`hostname`
if [ "$host" != "garak.rgd.mcw.edu" ]; then
  echo "This is $host. Please run it on garak.rgd.mcw.edu."
  exit 1
fi

APPHOME=/rgd/OntoSolr/bin
ONTODATA=/data/OntoSolr_data

cd $APPHOME

echo "--EXPORTING TERMS to .tsv file"
RESULT=`/rgd/bin/run_sql $APPHOME/export_ontology_terms_from_RGD.sql $ONTODATA/onto_solr.tsv`
echo "$RESULT"
#convert multiline result into array; last line contains nr of rows written to the file
arr=()
mapfile -t arr <<< "$RESULT"
LASTINDEX=$(( ${#arr[@]} - 1 ))
TCOUNT="${arr[ LASTINDEX ]}"
if [ "$TCOUNT" -le "0" ]; then
  echo "ERROR: ontology terms export failed -- aborting script   TCOUNT=$TCOUNT"
  exit -1
fi

echo "--EXPORTING GENES to .tsv file"
/rgd/bin/run_sql $APPHOME/get_genes.sql $ONTODATA/onto_solr_genes.tsv.unsorted
sort -ro $ONTODATA/onto_solr_genes.tsv $ONTODATA/onto_solr_genes.tsv.unsorted

echo "--EXPORTING HP terms as XP to .tsv file"
/rgd/bin/run_sql $APPHOME/export_HP_terms_from_RGD.sql $ONTODATA/HP_solr.tsv
sed 's/HP/XP/g' $ONTODATA/HP_solr.tsv > $ONTODATA/XP_solr.tsv

echo "--EXPORTING HP to RDO mappings"
/rgd/bin/run_sql $APPHOME/HP_and_RDO_mapped.sql $ONTODATA/HP_and_RDO_mapped.tsv
awk -F '\t' '{print "\<query\>id:(\"" $1 "\")\</query\>"}' $ONTODATA/HP_and_RDO_mapped.tsv |sed 's/HP/XP/g' > del_redundant_XP_tmp.xml
echo '<delete>' > del_redundant_XP.xml
cat del_redundant_XP_tmp.xml >> del_redundant_XP.xml
echo '</delete>' >> del_redundant_XP.xml

echo "--CONVERT .tsv to .xml"
$APPHOME/convert_tsv.sh

echo "--SOLR INDEXING"
$APPHOME/index_terms.sh  
if [ $? -ne 0 ]; then
  echo "ERROR: solr indexing failed!"
  exit 1
fi

# call here update_all_servers.sh or update_servers_except_prod.sh
 
