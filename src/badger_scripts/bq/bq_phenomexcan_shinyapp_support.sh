#!/usr/bin/env bash

module load gcc/6.2.0 python/2.7.13



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

load_bq_file()
{
echo "uploading"
gsutil -q -m cp  $1  $2
echo "bq"
load_bq $3 \
$2  \
$4
echo "cleaning up"
gsutil -q -m rm  $2
}

###############################################################################

#echo "Loading smultixcan pairs"
#load_bq_file \
#/gpfs/data/im-lab/nas40t2/miltondp/phenomexcan/shiny/smultixcan_vs_clinvar-z2_avg-mashr.tsv.gz \
#gs://tempo-imlab/upload-bigquery/tmp/phenomexcan/shiny/smultixcan_vs_clinvar-z2_avg-mashr.tsv.gz \
#gtex-awg-im:GTEx_V8_UKB_PhenomeXcan.smultixcan_mashr_pairs_eqtl \
#ukb_trait:STRING,clinvar_trait:STRING,z2_avg:FLOAT,sqrt_z2_avg:FLOAT,gene_ids:STRING,gene_names:STRING

echo "Loading gene annot"
load_bq_file \
/gpfs/data/im-lab/nas40t2/miltondp/phenomexcan/shiny/genes_mappings.tsv.gz \
gs://tempo-imlab/upload-bigquery/tmp/phenomexcan/shiny/genes_mappings.tsv.gz \
gtex-awg-im:GTEx_V8_UKB_PhenomeXcan.genes_metadata \
gene:STRING,genename:STRING,gene_id:STRING,band:STRING