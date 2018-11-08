#!/usr/bin/env bash

SF=/group/im-lab/nas40t2/abarbeira/software
GF=$SF/genomic_tools/src
D=/group/im-lab/nas40t2/Data/GTEx/V7
P=/group/im-lab/nas40t2/abarbeira/projects/gtex_v7

python3 $GF/scripts/SubmitTorus.py \
-torus_command $SF/dap/torus_src/torus \
-tool $GF/genomic_tools/run_torus.py \
-eqtl_folder $P/gtex_eqtl_conversion \
-eqtl_regex  "(.*).parquet$" \
-snp_annotation $D/GTEx_Analysis_2016-01-15_v7_WholeGenomeSeq_635Ind_PASS_AB02_GQ20_HETX_MISS15_PLINKQC.lookup_table.txt.gz \
-gene_annotation $D/gencode.v19.genes.v7.patched_contigs.gtf \
-intermediate_folder intermediate \
-output_folder results \
-jobs_folder jobs \
-logs_folder logs \
-verbosity 7 \
-fake_submit \
-email "mundoconspam@gmail.com"