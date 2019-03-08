#!/bin/bash
#PBS -N jft
#PBS -S /bin/bash
#PBS -l walltime=72:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_ld/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_ld/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/3.5.3

cd $PBS_O_WORKDIR

COV()
{
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/covariance_for_model.py \
-model_db /scratch/abarbeira3/v8_process/kkk/Modelos_jft/UK10K_v7_CEU_$1_maf0.05_imputed_europeans_tw_0.5_signif.db \
-parquet_genotype_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_maf0.01_biallelic \
-parquet_genotype_pattern "gtex_v8_itm.chr(\d+).variants.parquet" \
-parsimony 9 \
-output /scratch/abarbeira3/v8_process/kkk/results/covariances/UK10K_v7_CEU_$1_maf0.05_imputed_europeans_tw_0.5_signif_gtex.txt.gz
}


COV Distal
#COV Proximal
#COV Rectum


