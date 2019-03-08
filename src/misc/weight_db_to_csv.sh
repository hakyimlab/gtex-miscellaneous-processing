#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/weight_db_to_csv.py \
-input_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/elastic_net_models_splicing \
-pattern "gtex_splicing_v8_eur_(.*)_signif.db" \
-output_prefix /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/elastic_net_models_splicing/a