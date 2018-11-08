#!/usr/bin/env bash

python genomic_tools/count_variants_in_region.py \
-regions results/eur_ld.bed.gz \
-parquet_genotype_metadata /home/numa/Documents/Projects/data/GTEx/v8/synth/parquet/gtex_v8_eur_itm.variants_metadata.parquet \
-frequency_filter 0.01 \
-output results/eur_ld_region_count.txt.gz