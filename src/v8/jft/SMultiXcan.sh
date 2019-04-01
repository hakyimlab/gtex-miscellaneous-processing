#!/bin/bash
#PBS -N gtex_v8_meta_covariance_expression_5
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

module load intel/2017
module load python/2.7.13

export MKL_NUM_THREADS=1
export OPEN_BLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1

DATA=/gpfs/data/im-lab/nas40t2/abarbeira/projects/jft

python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/SMulTiXcan.py \
--gwas_folder $DATA/info8 \
--gwas_file_pattern "CRC_LP1_VQ_CFR1_CFR2_COIN_FIN_ONCO_SCOT_AUSTRIA_SP1_SOCCS3_CROATIA_BIOB_LBC_DACHS_meta_uk10k_1kG_info8_chr.*" \
--snp_column SNP --non_effect_allele_column A2 --effect_allele_column A1 --beta_column b --se_column se \
--models_folder $DATA/DB_RNA \
--models_name_filter "UK10K.(.*).RNAseqc_counts.HM2_imputed_europeans_tw0.5_signif.db" \
--models_name_pattern "UK10K.(.*).RNAseqc_counts.HM2_imputed_europeans_tw0.5_signif.db" \
--metaxcan_folder $DATA/RNA \
--metaxcan_filter "MetaXcan_(.*)_tw_(.*)_0.5_R0.8_maf0.05.csv" \
--metaxcan_file_name_parse_pattern "MetaXcan_(.*)_tw_(.*)_0.5_R0.8_maf0.05.csv" \
--snp_covariance $DATA/colon_covariance.txt.gz \
--cutoff_condition_number 30 \
--regularization 0 \
--output results/smultixcan/jft.txt \
--verbosity 7 \
--trimmed_ensemble_id \
--throw
