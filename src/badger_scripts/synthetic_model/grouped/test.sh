#PBS -N yaling_harmonization
#PBS -S /bin/bash
#PBS -l walltime=12:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=16gb
#PBS -o logs_imp/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_imp/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0 python/3.5.3

export MKL_NUM_THREADS=1
export OPEN_BLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/covariance_for_model_group.py \
-parquet_genotype_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic \
-parquet_genotype_pattern "gtex_v8_eur_itm.chr(\d+).variants.parquet" \
-group /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/intron_id_mapping/Whole_Blood.leafcutter.phenotype_groups.txt.gz \
-model_db_group_key /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/mashr/mashr_Whole_Blood.db \
-model_db_group_value /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/sqtl/mashr/mashr_Whole_Blood.db \
-parsimony 9 \
-output kk/test.txt.gz