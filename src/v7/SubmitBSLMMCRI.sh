#!/usr/bin/env bash

GF=/group/im-lab/nas40t2/abarbeira/software/genomic_tools/src


python3 $GF/scripts/SubmitBSLMM.py \
-gemma_command gemma \
-tool_command  $GF/genomic_tools/bslmm_on_study.py \
-expression_folder /group/im-lab/nas40t2/abarbeira/projects/gtex_v7/model_training_v7_europeans/results \
-expression_regex "gtex_v7_eur_hapmapceu.expression.(.*).parquet" \
-study_prefix  /group/im-lab/nas40t2/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu \
-gene_annotation  /group/im-lab/nas40t2/scott/gtex_v7_imputed_europeans/prepare_data/expression/gencode.v19.genes.patched_contigs.parsed.txt \
-output_folder results \
-intermediate_folder intermediate \
-sub_batches 2000 \
-window 1000000 \
-jobs_folder jobs \
-logs_folder logs \
-verbosity  7 \
-discard_gemma_output \
-output_hyperparameters \
-output_stats \
-email "mundoconspam@gmail.com"


# --fake_submit
#--white_list Lung.*
#--output_weights False
#--output_covariance = False
#--output_stats = False
