#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/owen/gtex-miscellaneous-processing/src/misc/check_log.py \
-jobs_folder jobs_parse \
-logs_folder logs_parse \
-logs_pattern "(.*)\.o(.*)\.log$" \
--name_subfield_regexp "(.*)-gtex_v8-(.*)_" \
--name_subfield trait 1 \
--name_subfield tissue 2 \
--check_product output "converted/{trait}-gtex_v8-[tissue}-2018_10.csv" \
-finish_token "End" \
-output first_check.tsv

#--clean_target "logs_parse/{trait}-gtex_v8-{tissue}_parse_spredixcan*"
#--resubmit