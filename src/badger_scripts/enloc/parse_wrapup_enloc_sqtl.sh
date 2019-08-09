#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/parse_wrapup.py \
-logs_folder /scratch/abarbeira3/v8_process/enloc/sqtl/logs_enloc \
-output enloc_wrapup.txt \
-name_subfield_regexp "gtexv8_dapg_(.*)__PM__(.*)\.o(\d+)\.cri(.*)" \
-name_subfield trait 1 \
-name_subfield tissue 2
