#!/usr/bin/env bash

python genomic_tools/run_torus.py \
-eqtl /home/numa/Documents/Projects/data/GTEx/v8/eqtl/Whole_Blood.eqtl.mini_trimmed.parquet \
-torus_command /home/numa/Documents/Projects/3rd/xqwen/dap/torus_src/torus \
-gene_annotation /home/numa/Documents/Projects/data/gencode/gencode.v26.annotation.gtf.gz \
-intermediate_folder kk \
-output_folder results/torus_kk \
-keep_intermediate_folder

#-eqtl /home/numa/Documents/Projects/data/GTEx/v8/eqtl/Whole_Blood.eqtl.trimmed.parquet \
#-eqtl /run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/eqtl_to_parquet/results/eqtl/Whole_Blood.eqtl.parquet \
#-snp_annotation_file /home/numa/Documents/Projects/data/GTEx/v8/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \