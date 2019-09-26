#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/owen/gtex-miscellaneous-processing/src/misc/check_log.py \
-jobs_folder jobs \
-logs_folder logs \
-logs_pattern "(.*)\.o(\d+)\.cri(.*)\.log$" \
--name_subfield trait 1 \
--name_subfield_regexp "(.*)_parse_smultixcan_ccn30" \
--check_product output "converted/smultixcan_{trait}_ccn30.txt" \
--resubmit \
--clean_target "logs/{trait}*" \
-finish_token "End" \
-output check_multixcan_conversion.txt

#--resubmit \

