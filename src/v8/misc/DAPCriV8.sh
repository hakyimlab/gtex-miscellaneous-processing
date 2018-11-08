#!/usr/bin/env bash

cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load gsl/2.3
module load boost/1.61.0
module load bzip2/1.0.6
module load python/3.5.3

F="/group/im-lab/nas40t2/abarbeira/projects/gtex_v8"

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/dap_on_study.py \
-dap_command /group/im-lab/nas40t2/abarbeira/software/dap/dap_src/dap-g \
-priors_folder $F/torus/results/torus_prior/Ovary/priors/ \
-grid_file $F/dap_grid.txt \
-intermediate_folder intermediate/dap \
-gene_annotation /group/im-lab/nas40t2/abarbeira/data/gencode/gencode_v26_parsed.txt \
-parquet_genotype $F/data_formatting/model_training_to_parquet/results/parquet/gtex_v8_eur_maf0.01.variants.parquet \
-parquet_genotype_metadata $F/data_formatting/model_training_to_parquet/results/parquet/gtex_v8_eur_maf0.01.variants_metadata.parquet \
-parquet_phenotype $F/data_formatting/model_training_to_parquet/results/expression/Ovary.expression.parquet \
-parquet_covariate $F/data_formatting/model_training_to_parquet/results/covariates/Ovary.covariate.parquet \
-window 100000 \
-sub_batches 100 \
-sub_batch 0 \
-output_folder results/dap/ovary \
-parsimony 7

#-parquet_genotype $F/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet/gtex_v8_eur_biallelic_maf0.01.variants.parquet \
#/home/numa/Documents/Projects/data/GTEx/v8/genotype/gtex_v8_eur_biallelic_maf0.01.variants.parquet