#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3
module load R/3.4.1

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/model_training.py \
--features_weights /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/dapg/eqtl/parsed_dapg/Whole_Blood.variants_pip.txt.gz PIP 0.01 \
-features /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.chr1.variants.parquet \
-features_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.variants_metadata.parquet \
-data /scratch/abarbeira3/v8_process/regress/eqtl/results/regressed/Whole_Blood.residual.expression.parquet \
-data_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_stranded.txt \
-window 1000000 \
--output_rsids \
--chromosome 1 \
--sub_batch 0 \
--sub_batches 20 \
-parsimony 8 \
--run_tag K \
--mode ols \
-output_prefix kk/kk

#--MAX_M 3 \

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