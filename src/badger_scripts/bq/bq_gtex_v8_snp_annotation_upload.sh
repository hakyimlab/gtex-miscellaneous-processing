#!/bin/bash


module load gcc/6.2.0
module load python/2.7.13

temp_storage=gs://tempo-imlab/upload-bigquery/gtex_variant_calls
db_table_name=gtex-awg-im:annotations.gtex_snp_annotations_test
file_path=/scratch/meliao/gtex_variant_calls
file_name=edited_GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.csv
schema=chr:STRING,variant_pos:INTEGER,variant_id:STRING,ref:STRING,alt:STRING,num_alt_per_site:INTEGER,rs_id_dbSNP150_GRCh38p7:STRING

PATH=$PATH:/home/meliao/google-cloud-sdk/bin/

echo ${schema}
echo "uploading ${file_path} now"

gsutil -q -m cp  ${file_path}/${file_name} ${temp_storage}

echo "uploading finished"

gsutil ls ${temp_storage}

echo "loading into big query"


bq \
  --location=US \
  load \
  --source_format=CSV \
  --field_delimiter=, \
  --null_marker=. \
  --skip_leading_rows=1 \
  ${db_table_name} \
  ${temp_storage} \
  ${schema}

gsutil -q -m rm -r ${temp_storage}
echo "Cleaned up ${temp_storage}"

#
#module load gcc/6.2.0
#module load python/2.7.13
#
#PATH=$PATH:/home/meliao/google-cloud-sdk/bin/
#load_bq_c()
#{
#    # $1 table
#    # $2 file
#    # $3 schema
#    # $4 delimiter
#    bq \
#    --location=US \
#    load \
#    --source_format=CSV \
#    --field_delimiter=\t \
#    --null_marker=NA  \
#    --skip_leading_rows=1  \
#    $1 \
#    $2 \
#    $3
#}
#
#load_bq()
#{
#    # $1 table
#    # $2 file
#    # $3 schema
#    bq --location=US load --source_format=CSV \
#    --null_marker=.  --skip_leading_rows=1 --field_delimiter "\t" \
#    $1 \
#    $2 \
#    $3
#
#}
#
#load_bq_f_4()
#{
#echo "uploading"
#gsutil -q -m cp -r $1  $2
#echo "bqc"
#load_bq $3 \
#"$2/*"  \
#$4
#echo "cleaning up"
#gsutil -q -m rm -r $2
#}
#
#
#echo "Loading expression smultixcan expression"
#load_bq_f_4 \
#/scratch/meliao/gtex_variant_calls \
#gs://tempo-imlab/upload-bigquery/gtex_variant_calls \
#gtex-awg-im:annotations.gtex_snp_annotations \
#chr:STRING,variant_pos:INTEGER,variant_id:STRING,ref:STRING,alt:STRING,num_alt_per_site:INTEGER,rs_id_dbSNP150_GRCh38p7:STRING
