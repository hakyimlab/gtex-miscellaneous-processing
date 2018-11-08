#!/usr/bin/env bash

F="/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2"

python genomic_tools/dap_on_study.py \
-dap_command /home/numa/Documents/Projects/3rd/xqwen/dap/dap_src/dap-g \
-priors_folder $F/abarbeira/projects/gtex_v7/torus/results/Whole_Blood_eqtl.trim/priors \
-grid_file scripts/misc/dap_grid.txt \
-intermediate_folder intermediate/dap \
-gene_annotation $F/scott/gtex_v7_imputed_europeans/prepare_data/expression/gencode.v19.genes.patched_contigs.parsed.txt \
-parquet_genotype $F/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.variants.parquet \
-parquet_genotype_metadata $F/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.variants_metadata.parquet \
-parquet_phenotype $F/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.expression.Whole_Blood.parquet \
-window 100000 \
-output_folder results/dap/whole_blood \
-verbosity 7
