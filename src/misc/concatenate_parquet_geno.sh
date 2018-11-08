#!/bin/bash
#PBS -N job_concatenate
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=12:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=512gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR
module load gcc/6.2.0
module load python/3.5.3
#module load miniconda3
#source activate numa_cri

python3  concatenate_parquet_geno.py