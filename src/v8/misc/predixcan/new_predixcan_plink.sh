#!/usr/bin/env bash

module load gcc/6.2.0 miniconda2/4.4.10
source activate py2

printf "Predict expression\n\n"
python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/Predict.py \
--model_db_path /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/mashr/mashr_Whole_Blood.db \
--model_db_snp_key varID \
--plink_prefix /gpfs/data/im-lab/nas40t2/abarbeira/projects/african_american_cohort_skdas/predictdb_pipeline_skdas/prepare_data/genotype/deqtl.abr1 \
--prediction_output aa_predict.txt \
--prediction_summary_output aa_summary.txt \
--verbosity 9 \
--throw