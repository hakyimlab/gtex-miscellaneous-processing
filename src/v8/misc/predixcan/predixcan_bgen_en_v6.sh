#!/usr/bin/env bash

module load gcc/6.2.0 bgen-reader/3.0.3

printf "Predict expression\n\n"
python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/Predict.py \
--model_db_path /gpfs/data/im-lab/nas40t2/abarbeira/data/metaxcan/GTEx-V6p-HapMap-2016-09-08/TW_Adipose_Subcutaneous_0.5.db \
--bgen_genotypes /gpfs/data/im-lab/nas40t2/owen/data/ukb_test_files/ukb_imp_chr22_v2_hrc_hapmap.bgen \
--bgen_use_rsid \
--text_sample_ids /gpfs/data/im-lab/nas40t2/owen/data/ukb_test_files/ukb19526_imp_chr1_v3_s487395.sample UKB \
--prediction_output en_v6/Adipose_Subcutaneous__predict.txt \
--prediction_summary_output en_v6/Adipose_Subcutaneous__summary.txt \
--verbosity 6 \
--stop_at_variant 10 \
--throw

#--stop_at_variant 5 \
#--force_mapped_metadata "_" \
#--force_colon \
