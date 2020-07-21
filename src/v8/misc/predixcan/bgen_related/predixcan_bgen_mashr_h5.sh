#!/usr/bin/env bash

module load gcc/6.2.0 miniconda2/4.4.10
source activate py3

printf "Predict expression\n\n"
python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/Predict.py \
--model_db_path /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/mashr/mashr_Whole_Blood.db \
--model_db_snp_key varID \
--bgen_genotypes /gpfs/data/im-lab/nas40t2/owen/data/ukb_test_files/ukb_imp_chr22_v3.bgen \
--force_mapped_metadata "_" \
--force_colon \
--variant_mapping /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/oneshot/ukb_variant_mapping.txt.gz variant panel_variant_id \
--text_sample_ids /gpfs/data/im-lab/nas40t2/owen/data/ukb_test_files/ukb19526_imp_chr1_v3_s487395.sample UKB \
--prediction_output mashr/Whole_Blood_predict.h5 HDF5 \
--prediction_summary_output mashr/Whole_Blood__summary.txt \
--sub_batches 900 \
--sub_batch 899 \
--verbosity 6 \
--throw

#/gpfs/data/im-lab/nas40t2/owen/data/ukb_test_files/ukb_imp_chr22_v2_hrc_hapmap.bgen