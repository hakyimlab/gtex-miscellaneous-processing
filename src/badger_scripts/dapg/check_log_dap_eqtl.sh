#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs \
-logs_folder logs_dap \
-finish_token "Ran DAP in" \
--name_subfield_regexp "(.*)_chr(\d+)_(\d+)_gtexv8_dapg_eqtl" \
--name_subfield tissue 1 \
--name_subfield chromosome 2 \
--name_subfield sub_job 3 \
--check_product output "results/dapg/{tissue}_chr{chromosome}_{sub_job}" \
-output check_eqtl.txt


#--clean_target "scratch_dapg/{tissue}_chr{chromosome}_{sub_job}" \
#--clean_target "logs_dap/{tissue}_chr{chromosome}_{sub_job}_*" \

#--resubmit \
#--resubmit \