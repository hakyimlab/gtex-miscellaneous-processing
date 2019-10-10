#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs_parse_spsm \
-logs_folder logs_parse_spsm \
-logs_pattern "(.*)\.o(\d+)\.cri(.*)\.log$" \
--name_subfield_regexp "(.*)__PM__(.*)_parse_spredixcan_igwas_gtexmashrv8" \
--name_subfield trait 1 \
--name_subfield tissue 2 \
--clean_target "logs_parse_spsm/{trait}__PM__{tissue}_*" \
--check_product output "predixcan/sqtl/mashr/spredixcan_igwas_gtexmashrv8_{trait}__PM__{tissue}.csv" \
-finish_token "End" \
--resubmit \
-output check_mashr_spredixcan_sqtl.txt

#--resubmit \