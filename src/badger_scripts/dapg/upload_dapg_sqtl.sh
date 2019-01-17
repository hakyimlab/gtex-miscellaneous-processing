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

gsutil cp -a public-read results/compressed_dapg_maf0.01_w1000000/*.tar.gz gs://gtex-gwas-share/dapg/sqtl
