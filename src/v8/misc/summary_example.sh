#!/bin/bash
#PBS -N summary_imputation
#PBS -S /bin/bash
#PBS -l walltime=120:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=32gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
########################################################################################################################
#CRI submission dandruff


module load gcc/6.2.0
module load python/3.5.3

cd $PBS_O_WORKDIR

#PQG=/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet_old/old/results/parquet/gtex_v8_eur_maf0.01.variants.parquet
#PQM=/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet_old/old/results/parquet/gtex_v8_eur_maf0.01.variants_metadata.parquet
#GWF=/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/gwas_conversion_ukbn/results_gwas_ukbn/50_Standing_height.txt.gz

#PQG=/scratch/abarbeira3/v8_process/to_parquet_test/results/parquet/gtex_v8_eur_itm_1e5.chr1.variants.parquet
#PQM=/scratch/abarbeira3/v8_process/to_parquet_test/results/parquet/gtex_v8_eur_itm_1e5.variants_metadata.parquet
##GWF=/group/im-lab/nas40t2/Data/SummaryResults/Formatted_GWAS_hg38/pgc.scz2.txt.gz
#GWF=/scratch/abarbeira3/data/GWAS/pgc.scz2.txt.gz
##GWF=/scratch/abarbeira3/data/GWAS/1160_Sleep_duration.txt.gz

PQG=/scratch/abarbeira3/v8_process/to_parquet/results/parquet/gtex_v8_eur_itm.chr1.variants.parquet
PQM=/scratch/abarbeira3/v8_process/to_parquet/results/parquet/gtex_v8_eur_itm.variants_metadata.parquet
GWF=/scratch/abarbeira3/data/GWAS/pgc.scz2.txt.gz


python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/gwas_summary_imputation.py \
-gwas_file $GWF \
-parquet_genotype $PQG \
-parquet_genotype_metadata $PQM \
-window 100000 \
-by_region_file /group/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/eur_ld.bed.gz \
-parsimony 7 \
-chromosome 1 \
-sub_batches 10 \
-sub_batch 4 \
-regularization 0.01 \
-frequency_filter 0.01 \
-output results/kk.txt.gz

#-chromosome 2 \