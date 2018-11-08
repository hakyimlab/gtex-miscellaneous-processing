#!/bin/bash
#PBS -N upload_covariances
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -o logs_u/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_u/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load miniconda2

source activate numa_gc

cd $PBS_O_WORKDIR

#Yes, my 1.1 is 1.2 on bucket
gsutil cp -a public-read /gpfs/data/im-lab/nas40t2/Data/SummaryResults/imputed_gwas_hg38_1.1/*.txt.gz gs://gtex-gwas-share/gwas-imputed/processed_summary_imputation_v1.2


