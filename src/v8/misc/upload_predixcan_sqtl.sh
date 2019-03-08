#!/bin/bash
#PBS -N upload_covariances
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -o logs_u/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_u/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/2.7.13


echo "predixcan"

#zcat /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/spredixcan/results/sp_imputed_gwas_gtexv8_en_splicing.csv.gz >

gsutil cp -a public-read \
/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/spredixcan/results/sp_imputed_gwas_gtexv8_en_splicing.csv \
gs://predixcan/sp_imputed_gwas_gtexv8_en_splicing.csv

bq --location=US load --source_format=CSV \
--null_marker=NA  --skip_leading_rows=1 \
gtex-awg-im:GTEX_V8_ElasticNet_EUR_Splicing_2018_11_19.predixcan_results \
gs://predixcan/sp_imputed_gwas_gtexv8_en_splicing.csv \
gene:STRING,gene_name:STRING,zscore:FLOAT,effect_size:FLOAT,pvalue:FLOAT,var_g:FLOAT,pred_perf_r2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,n_snps_used:INTEGER,n_snps_in_cov:INTEGER,n_snps_in_model:INTEGER,best_gwas_p:FLOAT,largest_weight:FLOAT,trait:STRING,tissue:STRING


echo "extra"

#gsutil cp -a public-read \
#/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/elastic_net_models_splicing/a_extra.csv.gz \
#gs://predixcan/models_splicing_extra.csv.gz
#
#bq --location=US load --source_format=CSV \
#--null_marker=NA  --skip_leading_rows=1 \
#gtex-awg-im:GTEX_V8_ElasticNet_EUR_Splicing_2018_11_19.models_extra \
#gs://predixcan/models_splicing_extra.csv.gz \
#gene:STRING,genename:STRING,gene_type:STRING,alpha:FLOAT,n_snps_in_window:INTEGER,n_snps_in_model:INTEGER,lambda_min_mse:FLOAT,test_R2_avg:FLOAT,test_R2_sd:FLOAT,cv_R2_avg:FLOAT,cv_R2_sd:FLOAT,in_sample_R2:FLOAT,nested_cv_fisher_pval:FLOAT,rho_avg:FLOAT,rho_se:FLOAT,rho_zscore:FLOAT,pred_perf_R2:FLOAT,pred_perf_pval:FLOAT,cv_rho_avg:FLOAT,cv_rho_se:FLOAT,cv_rho_avg_squared:FLOAT,cv_zscore_est:FLOAT,cv_zscore_pval:FLOAT,cv_pval_est:FLOAT,pred_perf_qval:FLOAT,tissue:STRING


echo "weights"

#gsutil cp -a public-read \
#/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/elastic_net_models_splicing/a_weights.csv.gz \
#gs://predixcan/models_splicing_weights.csv.gz

#bq --location=US load --source_format=CSV \
#--null_marker=NA  --skip_leading_rows=1 \
#gtex-awg-im:GTEX_V8_ElasticNet_EUR_Splicing_2018_11_19.models_weights \
#gs://predixcan/models_splicing_weights.csv.gz \
#gene:STRING,rsid:STRING,varID:STRING,ref_allele:STRING,eff_allele:STRING,weight:FLOAT,tissue:STRING

