#!/usr/bin/env bash

module load gcc/6.2.0 miniconda2/4.4.10
source activate py2

printf "Predict expression\n\n"
python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/Predict.py \
--model_db_path /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/mashr/mashr_Whole_Blood.db \
--model_db_snp_key varID \
--text_genotypes /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage_gtex_variant/chr22.txt.gz \
--text_sample_ids  /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage_gtex_variant/samples.txt \
--prediction_output aa_predict.txt \
--prediction_summary_output aa_summary.txt \
--verbosity 9 \
--throw

printf "association\n\n"
python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/PrediXcanAssociation.py \
--expression_file aa_predict.txt \
--input_phenos_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/random_pheno.txt \
--input_phenos_column pheno \
--output aa_association.txt \
--verbosity 9 \
--throw

printf "predixcan\n\n"
python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/PrediXcan.py \
--model_db_path /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/mashr/mashr_Whole_Blood.db \
--model_db_snp_key varID \
--text_genotypes /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage_gtex_variant/chr22.txt.gz \
--text_sample_ids  /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage_gtex_variant/samples.txt \
--input_phenos_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/random_pheno.txt \
--input_phenos_column pheno \
--output kk_association.txt \
--verbosity 9 \
--throw

#--prediction_output kk_predict.txt \
#--prediction_summary_output kk_summary.txt \
#--expression_file kk_predict.txt \