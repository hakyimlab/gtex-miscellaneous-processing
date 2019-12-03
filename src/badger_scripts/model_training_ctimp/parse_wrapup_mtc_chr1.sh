#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/parse_wrapup.py \
-logs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/utmost/logs \
-output ctimp_wrapup_chr1.txt \
-name_subfield_regexp "ctimp_w1000000_chr(.*)_sb(.*)_(.*)_model_training\.o(\d+)\.cri(.*)" \
-name_subfield chromosome 1 \
-name_subfield sub_batch 2 \
-name_subfield sub_batches 3
