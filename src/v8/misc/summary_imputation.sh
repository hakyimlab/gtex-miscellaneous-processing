#!/usr/bin/env bash


#python /run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/gwas_summary_imputation.py \
#-gwas_file /home/numa/Documents/Projects/data/GWAS/formatted/50_Standing_height.txt.gz \
#-parquet_genotype /home/numa/Documents/Projects/data/GTEx/v8/synth/parquet/gtex_v8_eur_itm.chr1.variants.parquet \
#-parquet_genotype_metadata /home/numa/Documents/Projects/data/GTEx/v8/synth/parquet/gtex_v8_eur_itm.variants_metadata.parquet \
#-by_region_file /home/numa/Documents/Projects/nextgen/genomic_tools/src/results/eur_ld.bed.gz \
#-window 100000 \
#-parsimony 7 \
#-chromosome 1 \
#-regularization 0.01 \
#-frequency_filter 0.01 \
#-sub_batches 10 \
#-sub_batch 4 \
#-output results_summary_imputation/50_Standing_height_by_region.txt.gz

python genomic_tools/gwas_summary_imputation.py \
-by_region_file /home/numa/Documents/Projects/nextgen/genomic_tools/src/results/eur_ld.bed.gz \
-gwas_file /home/numa/Documents/Projects/data/GWAS/formatted/50_Standing_height.txt.gz \
-parquet_genotype /home/numa/Documents/Projects/data/GTEx/v8/synth/parquet/gtex_v8_eur_itm.chr1.variants.parquet \
-parquet_genotype_metadata /home/numa/Documents/Projects/data/GTEx/v8/synth/parquet/gtex_v8_eur_itm.variants_metadata.parquet \
-window 100000 \
-parsimony 7 \
-chromosome 1 \
-regularization 0.1 \
-frequency_filter 0.01 \
-sub_batches 10 \
-sub_batch 0 \
--standardise_dosages \
-output results_summary_imputation/50_Standing_height_reg_0.1.txt.gz

#-by_region results/eur_ld.bed.gz \
#-regularization 0.1 \
#-cutoff 0.001 \
#-sub_batches 40 \
#-sub_batch 0 \
#--cache_variants \