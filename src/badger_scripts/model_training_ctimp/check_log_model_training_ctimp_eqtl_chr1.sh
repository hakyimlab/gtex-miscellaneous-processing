#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/utmost/jobs \
-logs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/utmost/logs \
-finish_token "Finished" \
--name_subfield_regexp "ctimp_w1000000_chr(\d+)_sb(\d+)_2420_model_training*" \
--name_subfield chromosome 1 \
--name_subfield sub_batch 2 \
--clean_target "results/ctimp_w1000000_chr{chromosome}_sb{sub_batch}_*" \
--clean_target "logs/ctimp_w1000000_chr{chromosome}_sb{sub_batch}_2420_*" \
--resubmit \
-output check_eqtl.txt

#--error_token "RuntimeError" \