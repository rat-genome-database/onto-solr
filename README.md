# ont-solr

Set of scripts to update OntoSolr application: data used to populate type-ahead popups in rgd web application.

do_all.sh - the master script to run weekly, right after the data release;
  creates the OntoSolr index on text-mining app server (currently GARAK) and copies it also to RGD servers: DEV, PIPELINES and PROD
  
do_daily.sh - secondary script to run daily, overnight;
  creates the OntoSolr index on text-mining app server and copies it to some RGD servers: DEV and PIPELINES

