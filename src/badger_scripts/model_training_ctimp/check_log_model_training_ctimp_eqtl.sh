#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/utmost/jobs \
-logs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/utmost/logs \
-finish_token "Finished" \
--name_subfield_regexp "ctimp_w1000000_chr(\d+)_sb(\d+)_800_model_training*" \
--name_subfield chromosome 1 \
--name_subfield sub_batch 2 \
-output check_eqtl.txt

#--clean_target "logs/{key}*" \
#--clean_target "results/{key}*" \
#--resubmit \