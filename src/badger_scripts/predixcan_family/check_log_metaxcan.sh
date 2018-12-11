#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

CHECK()
{
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/misc/check_log.py \
-jobs_folder $1 \
-jobs_pattern "spredixcan_igwas_(.*).sh" \
-logs_folder $2 \
-logs_pattern "spredixcan_igwas_(.*)\.e(\d+)\.cri(.*)\.err$" \
-finish_token "Sucessfully processed" \
-output $3
#--resubmit \
}

CHECK jobs_en_v8 logs_en_v8 check_v8.txt
CHECK jobs_en_v8_splicing logs_en_v8_splicing check_v8_splicing.txt
CHECK jobs_sp_p logs_sp_p check_p.txt
CHECK jobs_sp_s logs_sp_s check_s.txt
CHECK jobs_sp_t logs_sp_t check_t.txt

CHECK jobs_sp_mp logs_sp_mp check_mp.txt
CHECK jobs_sp_ms logs_sp_ms check_ms.txt
CHECK jobs_sp_mt logs_sp_mt check_mt.txt

CHECK jobs_sp_dp logs_sp_dp check_dp.txt
CHECK jobs_sp_ds logs_sp_ds check_ds.txt
CHECK jobs_sp_dt logs_sp_dt check_dt.txt
