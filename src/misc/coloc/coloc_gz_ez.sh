#!/usr/bin/env bash
#PBS -N gz_ez
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=16:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load R/3.4.1
module load python/3.5.3

#module load miniconda3

#source activate pyr

cd $PBS_O_WORKDIR

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/run_coloc.py \
-gwas /gpfs/data/im-lab/nas40t2/Data/SummaryResults/imputed_gwas_hg38_1.1/imputed_GLGC_Mc_LDL.txt.gz \
-gwas_mode zscore_1 \
-eqtl /gpfs/data/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_all_associations/Liver.allpairs.txt.gz \
-eqtl_mode zscore_1 \
-gwas_sample_size FROM_GWAS \
-eqtl_sample_size 208 \
-p1 0.0001 \
-p2 0.0001 \
-p12 0.00001 \
-output results/d_gz_ez.gz \
-MAX_N 1000 \
-parsimony 9


#-gwas_sample_size 188578 \