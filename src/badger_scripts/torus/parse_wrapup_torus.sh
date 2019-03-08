#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/parse_wrapup.py \
-logs_folder /scratch/abarbeira3/v8_process/torus/sqtl/logs_torus_sqtl \
-output torus_sqtl_wrapup.txt \
-name_subfield_regexp "(.*).v8.sqtl__gtexv8_torus__sqtlmaf0.01\.o(\d+)\.cri(.*)" \
-name_subfield tissue 1
