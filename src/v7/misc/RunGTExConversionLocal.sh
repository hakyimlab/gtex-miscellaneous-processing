#!/usr/bin/env bash

python genomic_tools/gtex_association_conversion.py \
-snp_annotation /home/numa/Documents/Projects/data/GTEx/v7/GTEx_Analysis_2016-01-15_v7_WholeGenomeSeq_635Ind_PASS_AB02_GQ20_HETX_MISS15_PLINKQC.lookup_table.txt.gz \
-gtex_eqtl_file /home/numa/Documents/Projects/data/GTEx/v7/GTEx_all_associations/Whole_Blood.allpairs.txt.gz \
-verbosity 8 \
-parquet_output results/kk.parquet
