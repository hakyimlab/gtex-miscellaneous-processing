#!/bin/b-folder /scratch/abarbeira3/v8_process/summary_imputation_by_region_3/cr_0.0000001/results_summary_imputation/ \
-pattern "50_Standing_height*" \
-output results/50_standing_height_imputed_cr_0.0000001.txt.gzash
#PBS -N collect
#PBS -S /bin/bash
#PBS -l walltime=4:00:00
#PBS -l mem=16gb
#PBS -l nodes=1:ppn=1
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/3.5.3

cd $PBS_O_WORKDIR

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/gwas_summary_imputation_collect.py \
-gwas_file /scratch/abarbeira3/data/GWAS/50_Standing_height.txt.gz \
-folder /scratch/abarbeira3/v8_process/summary_imputation/normalised/results_summary_imputation/ \
-pattern "50_Standing_height*" \
-output 50_standing_height_imputed_nd_cr0.1.txt.gz

