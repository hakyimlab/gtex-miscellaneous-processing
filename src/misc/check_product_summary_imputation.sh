#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/misc/check_product.py \
-jobs_folder jobs_summary_imputation \
-jobs_pattern "(.*)_by_region.sh" \
-results_folder results_summary_imputation \
-results_pattern "(.*)_reg0.1_ff0.01_by_region.txt.gz" \
-output check.txt

#--resubmit \