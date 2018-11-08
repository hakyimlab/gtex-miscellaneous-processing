#!/usr/bin/env bash

F="/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2"

python genomic_tools/dap_on_study.py \
-dap_command /home/numa/Documents/Projects/3rd/xqwen/dap/dap_src/dap-g \
-priors_folder $F/abarbeira/projects/gtex_v7/torus/results/Whole_Blood_eqtl.trim/priors \
-grid_file scripts/misc/dap_grid.txt \
-intermediate_folder intermediate/dap \
-gene_annotation /home/numa/Documents/Projects/data/gencode/gencode_v26_parsed.txt \
-parquet_genotype /home/numa/Documents/Projects/data/GTEx/v8/genotype/gtex_v8_eur_biallelic_maf0.01.variants.parquet \
-parquet_genotype_metadata /home/numa/Documents/Projects/data/GTEx/v8/genotype/gtex_v8_eur_biallelic_maf0.01.chr1.variants.parquet \
-parquet_phenotype $F/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/expression/Whole_Blood.expression.parquet \
-parquet_covariate /home/numa/Documents/Projects/data/GTEx/v8/covariates/Whole_Blood.covariate.parquet \
-window 100000 \
-sub_batches 100 \
-sub_batch 0 \
-output_folder results/dap/whole_blood \
-parsimony 7

#-parquet_genotype $F/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet/gtex_v8_eur_biallelic_maf0.01.variants.parquet \
#/home/numa/Documents/Projects/data/GTEx/v8/genotype/gtex_v8_eur_biallelic_maf0.01.variants.parquet