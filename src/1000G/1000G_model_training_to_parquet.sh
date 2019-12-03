#!/bin/bash
#PBS -N job_ModelTrainingToParquet_1000G_V8_EUR
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=96:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=128gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -t 1-22

cd $PBS_O_WORKDIR
module load gcc/6.2.0
module load python/3.5.3
#module load miniconda3
#source activate numa_cri

#PBS_ARRAYID=22

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/model_training_genotype_to_parquet.py \
-snp_annotation_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/1000G_hg38_EUR_MT/chr${PBS_ARRAYID}_annotation.txt.gz METADATA \
-input_genotype_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/1000G_hg38_EUR_MT/chr${PBS_ARRAYID}_genotype.txt.gz  \
--filter_maf 0.01 \
-parsimony 9 \
--only_in_key \
-output_prefix /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/1000G_hg38_EUR_maf0.01_parquet/chr${PBS_ARRAYID}

#-snp_annotation_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/1000G_hg38/metadata.txt.gz \
#-input_genotype_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/1000G_hg38/chr${PBS_ARRAYID}_genotype.txt.gz
#-snp_annotation_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/1000G_hg38/metadata.txt.gz METADATA \
#