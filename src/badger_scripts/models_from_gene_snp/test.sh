#!/bin/bash
#PBS -N dapgw_Whole_Blood_w1000000_chr1_sb0_15_model_training
#PBS -S /bin/bash
#PBS -l walltime=04:00:00
#PBS -l mem=4gb
#PBS -l nodes=1:ppn=1

#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load R/3.4.1
module load python/3.5.3

export MKL_NUM_THREADS=1
export OPEN_BLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1

cd $PBS_O_WORKDIR 

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/models_from_gene_snp.py \
-gene_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_stranded.txt \
-features_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.variants_metadata.parquet \
-spec /scratch/abarbeira3/data/3rd/results/parsed_dapg/Whole_Blood.variants_pip.txt.gz PIP 0.01 \
-parsimony 9 \
-output results/gene_snp_Whole_Blood.db
