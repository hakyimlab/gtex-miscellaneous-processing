#!/usr/bin/env bash
#PBS -N uncompress download
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=32:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

###############
# Meant to be run at destination folder

module load gcc/6.2.0
module load python/2.7.13

#source activate numa_gc
mkdir -p dapg/eqtl
gsutil cp gs://gtex-exchange/dapg/results_by_tissue/* dapg/eqtl

cd dapg
mkdir eqtl_u
for filename in eqtl/*.tar.gz; do
    k="${filename%_dapg_files.tar.gz}"
    k="${k#*/}"
    #echo $k
    tar -xzvpf "$filename" -C eqtl_u
done