#!/usr/bin/env bash

python genomic_tools/gwas_parsing.py \
-gwas_file /home/numa/Documents/Projects/data/GWAS/GIANT/All_ancestries_SNP_gwas_mc_merge_nogc.tbl.uniq.gz \
--fill_from_snp_info /home/numa/Documents/Projects/data/ucsc-hg/synth/snp130_hg18_parsed.txt.gz \
-snp_info_blacklist results/snp130_parsed_suspicious.txt.gz \
-snp_metadata_blacklist results/gtex_variants_blacklist.txt.gz \
-liftover /home/numa/Documents/Projects/data/LiftOver/hg18ToHg38.over.chain.gz \
-snp_metadata /home/numa/Documents/Projects/data/GTEx/v8/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
-output_column_map SNP variant_id \
-output_column_map A1 effect_allele \
-output_column_map A2 non_effect_allele \
-output_column_map Freq1.Hapmap frequency \
-output_column_map b beta \
-output_column_map se se \
-output_column_map p pvalue \
-output_column_map N sample_size \
-output_order variant_id gtex_variant_id chromosome position effect_allele non_effect_allele frequency pvalue zscore beta se sample_size \
-output results/gwas.txt.gz


#--fill_from_snp_info results/snp130_parsed.txt.gz \