#!/usr/bin/env bash

#conda activate
#conda activate py3



printf "predixcan\n\n"
python /home/numa/cri/nas40t2/abarbeira/software/MetaXcan/software/Predict.py \
--model_db_path /home/numa/Documents/Projects/data/ptest/mashr_Whole_Blood.db \
--model_db_snp_key varID \
--text_genotypes /home/numa/Documents/Projects/data/ptest/geuvadis_eur_hg38/dosage_gtex_variant/chr22.txt.gz \
--text_sample_ids  /home/numa/Documents/Projects/data/ptest/geuvadis_eur_hg38/dosage_gtex_variant/samples.txt \
--prediction_output kk/association.h5 HDF5 \
--verbosity 9 \
--throw
