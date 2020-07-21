#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/owen/gtex-miscellaneous-processing/src/misc/check_log.py \
-jobs_folder jobs_parse \
-logs_folder logs_parse \
-logs_pattern "(.*)-gtex_v8-(.*)\.o(.*)\.log$" \
--name_subfield_regexp "(.*)-gtex_v8-(.*)_parse_spredixcan" \
--name_subfield trait 1 \
--name_subfield tissue 2 \
--check_product output "converted/{trait}-gtex_v8-{tissue}.csv" \
-finish_token "End" \
-output first_check.txt
#
#--clean_target "logs_parse/{trait}-gtex_v8-{tissue}_parse_spredixcan*" \
#--resubmit \
