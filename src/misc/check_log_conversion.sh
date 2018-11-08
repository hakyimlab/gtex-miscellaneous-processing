#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/misc/check_log.py \
-jobs_folder jobs_gwas_parsing \
-jobs_pattern "gwas_parsing_(.*).sh" \
-logs_folder logs_gwas_parsing \
-logs_pattern "gwas_parsing_(.*)\.e(\d+)\.cri(.*)\.err$" \
-finish_token "Finished" \
-output check.txt

#--resubmit \#!/usr/bin/env bash