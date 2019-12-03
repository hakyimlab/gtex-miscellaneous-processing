#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs_gwas_parsing \
-logs_folder logs_gwas_parsing \
--name_subfield_regexp "gwas_parsing_(.*)" \
--name_subfield trait 1 \
--check_product output "results_gwas/{trait}.txt.gz" \
-finish_token "Successfully ran GWAS in" \
-output check_mg.txt


#--clean_target "logs_gwas_parsing/gwas_parsing_{trait}*" \
#--resubmit \
