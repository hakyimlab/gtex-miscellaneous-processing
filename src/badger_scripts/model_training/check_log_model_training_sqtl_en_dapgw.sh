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
-jobs_folder /scratch/abarbeira3/v8_process/model_training/sqtl/en_dapgw/jobs_pv \
-logs_folder /scratch/abarbeira3/v8_process/model_training/sqtl/en_dapgw/logs_pv \
-finish_token "Finished" \
--name_subfield_regexp "dapgw_(.*)_w1000000_chr(\d+)_sb(\d+)_20_model_training" \
--name_subfield tissue 1 \
--name_subfield chromosome 2 \
--name_subfield sub_job 3 \
--check_product covariance "results/dapgw_{tissue}_w1000000_chr{chromosome}_sb{sub_job}_20_covariance.txt.gz" \
--check_product run "results/dapgw_{tissue}_w1000000_chr{chromosome}_sb{sub_job}_20_run.txt.gz" \
--check_product summary "results/dapgw_{tissue}_w1000000_chr{chromosome}_sb{sub_job}_20_summary.txt.gz" \
--check_product weights "results/dapgw_{tissue}_w1000000_chr{chromosome}_sb{sub_job}_20_weights.txt.gz" \
-output check_mt.txt

#--clean_target "logs_pv/dapgw_{tissue}_w1000000_chr{chromosome}_sb{sub_job}_*" \
#--resubmit \