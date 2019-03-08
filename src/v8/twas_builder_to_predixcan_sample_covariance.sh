#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/covariance_for_model.py \
-model_db /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/twas_builder/Adipose_Subcutaneous.db \
-parquet_genotype_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic \
-parquet_genotype_pattern "gtex_v8_eur_itm.chr(\d+).variants.parquet" \
-parsimony 9 \
-output /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/twas_builder/Adipose_Subcutaneous.txt.gz