#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs_en_v8_mashr \
-logs_folder logs_en_v8_mashr \
--name_subfield_regexp "(.*)__PM__(.*)_spredixcan_igwas_v8_gtexmashrv8*" \
--name_subfield trait 1 \
--name_subfield tissue 2 \
--check_product output "results/sp_imputed_gwas_gtexv8_mashr_sqtl/spredixcan_igwas_gtexmashrv8_{trait}__PM__{tissue}.csv" \
-finish_token "Sucessfully processed me" \
-output check_sp_endapgw.txt

# --resubmit \
# --clean_target "logs_en_v8_dapgw/{trait}__PM__{tissue}_spredixcan_igwas_v8_gtexmashrv8" \