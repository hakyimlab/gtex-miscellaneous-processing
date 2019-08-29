#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3
R=/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/fix/dapg/dapg_1

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder $R/jobs \
-logs_folder $R/logs_dap \
-finish_token "Ran DAP in" \
--name_subfield_regexp "(.*)_chr(\d+)_(\d+)_gtexv8_dapg_eqtl" \
--name_subfield tissue 1 \
--name_subfield chromosome 2 \
--name_subfield sub_job 3 \
-output $R/check_eqtl.txt

#--clean_target "scratch_dapg/{tissue}_chr{chromosome}_{sub_job}" \
#--clean_target "logs_dap/{tissue}_chr{chromosome}_{sub_job}_*" \
#--clean_target "results/dapg_maf0.01_w1000000/{tissue}_chr{chromosome}_{sub_job}" \
#--resubmit \