#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs_parse_ppfe \
-logs_folder logs_parse_ppfe \
--name_subfield_regexp "(.*)_parse_fastenloc.sh" \
--name_subfield trait 1 \
--check_product output "fastenloc/phenomexan/eqtl/fastenloc-{trait}.txt" \
-finish_token "Finished processing." \
-output check_enloc_sqtl.txt

#--clean_target "logs_parse_ppfe/{trait}_*" \
#--resubmit \