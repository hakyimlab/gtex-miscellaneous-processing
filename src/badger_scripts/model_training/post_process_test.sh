#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

#python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/post_process_model_training.py \
#-input_prefix /scratch/abarbeira3/v8_process/model_training/eqtl/results/Whole_Blood \
#-output_prefix Whole_Blood \
#-parsimony 9

#python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/post_process_model_training.py \
#-input_prefix /scratch/abarbeira3/v8_process/model_training/eqtl/results/dapgw_Whole_Blood \
#-output_prefix dapgw_Whole_Blood \
#-parsimony 9

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/post_process_model_training.py \
-input_prefix /scratch/abarbeira3/v8_process/model_training/eqtl_2/results/dapgw_Whole_Blood \
-output_prefix v_dapgw_Whole_Blood \
-parsimony 9