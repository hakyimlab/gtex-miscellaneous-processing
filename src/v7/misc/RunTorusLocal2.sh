#!/usr/bin/env bash

python3 genomic_tools/run_torus.py \
--eqtl /home/heroico/Documents/Projects/data/GTEx/v7/eQTL/Whole_Blood_eqtl.trim.parquet \
--snp_annotation /home/heroico/Documents/Projects/data/GTEx/v7/GTEx_Analysis_2016-01-15_v7_WholeGenomeSeq_635Ind_PASS_AB02_GQ20_HETX_MISS15_PLINKQC.lookup_table.txt.gz \
--gene_annotation /home/heroico/Documents/Projects/data/GTEx/v7/gencode.v19.genes.v7.patched_contigs.gtf \
--torus_command /home/heroico/Documents/Projects/3rd/xqwen/dap/torus_src/torus \
--intermediate_folder kk \
--output_folder results/torus
