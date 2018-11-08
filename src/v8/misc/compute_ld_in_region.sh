#!/bin/bash
#PBS -N summary_imputation
#PBS -S /bin/bash
#PBS -l walltime=120:00:00
#PBS -l nodes=1:ppn=16
#PBS -l mem=512gb
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

PQF=/scratch/abarbeira3/v8_process/to_parquet/results/parquet
PQP="gtex_v8_eur_itm.chr(.*).variants.parquet"
PQM=/scratch/abarbeira3/v8_process/to_parquet/results/parquet/gtex_v8_eur_itm.variants_metadata.parquet
LDR=/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/eur_ld.bed.gz

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/compute_ld_in_region.py \
-parquet_genotype_folder $PQF \
-parquet_genotype_pattern $PQP \
-parquet_genotype_metadata $PQM \
-region_file $LDR \
-parsimony 7 \
-sub_batches 10 \
-sub_batch 1 \
-chromosome 1 \
--frequency_filter 0.01 \
-text_output_folder results