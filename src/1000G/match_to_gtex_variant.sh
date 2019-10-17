#!/bin/bash
#PBS -N job_1000gG_match_to_gtex_variant
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs_gv/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_gv/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -t 1-22
########################################################################################################################
#CRI submission dandruff

#cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/1000G/match_to_gtex_variant.py \
-key_map /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/varians.txt.gz \
-input /scratch/abarbeira3/data/1000G_GEUV_EUR/chr${PBS_ARRAYID}.txt.gz \
-output /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage_gtex_variant/chr${PBS_ARRAYID}.txt.gz
