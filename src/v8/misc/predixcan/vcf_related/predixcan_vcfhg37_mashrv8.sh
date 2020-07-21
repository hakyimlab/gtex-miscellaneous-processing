#!/usr/bin/env bash
#PBS -N predixcan_vcfhg37_en_mashr
#PBS -S /bin/bash
#PBS -l walltime=32:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_new_predixcan/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_new_predixcan/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0 python/3.5.3

cd $PBS_O_WORKDIR

printf "Predict expression\n\n"
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/Predict.py \
--model_db_path /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/mashr/mashr_Whole_Blood.db \
--model_db_snp_key varID \
--vcf_genotypes /scratch/abarbeira3/data/1000G_hg37/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--vcf_mode genotyped \
--liftover /gpfs/data/im-lab/nas40t2/abarbeira/data/liftover/hg19ToHg38.over.chain.gz \
--on_the_fly_mapping METADATA "chr{}_{}_{}_{}_b38" \
--prediction_output vcfhg37_mashr/Whole_Blood__predict.txt \
--prediction_summary_output vcfhg37_mashr/Whole_Blood__summary.txt \
--verbosity 9 \
--throw

#--vcf_genotypes /scratch/abarbeira3/data/1000G_hg37/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--sub_batches 5000 \
#--sub_batch 4999 \
# --model_db_snp_key varID \
#--vcf_genotypes /gpfs/data/gtex-group/v8/59348/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.SHAPEIT2_phased.vcf.gz \
#/gpfs/data/im-lab/nas40t2/owen/data/ukb_test_files/ukb_imp_chr22_v2_hrc_hapmap.bgen