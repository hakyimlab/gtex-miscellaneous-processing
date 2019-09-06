#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/parse_wrapup.py \
-logs_folder logs \
-output wrapup.txt \
-name_subfield_regexp "model_training_(.*)_to_parquet_(.*)\.o(\d+)\.cri(.*)" \
-name_subfield type 1 \
-name_subfield tissue 2