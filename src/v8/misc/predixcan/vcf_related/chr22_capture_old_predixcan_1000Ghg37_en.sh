#!/usr/bin/env bash
#PBS -N chr22_old_predixcan_vcfhg37_en
#PBS -S /bin/bash
#PBS -l walltime=32:00:00
#PBS -l mem=8gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_old_predixcan/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_old_predixcan/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0 python/3.5.3

cd $PBS_O_WORKDIR

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/PrediXcan/Software/kk_PrediXcan.py \
--predict \
--samples /scratch/abarbeira3/data/1000G_hg37_dosage_chr22/samples.txt \
--dosages /scratch/abarbeira3/data/1000G_hg37_dosage_chr22 \
--weights /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/elastic_net_models/en_Whole_Blood.db \
--only_genes  ENSG00000099991.17 \
--capture kk/capture_old.txt.gz \
--output_prefix kk_c/Whole_Blood
