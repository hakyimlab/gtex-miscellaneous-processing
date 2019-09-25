#!/usr/bin/env bash
#PBS -N test_phenomexcan_bq_upload
#PBS -S /bin/bash
#PBS -l walltime=120:00:00
#PBS -l mem=4gb
#PBS -l nodes=1:ppn=1
#PBS -o upload_logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e upload_logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/2.7.13
cd $PBS_O_WORKDIR

PATH=$PATH:/home/meliao/google-cloud-sdk/bin/
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


echo "Loading expression spredixcan expression"
load_bq_f_4 \
/scratch/meliao/phenomexcan_converted \
gs://tempo-imlab/upload-bigquery/phenomexcan \
gtex-awg-im:GTEx_V8_ElasticNet_EUR_phenomexcan_v1.spredixcan_v2 \
gene:STRING,gene_name:STRING,zscore:FLOAT,effect_size:FLOAT,pvalue:FLOAT,var_g:FLOAT,pred_perf_r2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,n_snps_used:FLOAT,n_snps_in_cov:FLOAT,n_snps_in_model:FLOAT,phenotype:STRING,tissue:STRING
