#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/owen/gtex-miscellaneous-processing/src/misc/check_log.py \
-jobs_folder jobs_parse \
-logs_folder logs_parse \
-logs_pattern "(.*)\.o(.*)\.log$" \
--name_subfield_regexp "(.*)_parse_smultixcan_mashr" \
--name_subfield trait 1 \
--check_product output "converted/smultixcan_{trait}_ccn30.tsv" \
--clean_target "logs_parse/{trait}_parse_smultixcan_mashr*" \
--resubmit \
-finish_token "End" \
-output third_check.txt
