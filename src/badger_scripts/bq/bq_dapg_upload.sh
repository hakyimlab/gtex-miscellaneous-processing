#!/usr/bin/env bash

module load gcc/6.2.0 python/2.7.13


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
gsutil -m cp -r $1  $2
echo "bq"
load_bq $3 \
"$2/*"  \
$4
echo "cleaning up"
gsutil -m rm -r $2
}

#
#echo "Loading cluster correlations"
#load_bq_f_2 /scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/cluster_correlations \
#gtex-awg-im:GTEx_V8_DAPG.cluster_correlations_eqtl_eur \
#gene:STRING,id1:INTEGER,id2:INTEGER,value:FLOAT,tissue:STRING
#
#echo "Loading clusters"
#load_bq_f_2 /scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/clusters \
#gs://tempo-imlab/upload-bigquery/dapg_eqtl_eur/clusters \
#gtex-awg-im:GTEx_V8_DAPG.clusters_eqtl_eur \
#gene:STRING,cluster:INTEGER,n_snps:INTEGER,pip:FLOAT,average_r2:FLOAT,tissue:STRING
#
#
#echo "Loading model summary"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/model_summary \
#gs://tempo-imlab/upload-bigquery/dapg_eqtl_eur/model_summary \
#gtex-awg-im:GTEx_V8_DAPG.model_summary_eqtl_eur \
#gene:STRING,pes:FLOAT,pes_se:FLOAT,log_nc:FLOAT,log10_nc:FLOAT,tissue:STRING
#
#echo "Loading models"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/models \
#gs://tempo-imlab/upload-bigquery/dapg_eqtl_eur/models \
#gtex-awg-im:GTEx_V8_DAPG.models_eqtl_eur \
#gene:STRING,model:INTEGER,n:INTEGER,pp:FLOAT,ps:FLOAT,tissue:STRING
#
#echo "Loading model variants"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/models_variants \
#gs://tempo-imlab/upload-bigquery/dapg_eqtl_eur/models_variants \
#gtex-awg-im:GTEx_V8_DAPG.model_variants_eqtl_eur \
#gene:STRING,model:INTEGER,variant:STRING,tissue:STRING
#
#echo "Loading variants pip"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/variants_pip \
#gs://tempo-imlab/upload-bigquery/dapg_eqtl_eur/variants_pip \
#gtex-awg-im:GTEx_V8_DAPG.variants_pip_eqtl_eur \
#gene:STRING,rank:INTEGER,variant_id:STRING,pip:FLOAT,log10_abf:FLOAT,cluster_id:INTEGER,tissue:STRING
#
#echo "Loading enloc eqtl"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/enloc_eur/enloc_eur \
#gs://tempo-imlab/upload-bigquery/enloc_eqtl_eur \
#gtex-awg-im:GTEx_V8_ENLOC.enloc_eqtl_eur \
#gwas_locus:STRING,molecular_qtl_trait:STRING,locus_gwas_pip:FLOAT,locus_rcp:FLOAT,lead_coloc_SNP:STRING,lead_snp_rcp:FLOAT,phenotype:STRING,tissue:STRING

echo "Loading gwas"
load_bq_f_2 \
/scratch/abarbeira3/v8_process/bq/gwas/gwas_clean \
gs://tempo-imlab/upload-bigquery/gwas \
gtex-awg-im:GWAS_all.gwas \
variant_id:STRING,panel_variant_id:STRING,chromosome:STRING,position:INTEGER,effect_allele:STRING,non_effect_allele:STRING,current_build:STRING,frequency:FLOAT,sample_size:INTEGER,zscore:FLOAT,pvalue:FLOAT,effect_size:FLOAT,standard_error:FLOAT,imputation_status:STRING,n_cases:INTEGER,phenotype:STRING