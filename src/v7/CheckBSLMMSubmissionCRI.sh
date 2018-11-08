#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/scripts/CheckSubmission.py \
-job_pattern "(.*).sh" \
-result_patterns hyperparameters "(.*).hyperparameters.txt.gz" \
-results_folder results \
-output job_log.txt