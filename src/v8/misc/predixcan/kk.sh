#!/bin/bash
#PBS -N predixcan_Adipose_Subcutaneous
#PBS -S /bin/bash
#PBS -l walltime=6:00:00
#PBS -l mem=4gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_en_v6/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_en_v6/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/3.5.3

cd $PBS_O_WORKDIR 

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/PrediXcan/Software/kk_PrediXcan.py \
--predict \
--dosages /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage \
--samples /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage/samples.txt \
--weights /gpfs/data/im-lab/nas40t2/abarbeira/data/metaxcan/GTEx-V6p-HapMap-2016-09-08/TW_Adipose_Subcutaneous_0.5.db \
--only_genes  ENSG00000131795.8 \
--capture kk/capture_old.txt.gz \
--output_prefix kk/Adipose_Subcutaneous
