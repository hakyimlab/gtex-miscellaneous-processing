#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs_parse_enloc_sqtl \
-logs_folder logs_parse_enloc_sqtl \
-logs_pattern "(.*)\.o(\d+)\.cri(.*)\.log$" \
--name_subfield_regexp "(.*)__PM__(.*)_parse_enloc_eqtl" \
--name_subfield trait 1 \
--name_subfield tissue 2 \
--clean_target "logs_parse_enloc_sqtl/{trait}__PM__{tissue}_*" \
--check_product output "enloc/sqtl/{trait}__PM__{tissue}.enloc.txt" \
-finish_token "End" \
--resubmit \
-output check_enloc_sqtl.txt

#--resubmit \