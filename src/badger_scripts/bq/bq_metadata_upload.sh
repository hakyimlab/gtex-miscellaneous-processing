#!/usr/bin/env bash
#PBS -N phenomexcan_metadata_bq_upload
#PBS -S /bin/bash
#PBS -l walltime=1:00:00
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


echo "Loading expression spredixcan expression"
load_bq_f_4 \
/scratch/meliao/multixcan/phenotype_info \
gs://tempo-imlab/upload-bigquery/phenomexcan_metadata \
gtex-awg-im:GTEx_V8_ElasticNet_EUR_phenomexcan_v1.metadata \
phenotype:STRING,description:STRING,variable_type:STRING,source:STRING,n_non_missing:INTEGER,n_missing:INTEGER,n_controls:INTEGER,n_cases:INTEGER,PHESANT_transformation:STRING,notes:STRING