#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/misc/parse_wrapup.py \
-logs_folder /scratch/abarbeira3/v8_process/gwas_summary_imputation/logs/ \
-output imputation_wrapup.txt \
-name_subfield_regexp "(.*)_chr(.*)_sb(.*)_by_region\.o(\d+)\.cri(.*)" \
-name_subfield chromosome 2 \
-name_subfield sub_batch 3 \
-name_subfield pheno 1