#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3


CHECK_1() {
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/misc/check_log.py \
-jobs_folder jobs_${1} \
-jobs_pattern "coloc_${1}_(.*).sh" \
-logs_folder logs_${1} \
-logs_pattern "coloc_${1}_(.*)\.e(\d+)\.cri(.*)\.err$" \
-finish_token "Finished" \
-output check/$1.txt
}

CHECK_2() {
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/misc/check_log.py \
-jobs_folder jobs_${1} \
-jobs_pattern "(.*)_coloc_${1}.sh" \
-logs_folder logs_${1} \
-logs_pattern "(.*)_coloc_${1}\.e(\d+)\.cri(.*)\.err$" \
-finish_token "Finished" \
-output check/$1.txt
}

CHECK_3() {
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/misc/check_log.py \
-jobs_folder jobs_${1} \
-jobs_pattern "(.*)_coloc_${1}.sh" \
-logs_folder logs_${1} \
-logs_pattern "(.*)_coloc_${2}\.e(\d+)\.cri(.*)\.err$" \
-finish_token "Finished" \
-output check/$1.txt
}

echo "default"
CHECK_1 default

echo "default_bse"
CHECK_2 default_bse

echo "enloc_priors"
CHECK_2 enloc_priors

echo "enloc_priors_bse"
CHECK_3 enloc_priors_bse enloc_prior_bse