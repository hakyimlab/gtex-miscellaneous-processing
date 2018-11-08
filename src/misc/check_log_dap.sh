#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/misc/check_log.py \
-jobs_folder jobs \
-logs_folder logs_dap \
-finish_token "Ran DAP in" \
--resubmit \
-output check.txt