#!/usr/bin/env bash
#PBS -N predixcan_vcfhg37_en
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_new_predixcan/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_new_predixcan/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0 python/3.5.3


printf "Predict expression\n\n"
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/Predict.py \
--model_db_path /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/elastic_net_models/en_Whole_Blood.db \
--vcf_genotypes /scratch/abarbeira3/data/1000G_hg38/ALL.chr22.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz \
--vcf_mode genotyped \
--variant_mapping /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered_maf0.01_monoallelic_variants.txt.gz id rsid \
--on_the_fly_mapping METADATA "chr{}_{}_{}_{}_b38" \
--prediction_output vcfhg38_en/Whole_Blood_predict.txt \
--prediction_summary vcfhg38_en/Whole_Blood__summary.txt \
--verbosity 6 \
--throw
#--sub_batches 5000 \
#--sub_batch 4999 \
# --model_db_snp_key varID \
#--vcf_genotypes /gpfs/data/gtex-group/v8/59348/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.SHAPEIT2_phased.vcf.gz \
#/gpfs/data/im-lab/nas40t2/owen/data/ukb_test_files/ukb_imp_chr22_v2_hrc_hapmap.bgen