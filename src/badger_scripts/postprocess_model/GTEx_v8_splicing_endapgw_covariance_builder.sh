#!/bin/bash
#PBS -N gtex_v8_meta_covariance_expression_endapgw
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=1
#PBS -o logs_mc_endapgw/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_mc_endapgw/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load python/3.5.3

export MKL_NUM_THREADS=1
export OPEN_BLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/meta_covariance_for_models.py \
-model_db_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v0/elastic_net_models_splicing \
-model_db_file_pattern "dapgw_(.*).db" \
-parquet_genotype_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic \
-parquet_genotype_pattern "gtex_v8_eur_itm.chr(\d+).variants.parquet" \
-output results/gtex_v8_splicing_endapgw_snp_covariance.txt.gz \
-parsimony 7