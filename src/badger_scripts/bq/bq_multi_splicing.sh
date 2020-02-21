#!/usr/bin/env bash

module load gcc/6.2.0 python/3.5.3


#bq --location=US mk \
#--dataset \
#--default_table_expiration 0 \
#--default_partition_expiration 0 \
#--description description \
#project_id:dataset

########################################################################################################################
load_bq()
{
    # $1 table
    # $2 file
    # $3 schema
    bq --location=US load --source_format=CSV \
    --null_marker=NA  --skip_leading_rows=1 --field_delimiter "\t" \
    $1 \
    $2 \
    $3

}

load_bq_f()
{
for f in $1/*
do
echo $f
load_bq \
$2 \
$f \
$3
done
}

load_bq_f_2()
{
echo "uploading"
gsutil -q -m cp -r $1  $2
echo "bq"
load_bq $3 \
"$2/*"  \
$4
echo "cleaning up"
gsutil -q -m rm -r $2
}

########################################################################################################################
load_bq_c()
{
    # $1 table
    # $2 file
    # $3 schema
    # $4 delimiter
    bq --location=US load --source_format=CSV \
    --null_marker=NA  --skip_leading_rows=1  \
    $1 \
    $2 \
    $3
}

load_bq_f_4()
{
echo "uploading"
gsutil -q -m cp -r $1  $2
echo "bqc"
load_bq_c $3 \
"$2/*"  \
$4
echo "cleaning up"
gsutil -q -m rm -r $2
}

echo "Loading intron id mapping"
load_bq_f_2 \
/scratch/abarbeira3/v8_process/bq/intron_id_mapping \
gs://tempo-imlab/upload-bigquery/tmp/intron_id_mapping  \
gtex-awg-im:annotations.intron_id_mapping \
gtex_intron_id:STRING,gene_id:STRING,intron_id:STRING,cluster_id:STRING,tissue:STRING


#echo "Loading grouped smultixcan sqtl"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/grouped_smultixcan/mashr \
#gs://tempo-imlab/upload-bigquery/tmp/grouped_smultixcan/mashr  \
#gtex-awg-im:GTEx_v8_e_s_QTL.grouped_smultixcan \
#group:STRING,pvalue:FLOAT,n_variants:INTEGER,n_features:INTEGER,n_indep:INTEGER,tmi:FLOAT,status:STRING,tissue:STRING,phenotype:STRING


