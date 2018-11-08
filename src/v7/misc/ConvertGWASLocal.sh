#!/usr/bin/env bash

python genomic_tools/gwas_parsing.py \
-gwas_file /home/heroico/Documents/Projects/data/gwas/giant/BMI.SNPadjSMK.CombinedSexes.EuropeanOnly.txt \
-column_map rs_id id \
-column_map allele_1 effect_allele \
-column_map allele_2 non_effect_allele \
-column_map Freq_Allele1_HapMapCEU frequency \
-column_map effect beta \
-column_map stderr se \
-column_map p_value pvalue \
-output_column_map id SNP \
-output_column_map zscore	z-val \
-output results/BMI_2017_Combined_EUR.txt.gz