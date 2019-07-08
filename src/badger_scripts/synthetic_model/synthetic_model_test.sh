#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/synthetic_model.py \
-variant_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/genotype/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
-data_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_stranded_everything.txt \
-model_input /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/mashr_weights/Whole_Blood.txt \
--model_filter /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/dapg/eqtl/parsed_dapg/Whole_Blood.variants_pip.txt.gz PIP 0.01 \
-output results/wb.db