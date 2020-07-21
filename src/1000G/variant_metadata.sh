#!/bin/bash
#PBS -N job_1000G_EUR_variant_metadata
#PBS -S /bin/bash
#PBS -l walltime=08:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -o logs_vm/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_vm/${PBS_JOBNAME}.e${PBS_JOBID}.err
########################################################################################################################
#CRI submission dandruff

cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/1000G/variant_metadata.py