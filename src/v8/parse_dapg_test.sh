#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

#python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/parse_dapg.py \
#-input_folder /scratch/abarbeira3/v8_process/dapg/sqtl/results/collapsed_dapg_maf0.01_w1000000/Muscle_Skeletal \
#-input_pattern "(.*).dap.txt" \
#-output_prefix results/parsed_dapg_maf0.01_w100000/Muscle_Skeletal \
#-parsimony 9

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/parse_dapg.py \
-input_folder /gpfs/data/im-lab/nas40t2/abarbeira/data/xqwen/dapg/Whole_Blood/fm_rst \
-input_pattern "(.*).fm.rst" \
-output_prefix wb.parsed \
-parsimony 9
