#!/usr/bin/env bash

module load gcc/6.2.0 R/3.4.1

Rscript /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/expression_splicing_correlation.R \
-splicing /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/predixcan/en_splicing/Whole_Blood_predicted_expression.txt \
-expression  /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/predixcan/en/Whole_Blood_predicted_expression.txt \
-intron_mapping /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/intron_gene_map/intron_gene_map_Whole_Blood.txt.gz \
-output /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/expression_vs_splicing/wb.txt

#-sub_batches 20 \
#-sub_batch 3 \