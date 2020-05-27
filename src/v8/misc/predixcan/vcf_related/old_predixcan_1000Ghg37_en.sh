#!/usr/bin/env bash
#PBS -N old_predixcan_vcfhg37_en
#PBS -S /bin/bash
#PBS -l walltime=32:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_old_predixcan/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_old_predixcan/${PBS_JOBNAME}.e${PBS_JOBID}.err

#export PREDIXCAN=/gpfs/data/im-lab/nas40t2/abarbeira/software/PrediXcan/Software
#module load gcc/6.2.0 python/3.5.3
#cd $PBS_O_WORKDIR

python3 $PREDIXCAN/PrediXcan.py \
--predict \
--samples /scratch/abarbeira3/data/1000G_hg37_dosage/samples.txt \
--dosages /scratch/abarbeira3/data/1000G_hg37_dosage \
--weights /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/elastic_net_models/en_Whole_Blood.db \
--output_prefix old_predixcan_vcfhg37_en/Whole_Blood
