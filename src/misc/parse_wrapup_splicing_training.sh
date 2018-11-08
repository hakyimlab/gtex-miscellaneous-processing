#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/misc/parse_wrapup.py \
-logs_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predict_db_pipeline_v8_splicing/model_training/joblogs/ \
-output data/splicing_training_wrapup.txt \
-name_subfield_regexp "gtex_training_splicing_(.*)_chr(\d+)_(\d+).o(\d+.cri.*)" \
-name_subfield tissue 1 \
-name_subfield chromosome 2 \
-name_subfield sub_job 3