#!/usr/bin/env bash

module load gcc/6.2.0 bgen-reader/3.0.3

cd $PBS_O_WORKDIR

printf "Predict expression\n\n"

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/PrediXcan/Software/kk_PrediXcan.py \
--predict \
--samples /scratch/abarbeira3/data/1000G_hg38_dosage_chr22/samples.txt \
--dosages /scratch/abarbeira3/data/1000G_hg38_dosage_chr22 \
--weights /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/mashr/mashr_Whole_Blood.db \
--model_variant_id varID \
--only_genes  ENSG00000075218.18 \
--capture mashr_capture/capture_old_p.txt.gz \
--output_prefix mashr_capture/old_p_Whole_Blood

#--prediction_output en_geuv_v6/Adipose_Subcutaneous__predict.txt \
#--prediction_summary_output en_geuv_v6/Adipose_Subcutaneous__summary.txt \


#--verbosity 6 \
#--stop_at_variant 5 \
#--force_mapped_metadata "_" \
#--force_colon \
