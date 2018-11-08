#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/gencode_conversion.py \
-gencode_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/gencode.v26.annotation.gtf.gz \
-gene_type_whitelist protein_coding pseudogene lincRNA \
-output /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_stranded.txt