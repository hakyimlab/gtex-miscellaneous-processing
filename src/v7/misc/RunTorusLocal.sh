#!/usr/bin/env bash

python3 genomic_tools/run_torus.py \
--eqtl /home/numa/Documents/Projects/data/GTEx/v7/synth/eqtl_conversion/Whole_Blood_eqtl.trim.parquet \
--snp_annotation /home/numa/Documents/Projects/data/GTEx/v7/GTEx_Analysis_2016-01-15_v7_WholeGenomeSeq_635Ind_PASS_AB02_GQ20_HETX_MISS15_PLINKQC.lookup_table.txt.gz \
--gene_annotation /home/numa/Documents/Projects/data/GTEx/v7/gencode.v19.genes.v7.patched_contigs.gtf \
--torus_command /home/numa/Documents/Projects/3rd/xqwen/dap/torus_src/torus \
--intermediate_folder kk \
--output_folder results/torus

#--input_eqtl /home/numa/Documents/Projects/data/GTEx/v7/synth/eqtl_conversion/Whole_Blood_eqtl.trim.parquet \

#Nope. Don't create
#[ -d "kk/prior" ] || mkdir -p "kk/prior"

#/home/numa/Documents/Projects/3rd/xqwen/dap/torus_src/torus \
#-d kk/eqtl.gz --load_zval \
#-smap kk/snp.gz \
#-gmap kk/gene.gz \
#-dump_prior kk/prior

#/home/numa/Documents/Projects/3rd/xqwen/dap/torus_src/torus \
#-d eqtl.gz --load_zval \
#-smap snp.gz \
#-gmap gene.gz \
#-dump_prior prior