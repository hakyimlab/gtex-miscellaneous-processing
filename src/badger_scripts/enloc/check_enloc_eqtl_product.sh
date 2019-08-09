#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_product.py \
-jobs_folder jobs_enloc \
-jobs_pattern "(.*)_enloc_eqtl_gtexv8.sh" \
-results_folder results \
-results_pattern "(.*).enloc.rst" \
-output check_product.txt