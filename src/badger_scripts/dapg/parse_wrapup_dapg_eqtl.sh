#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/parse_wrapup.py \
-logs_folder /scratch/abarbeira3/v8_process/dapg/eqtl/logs_dap \
-output dap_eqtl_wrapup.txt \
-name_subfield_regexp "(.*)_chr(\d+)_(\d+)_gtexv8_dapg_eqtl\.o(\d+)\.cri(.*)" \
-name_subfield tissue 1 \
-name_subfield chromosome 2 \
-name_subfield sub_job 3