#!/bin/bash
#PBS -N gtex_v8_meta_covariance
#PBS -S /bin/bash
#PBS -l walltime=12:00:00
#PBS -l mem=300gb
#PBS -l nodes=1:ppn=1
#PBS -o logs_meta_cvo/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_meta_cov/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

module load intel/2017
module load python/2.7.13

export MKL_NUM_THREADS=1
export OPEN_BLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1

python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/CovarianceBuilder.py \
--models_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/elastic_net_models \
--models_pattern "en_(.*).db" \
--gtex_release_version V8 \
--gtex_genotype_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered.txt.gz \
--gtex_snp_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/genotype/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
--throw \
--snp_covariance_output /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/meta_covariance/en/gtex_v8_snp_covariance.txt.gz \
--impute_to_mean \
--verbosity 7