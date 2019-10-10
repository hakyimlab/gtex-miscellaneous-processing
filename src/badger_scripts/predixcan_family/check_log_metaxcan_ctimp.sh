#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs_en_ctimp \
-logs_folder logs_en_ctimp \
--name_subfield_regexp "spredixcan_igwas_gtexctimpv8_(.*)__PM__(.*)" \
--name_subfield trait 1 \
--name_subfield tissue 2 \
-finish_token "Sucessfully processed me" \
--clean_target "logs_en_ctimp/spredixcan_igwas_gtexctimpv8_{trait}__PM__{tissue}.*" \
--check_product output "results/sp_imputed_gwas_gtexv8_ctimp/spredixcan_igwas_gtexctimpv8_{trait}__PM__{tissue}.csv" \
--resubmit \
-output check_sp_ctimp.txt

