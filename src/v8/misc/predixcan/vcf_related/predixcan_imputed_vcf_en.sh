#!/usr/bin/env bash

module load gcc/6.2.0 python/3.5.3
#module load gcc/6.2.0 miniconda2/4.4.10
#source activate py3

printf "Predict expression\n\n"
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/Predict.py \
--model_db_path /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/elastic_net_models/en_Whole_Blood.db \
--vcf_genotypes /gpfs/data/im-lab/nas40t2/abarbeira/projects/african_american_cohort_skdas/imputed_genotypes/chr22.dose.vcf.gz \
--vcf_mode imputed \
--variant_mapping /gpfs/data/im-lab/nas40t2/abarbeira/projects/african_american_cohort_skdas/data_formatting/genotypes/annotation.txt.gz id rsid \
--on_the_fly_mapping METADATA "chr{}_{}_{}_{}_b37" \
--prediction_output en_2/Whole_Blood_predict.txt \
--prediction_summary_output en_2/Whole_Blood__summary.txt \
--verbosity 6 \
--throw

#
#--sub_batches 5000 \
#--sub_batch 4999 \
# --model_db_snp_key varID \
#--vcf_genotypes /gpfs/data/gtex-group/v8/59348/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.SHAPEIT2_phased.vcf.gz \
#/gpfs/data/im-lab/nas40t2/owen/data/ukb_test_files/ukb_imp_chr22_v2_hrc_hapmap.bgen