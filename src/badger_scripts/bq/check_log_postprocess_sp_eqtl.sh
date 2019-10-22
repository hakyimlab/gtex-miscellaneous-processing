#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs_parse_ppspe \
-logs_folder logs_parse_ppspe \
--name_subfield_regexp "(.*)__parse_sp" \
--name_subfield trait 1 \
--clean_target "logs_parse_ppspe/{trait}*" \
--check_product output "spredixcan/phenomexan/eqtl/{trait}__parse_sp.txt" \
-finish_token "Finished processing." \
--resubmit \
-output check_phenomexcan_spe.txt

#--clean_target "logs_parse_ppfe/{trait}_*" \
#--resubmit \