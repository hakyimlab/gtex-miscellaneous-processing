#!/bin/bash


PQF=/home/numa/Documents/Projects/data/GTEx/v8/synth/parquet/
PQP="gtex_v8_eur_itm.chr(.*).variants.parquet"
PQM=/home/numa/Documents/Projects/data/GTEx/v8/synth/parquet/gtex_v8_eur_itm.variants_metadata.parquet
LDR=/home/numa/Documents/Projects/nextgen/genomic_tools/src/results/eur_ld.bed.gz

python /home/numa/Documents/Projects/nextgen/genomic_tools/src/genomic_tools/compute_ld_in_region.py \
-parquet_genotype_folder $PQF \
-parquet_genotype_pattern $PQP \
-parquet_genotype_metadata $PQM \
-region_file $LDR \
-window 100000 \
-parsimony 7 \
-chromosome 1 \
-frequency_filter 0.01 \
-text_output results/ld.txt.gz