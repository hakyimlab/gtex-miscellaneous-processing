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

#echo "Loading cluster correlations"
#load_bq_f_2 /scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/cluster_correlations \
#gs://tempo-imlab/upload-bigquery/dapg_eur/cluster_correlations \
#gtex-awg-im:GTEx_V8_DAPG_EUR_v1.cluster_correlations_eqtl \
#gene:STRING,id1:INTEGER,id2:INTEGER,value:FLOAT,tissue:STRING

#echo "Loading clusters"
#load_bq_f_2 /scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/clusters \
#gs://tempo-imlab/upload-bigquery/dapg_eqtl_eur/clusters \
#gtex-awg-im:GTEx_V8_DAPG_EUR_v1.clusters_eqtl \
#gene:STRING,cluster:INTEGER,n_snps:INTEGER,pip:FLOAT,average_r2:FLOAT,tissue:STRING
#
#
#echo "Loading model summary"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/model_summary \
#gs://tempo-imlab/upload-bigquery/dapg_eqtl_eur/model_summary \
#gtex-awg-im:GTEx_V8_DAPG_v1.model_summary_eqtl \
#gene:STRING,pes:FLOAT,pes_se:FLOAT,log_nc:FLOAT,log10_nc:FLOAT,tissue:STRING
#
#echo "Loading models"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/models \
#gs://tempo-imlab/upload-bigquery/dapg_eqtl_eur/models \
#gtex-awg-im:GTEx_V8_DAPG_EUR_v1.models_eqtl \
#gene:STRING,model:INTEGER,n:INTEGER,pp:FLOAT,ps:FLOAT,tissue:STRING
#
#echo "Loading model variants"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/models_variants \
#gs://tempo-imlab/upload-bigquery/dapg_eqtl_eur/models_variants \
#gtex-awg-im:GTEx_V8_DAPG_EUR_v1.model_variants_eqtl \
#gene:STRING,model:INTEGER,variant:STRING,tissue:STRING
#
#echo "Loading variants pip"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/dapg/dapg_eur/variants_pip \
#gs://tempo-imlab/upload-bigquery/dapg_eqtl_eur/variants_pip \
#gtex-awg-im:GTEx_V8_DAPG_EUR_v1.variants_pip_eqtl \
#gene:STRING,rank:INTEGER,variant_id:STRING,pip:FLOAT,log10_abf:FLOAT,cluster_id:INTEGER,tissue:STRING
#
#echo "Loading expression elastic net extra"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/models/expression/extra \
#gs://tempo-imlab/upload-bigquery/models/expression/extra \
#gtex-awg-im:GTEx_V8_ElasticNet_EUR_v1.extra_eqtl \
#gene:STRING,genename:STRING,gene_type:STRING,alpha:FLOAT,n_snps_in_window:INTEGER,n_snps_in_model:INTEGER,test_R2_avg:FLOAT,test_R2_sd:FLOAT,cv_R2_avg:FLOAT,cv_R2_sd:FLOAT,in_sample_R2:FLOAT,nested_cv_fisher_pval:FLOAT,nested_cv_converged:INTEGER,rho_avg:FLOAT,rho_se:FLOAT,rho_zscore:FLOAT,pred_perf_R2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,tissue:STRING
#
#echo "Loading expression elastic net weights"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/models/expression/weights \
#gs://tempo-imlab/upload-bigquery/models/expression/weights \
#gtex-awg-im:GTEx_V8_ElasticNet_EUR_v1.weights_eqtl \
#gene:STRING,rsid:STRING,varID:STRING,ref_allele:STRING,eff_allele:STRING,weight:FLOAT,tissue:STRING

###########################################
# SPLICING MODELS ARE OLDER THAN EXPRESSION!
#echo "Loading splicing elastic net extra"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/models/splicing/extra \
#gs://tempo-imlab/upload-bigquery/models/splicing/extra \
#gtex-awg-im:GTEx_V8_ElasticNet_EUR_v1.extra_sqtl \
#gene:STRING,genename:STRING,gene_type:STRING,alpha:FLOAT,n_snps_in_window:INTEGER,n_snps_in_model:INTEGER,lambda_min_mse:FLOAT,test_R2_avg:FLOAT,test_R2_sd:FLOAT,cv_R2_avg:FLOAT,cv_R2_sd:FLOAT,in_sample_R2:FLOAT,nested_cv_fisher_pval:FLOAT,rho_avg:FLOAT,rho_se:FLOAT,rho_zscore:FLOAT,pred_perf_R2:FLOAT,pred_perf_pval:FLOAT,cv_rho_avg:FLOAT,cv_rho_se:FLOAT,cv_rho_avg_squared:FLOAT,cv_zscore_est:FLOAT,cv_zscore_pval:FLOAT,cv_pval_est:FLOAT,pred_perf_qval:FLOAT,tissue:STRING

#echo "Loading splicing elastic net weights"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/models/splicing/weights \
#gs://tempo-imlab/upload-bigquery/models/splicing/weights \
#gtex-awg-im:GTEx_V8_ElasticNet_EUR_v1.weights_sqtl \
#gene:STRING,rsid:STRING,varID:STRING,ref_allele:STRING,eff_allele:STRING,weight:FLOAT,tissue:STRING

#
#echo "Loading expression spredixcan expression"
#load_bq_f_4 \
#/scratch/abarbeira3/v8_process/bq/predixcan/eqtl \
#gs://tempo-imlab/upload-bigquery/predixcan/eqtl \
#gtex-awg-im:GTEx_V8_ElasticNet_EUR_v1.spredixcan_eqtl \
#gene:STRING,gene_name:STRING,zscore:FLOAT,effect_size:FLOAT,pvalue:FLOAT,var_g:FLOAT,pred_perf_r2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,n_snps_used:FLOAT,n_snps_in_cov:FLOAT,n_snps_in_model:FLOAT,best_gwas_p:FLOAT,largest_weight:FLOAT,phenotype:STRING,tissue:STRING

#echo "Loading expression spredixcan splicing"
#load_bq_f_4 \
#/scratch/abarbeira3/v8_process/bq/predixcan/sqtl \
#gs://tempo-imlab/upload-bigquery/predixcan/sqtl \
#gtex-awg-im:GTEx_V8_ElasticNet_EUR_v1.spredixcan_sqtl \
#gene:STRING,gene_name:STRING,zscore:FLOAT,effect_size:FLOAT,pvalue:FLOAT,var_g:FLOAT,pred_perf_r2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,n_snps_used:FLOAT,n_snps_in_cov:FLOAT,n_snps_in_model:FLOAT,best_gwas_p:FLOAT,largest_weight:FLOAT,phenotype:STRING,tissue:STRING

#echo "Loading expression smultixcan expression"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/smultixcan/eqtl \
#gs://tempo-imlab/upload-bigquery/smultixcan/eqtl \
#gtex-awg-im:GTEx_V8_ElasticNet_EUR_v1.smultixcan_eqtl \
#gene:STRING,gene_name:STRING,pvalue:FLOAT,n:INTEGER,n_indep:INTEGER,p_i_best:FLOAT,t_i_best:STRING,p_i_worst:FLOAT,t_i_worst:STRING,eigen_max:FLOAT,eigen_min:FLOAT,eigen_min_kept:FLOAT,z_min:FLOAT,z_max:FLOAT,z_mean:FLOAT,z_sd:FLOAT,tmi:FLOAT,status:INTEGER,phenotype:STRING

#echo "Loading expression smultixcan splicing"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/smultixcan/sqtl \
#gs://tempo-imlab/upload-bigquery/smultixcan/sqtl \
#gtex-awg-im:GTEx_V8_ElasticNet_EUR_v1.smultixcan_sqtl \
#gene:STRING,gene_name:STRING,pvalue:FLOAT,n:INTEGER,n_indep:INTEGER,p_i_best:FLOAT,t_i_best:STRING,p_i_worst:FLOAT,t_i_worst:STRING,eigen_max:FLOAT,eigen_min:FLOAT,eigen_min_kept:FLOAT,z_min:FLOAT,z_max:FLOAT,z_mean:FLOAT,z_sd:FLOAT,tmi:FLOAT,status:INTEGER,phenotype:STRING


#
#echo "Loading enloc eqtl"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/enloc/eqtl \
#gs://tempo-imlab/upload-bigquery/enloc/eqtl \
#gtex-awg-im:GTEx_V8_ENLOC_v1.enloc_eqtl_eur \
#gwas_locus:STRING,molecular_qtl_trait:STRING,locus_gwas_pip:FLOAT,locus_rcp:FLOAT,lead_coloc_SNP:STRING,lead_snp_rcp:FLOAT,phenotype:STRING,tissue:STRING

#echo "Loading enloc sqtl"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/enloc/sqtl \
#gs://tempo-imlab/upload-bigquery/enloc/sqtl \
#gtex-awg-im:GTEx_V8_ENLOC_v1.enloc_sqtl_eur \
#gwas_locus:STRING,molecular_qtl_trait:STRING,locus_gwas_pip:FLOAT,locus_rcp:FLOAT,lead_coloc_SNP:STRING,lead_snp_rcp:FLOAT,phenotype:STRING,tissue:STRING

#echo "Loading gwas"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/gwas/gwas_clean \
#gs://tempo-imlab/upload-bigquery/gwas \
#gtex-awg-im:GWAS_all.gwas \
#variant_id:STRING,panel_variant_id:STRING,chromosome:STRING,position:INTEGER,effect_allele:STRING,non_effect_allele:STRING,current_build:STRING,frequency:FLOAT,sample_size:INTEGER,zscore:FLOAT,pvalue:FLOAT,effect_size:FLOAT,standard_error:FLOAT,imputation_status:STRING,n_cases:INTEGER,phenotype:STRING

#echo "Loading harmonized gwas"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/gwas/formatted_gwas \
#gs://tempo-imlab/upload-bigquery/formatted_gwas \
#gtex-awg-im:GWAS_all.formatted_gwas \
#variant_id:STRING,panel_variant_id:STRING,chromosome:STRING,position:INTEGER,effect_allele:STRING,non_effect_allele:STRING,frequency:FLOAT,pvalue:FLOAT,zscore:FLOAT,effect_size:FLOAT,standard_error:FLOAT,sample_size:INTEGER,n_cases:INTEGER,phenotype:STRING

#echo "Loading gwas imputation verification"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/gwas/gwas_imputation_verification_clean \
#gs://tempo-imlab/upload-bigquery/gwas_imputation_verification_clean \
#gtex-awg-im:GWAS_all.gwas_imputation_verification \
#variant_id:STRING,panel_variant_id:STRING,chromosome:STRING,position:INTEGER,effect_allele:STRING,non_effect_allele:STRING,current_build:STRING,frequency:FLOAT,sample_size:INTEGER,zscore:FLOAT,pvalue:FLOAT,effect_size:FLOAT,standard_error:FLOAT,imputation_status:STRING,n_cases:INTEGER,phenotype:STRING
