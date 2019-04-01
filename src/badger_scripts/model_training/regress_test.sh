#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/regress_out_covariates.py \
-covariate /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/covariates/Adipose_Subcutaneous.covariate.parquet \
-data /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/expression/Adipose_Subcutaneous.expression.parquet \
-output /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/test/as.parquet \
-parsimony 9