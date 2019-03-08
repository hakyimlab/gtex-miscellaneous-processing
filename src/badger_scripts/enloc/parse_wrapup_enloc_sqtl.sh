#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

P()
{
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/parse_wrapup.py \
-logs_folder $1 \
-output $2 \
-name_subfield_regexp "gtexv8_enloc_(.*)__PM__(.*)\.o(\d+)\.cri(.*)" \
-name_subfield trait 1 \
-name_subfield tissue 2
}

P /scratch/abarbeira3/v8_process/enloc/sqtl/logs_enloc_b enloc_sqtl_wrapup_1.txt
P /scratch/abarbeira3/v8_process/enloc/sqtl/logs_enloc_b_save enloc_sqtl_wrapup_2.txt
P /scratch/abarbeira3/v8_process/enloc/sqtl/logs_enloc_b_save_2 enloc_sqtl_wrapup_3.txt
P /scratch/abarbeira3/v8_process/enloc/sqtl/logs_enloc_b_save_3 enloc_sqtl_wrapup_4.txt
P /scratch/abarbeira3/v8_process/enloc/sqtl/logs_enloc_b_save_4 enloc_sqtl_wrapup_5.txt
P /scratch/abarbeira3/v8_process/enloc/sqtl/logs_enloc_b_save_5 enloc_sqtl_wrapup_6.txt

