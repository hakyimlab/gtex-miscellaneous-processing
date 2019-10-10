#!/usr/bin/env bash
#PBS -N second_upload
#PBS -S /bin/bash
#PBS -l walltime=20:00:00
#PBS -l mem=4gb
#PBS -l nodes=1:ppn=1
#PBS -o logs_other/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_other/${PBS_JOBNAME}.e${PBS_JOBID}.err

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
echo "bqc"
load_bq $3 \
"$2/*"  \
$4
echo "cleaning up"
gsutil -q -m rm -r $2
}


echo "Loading expression smultixcan expression"
load_bq_f_4 \
/scratch/meliao/smultixcan_mashr/converted \
gs://tempo-imlab/upload-bigquery/smultixcan_mashr \
gtex-awg-im:GTEx_V8_UKB_PhenomeXcan.smultixcan_mashr_eqtl_v2 \
gene:STRING,gene_name:STRING,p_value:FLOAT,n:FLOAT,n_indep:FLOAT,p_i_best:FLOAT,t_i_best:STRING,p_i_worst:FLOAT,t_i_worst:STRING,eigen_max:FLOAT,eigen_min:FLOAT,eigen_min_kept:FLOAT,z_min:FLOAT,z_max:FLOAT,z_mean:FLOAT,z_sd:FLOAT,tmi:FLOAT,status:FLOAT,phenotype:STRING
