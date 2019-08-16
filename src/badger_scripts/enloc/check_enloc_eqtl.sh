#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs_enloc \
-logs_folder logs_enloc \
-finish_token "Finished job" \
--name_subfield_regexp "(.*)__PM__(.*)_enloc_eqtl_gtexv8" \
--name_subfield trait 1 \
--name_subfield tissue 2 \
--check_product enloc "results/{trait}__PM__{tissue}.enloc.rst" \
-output check.txt

#--clean_target "logs_enloc/{trait}__PM__{tissue}_enloc_eqtl*" \
#--clean_target "results/{trait}__PM__{tissue}" \
#--resubmit \
#--resubmit \
#--clean_target "jobs_enloc/{trait}__PM__{tissue}_enloc_eqtl_gtexv8.sh" \