#!/bin/bash
#PBS -N test_coloc
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_a/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_a/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load R/3.4.1
module load python/3.5.3


export MKL_NUM_THREADS=1
export OPEN_BLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1

cd $PBS_O_WORKDIR

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/run_susier.py \
-parquet_genotype_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/ \
-parquet_genotype_metadata /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.variants_metadata.parquet \
-parquet_genotype_pattern "gtex_v8_eur_itm.(chr\d+).variants.parquet" \
-eqtl /gpfs/data/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_all_associations/Muscle_Skeletal.allpairs.txt.gz \
-sample_size 706 \
-parsimony 8 \
-MAX_N 10 \
-cs_output results/cs_Muscle_Skeletal.txt.gz \
-var_output results/var_Muscle_Skeletal.txt.gz

#-MAX_N 5 \
#-gwas_sample_size 253288 \#!/usr/bin/env bash