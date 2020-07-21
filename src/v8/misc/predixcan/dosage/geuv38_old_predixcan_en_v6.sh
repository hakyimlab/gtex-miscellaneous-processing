#!/usr/bin/env bash
#PBS -N old_predixcan_vcfhg37_en
#PBS -S /bin/bash
#PBS -l walltime=32:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_old_predixcan/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_old_predixcan/${PBS_JOBNAME}.e${PBS_JOBID}.err

#cd $PBS_O_WORKDIR
module load gcc/6.2.0 python/3.5.3 R/3.4.1

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/PrediXcan/Software/PrediXcan.py \
--predict \
--samples samples.txt \
--dosages /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage \
--weights /gpfs/data/im-lab/nas40t2/abarbeira/data/metaxcan/GTEx-V6p-HapMap-2016-09-08/TW_Adipose_Subcutaneous_0.5.db  \
--output_prefix old_predixcan/en_geuv_v6