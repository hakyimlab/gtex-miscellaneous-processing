#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/split_model_training_genotypes.py \
-input_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predict_db_pipeline_v8_splicing/prepare_data/genotype/gtex_v8_eur_shapeit2_phased_maf01_qdimputed_maf0.01_chr1.txt.gz \
-chromosome 1 \
-sub_jobs 200 \
-input_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predict_db_pipeline_v8_splicing/prepare_data/expression/intron_annotation.txt \
-output_folder kk