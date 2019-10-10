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

#
#echo "Loading expression endapgw extra"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/models/expression/en_dapgw/extra \
#gs://tempo-imlab/upload-bigquery/models/expression/en_dapgw/extra \
#gtex-awg-im:GTEx_V8_ENDAPGW_EUR_v1.extra_eqtl \
#gene:STRING,genename:STRING,gene_type:STRING,alpha:FLOAT,n_snps_in_window:INTEGER,n_snps_in_model:INTEGER,test_R2_avg:FLOAT,test_R2_sd:FLOAT,cv_R2_avg:FLOAT,cv_R2_sd:FLOAT,in_sample_R2:FLOAT,nested_cv_fisher_pval:FLOAT,nested_cv_converged:INTEGER,rho_avg:FLOAT,rho_se:FLOAT,rho_zscore:FLOAT,pred_perf_R2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,tissue:STRING
#
#echo "Loading expression endapgw weights"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/models/expression/en_dapgw/weights \
#gs://tempo-imlab/upload-bigquery/models/expression/en_dapgw/weights \
#gtex-awg-im:GTEx_V8_ENDAPGW_EUR_v1.weights_eqtl \
#gene:STRING,rsid:STRING,varID:STRING,ref_allele:STRING,eff_allele:STRING,weight:FLOAT,tissue:STRING


#echo "Loading splicing endapgw extra"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/models/splicing/en_dapgw/extra \
#gs://tempo-imlab/upload-bigquery/models/splicing/en_dapgw/extra \
#gtex-awg-im:GTEx_V8_ENDAPGW_EUR_v1.extra_sqtl \
#gene:STRING,genename:STRING,gene_type:STRING,alpha:FLOAT,n_snps_in_window:INTEGER,n_snps_in_model:INTEGER,test_R2_avg:FLOAT,test_R2_sd:FLOAT,cv_R2_avg:FLOAT,cv_R2_sd:FLOAT,in_sample_R2:FLOAT,nested_cv_fisher_pval:FLOAT,nested_cv_converged:INTEGER,rho_avg:FLOAT,rho_se:FLOAT,rho_zscore:FLOAT,pred_perf_R2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,tissue:STRING


#echo "Loading splicing endapgw weights"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/models/splicing/en_dapgw/weights \
#gs://tempo-imlab/upload-bigquery/models/splicing/en_dapgw/weights \
#gtex-awg-im:GTEx_V8_ENDAPGW_EUR_v1.weights_sqtl \
#gene:STRING,rsid:STRING,varID:STRING,ref_allele:STRING,eff_allele:STRING,weight:FLOAT,tissue:STRING

#
#echo "Loading expression spredixcan endapgw"
#load_bq_f_4 \
#/scratch/abarbeira3/v8_process/bq/predixcan/eqtl/endapgw \
#gs://tempo-imlab/upload-bigquery/predixcan/eqtl/endapgw \
#gtex-awg-im:GTEx_V8_ENDAPGW_EUR_v1.spredixcan_eqtl \
#gene:STRING,gene_name:STRING,zscore:FLOAT,effect_size:FLOAT,pvalue:FLOAT,var_g:FLOAT,pred_perf_r2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,n_snps_used:FLOAT,n_snps_in_cov:FLOAT,n_snps_in_model:FLOAT,best_gwas_p:FLOAT,largest_weight:FLOAT,phenotype:STRING,tissue:STRING

#echo "Loading splicing spredixcan endapgw"
#load_bq_f_4 \
#/scratch/abarbeira3/v8_process/bq/predixcan/sqtl/endapgw \
#gs://tempo-imlab/upload-bigquery/predixcan/sqtl/endapgw  \
#gtex-awg-im:GTEx_V8_ENDAPGW_EUR_v1.spredixcan_sqtl \
#gene:STRING,gene_name:STRING,zscore:FLOAT,effect_size:FLOAT,pvalue:FLOAT,var_g:FLOAT,pred_perf_r2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,n_snps_used:FLOAT,n_snps_in_cov:FLOAT,n_snps_in_model:FLOAT,best_gwas_p:FLOAT,largest_weight:FLOAT,phenotype:STRING,tissue:STRING

#echo "Loading expression smultixcan endapgw"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/smultixcan/eqtl/endapgw \
#gs://tempo-imlab/upload-bigquery/smultixcan/eqtl/endapgw \
#gtex-awg-im:GTEx_V8_ENDAPGW_EUR_v1.smultixcan_eqtl \
#gene:STRING,gene_name:STRING,pvalue:FLOAT,n:INTEGER,n_indep:INTEGER,p_i_best:FLOAT,t_i_best:STRING,p_i_worst:FLOAT,t_i_worst:STRING,eigen_max:FLOAT,eigen_min:FLOAT,eigen_min_kept:FLOAT,z_min:FLOAT,z_max:FLOAT,z_mean:FLOAT,z_sd:FLOAT,tmi:FLOAT,status:INTEGER,phenotype:STRING

#echo "Loading expression smultixcan endapgw"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/smultixcan/sqtl/endapgw \
#gs://tempo-imlab/upload-bigquery/smultixcan/sqtl/endapgw \
#gtex-awg-im:GTEx_V8_ENDAPGW_EUR_v1.smultixcan_sqtl \
#gene:STRING,gene_name:STRING,pvalue:FLOAT,n:INTEGER,n_indep:INTEGER,p_i_best:FLOAT,t_i_best:STRING,p_i_worst:FLOAT,t_i_worst:STRING,eigen_max:FLOAT,eigen_min:FLOAT,eigen_min_kept:FLOAT,z_min:FLOAT,z_max:FLOAT,z_mean:FLOAT,z_sd:FLOAT,tmi:FLOAT,status:INTEGER,phenotype:STRING
