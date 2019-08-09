#!/bin/bash
#PBS -N test_coloc
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l mem=4gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_a/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_a/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load R/3.4.1
module load python/3.5.3


cd $PBS_O_WORKDIR

#python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/run_coloc.py \
#-MAX_N 5 \
#-coloc_script /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/ncoloc.R \
#-gwas_mode pvalue \
#-gwas /gpfs/data/im-lab/nas40t2/Data/SummaryResults/imputed_gwas_hg38_1.1/imputed_GLGC_Mc_LDL.txt.gz \
#-eqtl_mode pvalue \
#-eqtl /gpfs/data/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_all_associations/Liver.allpairs.txt.gz \
#-gwas_sample_size FROM_GWAS \
#-eqtl_sample_size 208 \
#-p1 2.37567e-05 \
#-p2 0.00161594 \
#-p12 3.0885e-06 \
#-output kk.txt.gz \
#-parsimony 8 # > /dev/null

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/run_coloc.py \
-coloc_script /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/ncoloc.R \
-gwas_mode pvalue \
-gwas /gpfs/data/im-lab/nas40t2/Data/SummaryResults/imputed_gwas_hg38_1.1/imputed_GIANT_HEIGHT.txt.gz \
-eqtl_mode pvalue \
-eqtl /gpfs/data/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_all_associations/Muscle_Skeletal.allpairs.txt.gz \
-gwas_sample_size FROM_GWAS \
-eqtl_sample_size 706 \
-p1 0.000115994 \
-p2 0.00283586 \
-p12 1.25297e-05 \
-parsimony 8 \
-output results/GIANT_HEIGHT__PM__Muscle_Skeletal.txt.gz > /dev/null

#-MAX_N 5 \
#-gwas_sample_size 253288 \