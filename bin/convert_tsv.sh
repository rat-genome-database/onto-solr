
java -cp /rgd/lib/rgd-text-mining-tools.jar \
  edu.mcw.rgd.nlp.utils.solr.DocConverter \
  /data/OntoSolr_data/onto_solr.tsv /data/OntoSolr_data/onto_solr.xml

java -cp /rgd/lib/rgd-text-mining-tools.jar \
  edu.mcw.rgd.nlp.utils.solr.DocConverter \
  /data/OntoSolr_data/onto_solr_genes.tsv /data/OntoSolr_data/onto_solr_genes.xml

java -cp /rgd/lib/rgd-text-mining-tools.jar \
  edu.mcw.rgd.nlp.utils.solr.DocConverter \
  /data/OntoSolr_data/XP_solr.tsv /data/OntoSolr_data/XP_solr.xml
  
