#!/bin/bash
#PBS -N upload_sqtl_split
#PBS -S /bin/bash
#PBS -l walltime=4:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs_u/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_u/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/2.7.13


cd $PBS_O_WORKDIR

gsutil cp -a public-read "results_pp/*.txt.gz" gs://cluster_data_central/sqtl/split/
