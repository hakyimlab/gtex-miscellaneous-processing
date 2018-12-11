#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/split_file_on_genes.py \
-gene_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_stranded_all.txt \
-input /gpfs/data/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_all_associations/Muscle_Skeletal.allpairs.txt.gz \
-splits 10 \
-parsimony 8 \
-output_format "results/Muscle_Skeletal__{}_{}.txt.gz"
