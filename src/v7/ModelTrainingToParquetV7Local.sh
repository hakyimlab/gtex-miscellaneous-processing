#!/usr/bin/env bash

IF=/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2/
IFD="$IF/scott/gtex_v7_imputed_europeans/prepare_data/genotype"
IFA="$IFD/gtex_v7_hapmapceu_dbsnp150_snp_annot.txt"
IFP="$IF/scott/gtex_v7_imputed_europeans/prepare_data/expression"
IFPD="(.*)_donors.txt"
IFPE="(.*)_Analysis.expression.txt"
OF="$IF/abarbeira/data"
OFP="$OF/gtex_v7_eur_hapmapceu"

python genomic_tools/model_training_to_parquet.py \
-input_genotype_folder $IFD \
-input_genotype_file_pattern "gtex_v7_eur_imputed_maf_0.01_R2_0.8_chr.*.txt.gz" \
-snp_annotation_file $IFA \
-input_phenotype_folder $IFP \
-input_phenotype_expression_pattern $IFPE \
-output_prefix $OFP