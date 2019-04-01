#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

CHECK()
{
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder $1 \
-logs_folder $2 \
-jobs_pattern "$3_(.*).sh" \
-logs_pattern "$3_(.*)\.e(\d+)\.cri(.*)\.err$" \
-finish_token "Ran multi" \
-output $4
#--resubmit \
}

CHECK jobs_smp logs_smp smultixcan_imputed_gwas_gtexelv8 check_expression.txt
CHECK jobs_smp_splicing logs_smp_splicing smultixcan_imputed_gwas_gtexelv8_splicing check_splicing.txt