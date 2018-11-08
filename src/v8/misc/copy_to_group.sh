#!/bin/bash
#PBS -N move
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=72:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err


cp /scratch/abarbeira3/v8_process/vcf_process/gtex_v8_freq.txt.gz \
/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet

cp /scratch/abarbeira3/v8_process/vcf_process_2/gtex_v8_eur_filtered.txt.gz \
/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet