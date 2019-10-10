#!/usr/bin/env bash

module load gcc/6.2.0 python/3.5.3

#python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/gtex_pheno_bed_individuals.py \
#-individuals /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/GTEx_838Ind_PhenoData_Populations.txt EUR SUBJID \
#-bed /gpfs/data/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_expression_matrices/Whole_Blood.v8.normalized_expression.bed.gz \
#-output wb_ind.txt

for i in /gpfs/data/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_expression_matrices/*.v8.normalized_expression.bed.gz; do
  d="${i##*/}"
  python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/gtex_pheno_bed_individuals.py \
  -individuals /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/GTEx_838Ind_PhenoData_Populations.txt EUR SUBJID \
  -bed $i \
  -output "${d%.v8.normalized_expression.bed.gz}"_individuals.txt
done