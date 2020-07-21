#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs_en_v8_dapgw \
-logs_folder logs_en_v8_dapgw \
--name_subfield_regexp "spredixcan_igwas_v8_(.*)__PM__(.*)" \
--name_subfield trait 1 \
--name_subfield tissue 2 \
--clean_target "logs_en_v8_dapgw/spredixcan_igwas_v8_{trait}__PM__{tissue}.*" \
--check_product output "results/sp_imputed_gwas_gtexv8_en_dapgw/spredixcan_igwas_gtexendapgwv8_{trait}__PM__{tissue}.csv" \
-finish_token "Sucessfully processed me" \
--resubmit \
-output check_sp_endapgw.txt

