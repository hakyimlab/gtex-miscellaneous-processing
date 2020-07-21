#!/bin/bash
#PBS -N upload_gwas
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=32gb
#PBS -o logs_u/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_u/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/2.7.13


cd $PBS_O_WORKDIR

gsutil -u GTEx-AWG-Im cp -a public-read harmonized_imputed_gwas.tar gs://gtex-gwas-public/gwas/harmonized_imputed_gwas.tar
