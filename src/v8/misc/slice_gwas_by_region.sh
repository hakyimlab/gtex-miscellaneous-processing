#!/usr/bin/env bash

genomic_tools/slice_gwas_by_region.py \
-gwas_file /home/numa/Documents/Projects/data/GWAS/imputed/imputed_ADIPOGen_Adiponectin.txt.gz \
-region_file /home/numa/Documents/Projects/data/pickrell/v8/eur_ld.bed.gz \
-parsimony 8 \
-output results/kk.txt.gz