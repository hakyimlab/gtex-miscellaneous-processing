#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/concatenate.py \
-folder /scratch/abarbeira3/v8_process/susier/eqtl/results \
-pattern "Muscle_Skeletal__chr(.*)_(.*)_cs" \
--sort_groups 1 2 \
-parsimony 9 \
-output Muscle_Skeletal_cs_v0.txt.gz

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/concatenate.py \
-folder /scratch/abarbeira3/v8_process/susier/eqtl/results \
-pattern "Muscle_Skeletal__chr(.*)_(.*)_vars" \
--sort_groups 1 2 \
-parsimony 9 \
-output Muscle_Skeletal_vars_v0.txt.gz