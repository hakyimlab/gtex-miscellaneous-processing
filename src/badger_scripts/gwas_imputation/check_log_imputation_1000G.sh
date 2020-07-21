#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs_summary_imputation \
-logs_folder logs \
--name_subfield_regexp "(.*)_chr(\d+)_sb(\d+)_by_region_1000G*" \
--name_subfield trait 1 \
--name_subfield chromosome 2 \
--name_subfield sub_batch 3 \
--check_product output "results_summary_imputation_1000G/{trait}_chr{chromosome}_sb{sub_batch}_reg0.1_ff0.01_by_region.txt.gz" \
--clean_target "logs/{trait}_chr{chromosome}_sb{sub_batch}_by_region_1000G*" \
-finish_token "Finished in" \
-output check_mg.txt


#--clean_target "logs_gwas_parsing/gwas_parsing_{trait}*" \
#--resubmit \
