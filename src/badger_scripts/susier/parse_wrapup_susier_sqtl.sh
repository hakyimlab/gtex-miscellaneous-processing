#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/parse_wrapup.py \
-logs_folder /scratch/abarbeira3/v8_process/susier/sqtl/logs \
-output susier_ms_sqtl_wrapup.txt \
-name_subfield_regexp "Adipose_Subcutaneous__chr(.*)_(.*)_susier_sqtl\.o(\d+)\.cri(.*)" \
-name_subfield chromosome 1 \
-name_subfield sub_job 2