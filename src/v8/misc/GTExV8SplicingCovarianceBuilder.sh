#!/bin/bash
#PBS -N gtex_v8_meta_covariance_splicing
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l mem=600gb
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

python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/CovarianceBuilder.py \
--models_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/elastic_net_models_splicing \
--models_pattern "gtex_splicing_v8_eur_(.*)_signif.db" \
--gtex_release_version V8 \
--gtex_genotype_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered.txt.gz \
--gtex_snp_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/genotype/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
--throw \
--snp_covariance_output results/gtex_v8_splicing_snp_covariance.txt.gz \
--impute_to_mean \
--verbosity 7