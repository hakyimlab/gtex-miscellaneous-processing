#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

#python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
#-jobs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/jobs \
#-logs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/logs \
#-finish_token "Finished" \
#-output check_eqtl.txt

#--resubmit \

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/elastic_net/jobs_en \
-logs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/elastic_net/logs_en \
--name_subfield_regexp "en_(.*)_w1000000_chr(\d+)_sb(\d+)_40_model_training" \
--name_subfield tissue 1 \
--name_subfield chromosome 2 \
--name_subfield sub_job 3 \
-finish_token "Finished" \
-output check_eqtl.txt

#--clean_target "logs_en/en_{tissue}_w1000000_chr{chromosome}_sb{sub_job}_40_model_training*" \
#--clean_target "results_en/en_{tissue}_w1000000_chr{chromosome}_sb{sub_job}_40_*" \
#--resubmit \

