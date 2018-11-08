#!/usr/bin/env bash

IF=/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2
IFF="$IF/abarbeira/projects/gtex_v8/data_formatting/gtex_vcf_processing/gtex_v8_eur_shapeit2_phased_maf01.txt.gz"
IFA="$IF/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/genotype/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz"
OF="results"

python genomic_tools/model_training_genotype_to_parquet.py \
-input_genotype_file $IFF \
-snp_annotation_file $IFA \
-impute_to_mean \
-biallelic_only \
-filter_maf 0.01 \
-output_prefix "$OF/gtex_v8_eur_biallelic_maf0.01"
