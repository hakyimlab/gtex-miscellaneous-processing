#!/bin/bash
#PBS -N spredixcan_igwas_v8_splicing_GIANT_HEIGHT__PM__Whole_Blood
#PBS -S /bin/bash
#PBS -l walltime=2:00:00
#PBS -l mem=4gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_en_v8_splicing/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_en_v8_splicing/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/2.7.13

export MKL_NUM_THREADS=1
export OPEN_BLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1

#cd $PBS_O_WORKDIR

/gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/MetaXcan.py \
--gwas_file /gpfs/data/im-lab/nas40t2/Data/SummaryResults/imputed_gwas_hg38_1.1/imputed_GIANT_HEIGHT.txt.gz \
--snp_column variant_id --effect_allele_column effect_allele --non_effect_allele_column non_effect_allele --zscore_column zscore \
--model_db_path  /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/twas_builder/Adipose_Subcutaneous.db \
--covariance /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/twas_builder/Adipose_Subcutaneous.txt.gz \
--additional_output \
--throw \
--verbosity 9 \
--output_file results/sp_imputed_gwas_gtexv8_en_splicing/spredixcan_igwas_DAPGMODEL_splicing_GIANT_HEIGHT__PM__Whole_Blood.csv