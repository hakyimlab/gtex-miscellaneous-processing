#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder /scratch/abarbeira3/v8_process/regress/sqtl/jobs \
-logs_folder /scratch/abarbeira3/v8_process/regress/sqtl/logs \
-finish_token "Finished" \
-output check_regress.txt

#--resubmit \