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

COV()
{
python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/CovarianceBuilder.py \
--models_folder /scratch/abarbeira3/v8_process/kkk/$1/ \
--models_pattern "UK10K_v7_CEU_(.*)_maf0.05_imputed_europeans_tw_0.5_signif.db" \
--gtex_release_version V8 \
--gtex_genotype_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered.txt.gz \
--gtex_snp_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/genotype/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
--throw \
--snp_covariance_output results/covariances/UK10K_v7_CEU_$2_maf0.05_imputed_europeans_tw_0.5_signif_gtex.txt.gz \
--impute_to_mean \
--verbosity 7
}

COV transverse Transverse
COV sigmoid Sigmoid
COV distal Distal
COV proximal Proximal
COV rectum Rectum


COV2()
{
python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/CovarianceBuilder.py \
--models_folder /scratch/abarbeira3/v8_process/kkk/all/ \
--models_pattern "UK10K_v7_CEU_(.*)_maf0.05_imputed_europeans_tw_0.5_signif.db" \
--gtex_release_version V8 \
--gtex_genotype_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered.txt.gz \
--gtex_snp_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/genotype/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
--throw \
--snp_covariance_output results/meta_covariance/colon_covariance.txt.gz \
--impute_to_mean \
--verbosity 7
}

COV2