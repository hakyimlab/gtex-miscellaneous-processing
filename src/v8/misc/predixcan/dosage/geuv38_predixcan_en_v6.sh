#!/usr/bin/env bash

module load gcc/6.2.0 bgen-reader/3.0.3

cd $PBS_O_WORKDIR

printf "Predict expression\n\n"
python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/Predict.py \
--model_db_path /gpfs/data/im-lab/nas40t2/abarbeira/data/metaxcan/GTEx-V6p-HapMap-2016-09-08/TW_Adipose_Subcutaneous_0.5.db \
--text_genotypes /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage/chr*.txt.gz \
--text_sample_ids  /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage/samples.txt \
--prediction_output en_geuv_v6/Adipose_Subcutaneous__predict.txt \
--prediction_summary_output en_geuv_v6/Adipose_Subcutaneous__summary.txt \
--throw

#--prediction_output en_geuv_v6/Adipose_Subcutaneous__predict.txt \
#--prediction_summary_output en_geuv_v6/Adipose_Subcutaneous__summary.txt \


#--verbosity 6 \
#--stop_at_variant 5 \
#--force_mapped_metadata "_" \
#--force_colon \
