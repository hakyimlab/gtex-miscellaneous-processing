#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/concat_trait_tissue_results.py \
-input_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/spredixcan/results/sp_imputed_gwas_gtexv8_en_splicing \
-output_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/spredixcan/results/sp_imputed_gwas_gtexv8_en_splicing.csv.gz \
-pattern "spredixcan_igwas_gtexenv8_splicing_(.*)__PM__(.*).csv"