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
--assoc --linear \
--samples samples.txt \
--dosages $DATA/1000G_hg37_dosage \
--weights $DATA/models/gtex_v8_en/en_Whole_Blood.db \
--pheno $DATA/1000G_hg37/random_pheno_1000G_hg37.txt --pheno_name pheno \
--output_prefix $RESULTS/old_predixcan_vcfhg37_en/Whole_Blood