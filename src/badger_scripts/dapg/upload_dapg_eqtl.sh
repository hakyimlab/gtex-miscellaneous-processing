#!/bin/bash
#PBS -N upload_fdapg_eqtl
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -o logs_u/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_u/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0 python/2.7.13

cd $PBS_O_WORKDIR

gsutil cp -a public-read results/packed/dapg_eur/*.tar.gz gs://gtex-gwas-share/dapg/eqtl
