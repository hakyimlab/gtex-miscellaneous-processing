#!/bin/bash
#PBS -N gtex_v8_meta_covariance_expression_endapgw
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l mem=600gb
#PBS -l nodes=1:ppn=1
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load python/3.5.3

export MKL_NUM_THREADS=1
export OPEN_BLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1


python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/CovarianceBuilder.py \
--models_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/elastic_net_models_dapgw_rsid \
--models_pattern "dapgw_(.*).db" \
--gtex_release_version V8 \
--gtex_genotype_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered.txt.gz \
--gtex_snp_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/genotype/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
--throw \
--snp_covariance_output results/gtex_v8_expression_endapgw_snp_covariance_rsid.txt.gz \
--impute_to_mean \
--verbosity 7