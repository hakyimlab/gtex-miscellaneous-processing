#!/bin/bash
#PBS -N job_1000g_conversion
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -t 1-22
########################################################################################################################
#CRI submission dandruff

#cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/geuvadis/match_to_gtex.py \
-key_map /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/varians.txt.gz \
-input /scratch/abarbeira3/data/1000G_C/chr${PBS_ARRAYID}.txt.gz \
-output /scratch/abarbeira3/data/1000G_M/chr${PBS_ARRAYID}.txt.gz
