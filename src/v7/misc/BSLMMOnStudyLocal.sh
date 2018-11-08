#!/usr/bin/env bash

python genomic_tools/bslmm_on_study.py \
-gemma_command /home/numa/Documents/Projects/3rd/GEMMA/bin/gemma \
-intermediate_folder intermediate \
-gene_annotation results/simulated_study_small/parquet/gene_annotation.txt.gz \
-parquet_genotype results/simulated_study_small/parquet/study.variants.parquet \
-parquet_genotype_metadata results/simulated_study_small/parquet/study.variants_metadata.parquet \
-parquet_phenotype results/simulated_study_small/parquet/study.pheno.parquet \
-window 100 \
-output_weights results/bslmm/weights.txt.gz \
-output_covariance results/bslmm/covariance.txt.gz \
-output_stats results/bslmm/stats.txt.gz \
-output_hyperparameters results/bslmm/hyperparameters.txt.gz \
-verbosity 7

