#!/usr/bin/env bash
#PBS -N test_upload
#PBS -S /bin/bash
#PBS -l walltime=4:00:00
#PBS -l mem=4gb
#PBS -l nodes=1:ppn=1
#PBS -o other_logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e other_logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

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
    bq \
    --location=US \
    load \
    --source_format=CSV \
    --field_delimiter=\t \
    --null_marker=NA  \
    --skip_leading_rows=1  \
    $1 \
    $2 \
    $3
}

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

load_bq_f_4()
{
echo "uploading"
gsutil -q -m cp -r $1  $2
echo "bq insertion"
load_bq $3 \
"$2/*"  \
$4
echo "cleaning up temp"
gsutil -q -m rm -r $2
}


echo "Loading spredixcan mashr eqtl"
load_bq_f_4 \
/scratch/meliao/spredixcan_mashr/test_converted \
gs://tempo-imlab/upload-bigquery/spredixcan_mashr \
gtex-awg-im:GTEx_V8_UKB_PhenomeXcan.spredixcan_mashr_eqtl_test \
gene:STRING,gene_name:STRING,zscore:FLOAT,effect_size:FLOAT,pvalue:FLOAT,var_g:FLOAT,pred_perf_r2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,n_snps_used:INTEGER,n_snps_in_cov:INTEGER,n_snps_in_model:INTEGER,best_gwas_p:FLOAT,largest_weight:FLOAT,phenotype:FLOAT,tissue:FLOAT

#gene:STRING,gene_name:STRING,p_value:FLOAT,n:FLOAT,n_indep:FLOAT,p_i_best:FLOAT,t_i_best:STRING,p_i_worst:FLOAT,t_i_worst:STRING,eigen_max:FLOAT,eigen_min:FLOAT,eigen_min_kept:FLOAT,z_min:FLOAT,z_max:FLOAT,z_mean:FLOAT,z_sd:FLOAT,tmi:FLOAT,status:FLOAT,phenotype:STRING
