#! /usr/bin/env bash

module load gcc/6.2.0 python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/SMulTiXcanByFeature.py \
--gwas_file /gpfs/data/im-lab/nas40t2/Data/SummaryResults/imputed_gwas_hg38_1.1/imputed_BCAC_Overall_BreastCancer_EUR.txt.gz \
--snp_column panel_variant_id --effect_allele_column effect_allele --non_effect_allele_column non_effect_allele --zscore_column zscore \
--keep_non_rsid --model_db_snp_key varID \
--model_db_path /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/sqtl/mashr/mashr_Whole_Blood.db \
--covariance /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/sqtl/mashr/mashr_Whole_Blood.txt.gz \
--grouping "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/intron_id_mapping/Whole_Blood.leafcutter.phenotype_groups.txt.gz" GTEx_sQTL \
--associations "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/spredixcan_v1/sqtl/sp_imputed_gwas_gtexv8_mashr_sqtl/spredixcan_igwas_gtexmashrv8_BCAC_Overall_BreastCancer_EUR__PM__Whole_Blood.csv" SPrediXcan \
--cutoff_condition_number 30 \
--output kk/multi_splicing.txt

#--verbosity 8 \
#--MAX_M 100 \