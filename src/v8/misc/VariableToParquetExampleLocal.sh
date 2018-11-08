#!/usr/bin/env bash

#I=/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/covariates/Whole_Blood_Analysis.combined_covariates.txt
I=/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/expression/Whole_Blood_Analysis.expression.txt

python genomic_tools/model_training_variable_to_parquet.py \
-variable_file $I \
-parquet_output results/wbc.parquet