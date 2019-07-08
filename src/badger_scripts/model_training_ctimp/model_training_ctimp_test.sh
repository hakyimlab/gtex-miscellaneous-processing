#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3
module load R/3.4.1

cd /gpfs/data/im-lab/nas40t2/abarbeira/software/CTIMP/

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/model_training_ctimp.py \
-intermediate_folder /scratch/abarbeira3/v8_process/CTIMP/i_kk \
-script_path /gpfs/data/im-lab/nas40t2/abarbeira/software/CTIMP/main_2.R \
--rsid_whitelist /gpfs/data/im-lab/nas40t2/abarbeira/data/hapmapSnpsCEU_f.list.gz \
-features /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.chr1.variants.parquet \
-features_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.variants_metadata.parquet \
-data_folder /scratch/abarbeira3/v8_process/regress/eqtl/results/regressed \
-data_name_pattern "(.*).residual.expression.parquet" \
-data_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_stranded.txt \
-window 1000000 \
--output_rsids \
--chromosome 1 \
--sub_batch 0 \
--sub_batches 20 \
-parsimony 9 \
--MAX_M 3 \
-run_tag kk \
-output_prefix /scratch/abarbeira3/v8_process/CTIMP/o_kk/kk

#--keep_intermediate_folder \

#--rsid_whitelist /gpfs/data/im-lab/nas40t2/abarbeira/data/hapmapSnpsCEU_f.list.gz \

#python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/model_training.py \
#-features /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.chr1.variants.parquet \
#-features_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.variants_metadata.parquet \
#-data /scratch/abarbeira3/v8_process/regress/eqtl/results/regressed/Whole_Blood.residual.expression.parquet \
#-data_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_stranded.txt \
#--rsid_whitelist /gpfs/data/im-lab/nas40t2/abarbeira/data/hapmapSnpsCEU_f.list.gz \
#-window 1000000 \
#--output_rsids \
#--chromosome 1 \
#--sub_batch 0 \
#--sub_batches 20 \
#-parsimony 8 \
#--MAX_M 3 \
#--run_tag K \
#-output_prefix kk/kk


#