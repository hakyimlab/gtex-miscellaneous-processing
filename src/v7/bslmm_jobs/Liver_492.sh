#!/bin/bash
#PBS -N job_BSLMM_Liver_492
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=40:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

#cd $PBS_O_WORKDIR

#module load gcc/6.2.0
#module load gemma/0.96
#module load python/3.5.3

F=/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2

python3 /home/numa/Documents/Projects/nextgen/genomic_tools/src/genomic_tools/bslmm_on_study.py \
--gemma_command /home/numa/Documents/Projects/3rd/GEMMA/bin/gemma \
--intermediate_folder intermediate/Liver_492 \
--gene_annotation $F/scott/gtex_v7_imputed_europeans/prepare_data/expression/gencode.v19.genes.patched_contigs.parsed.txt \
--parquet_genotype $F/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.variants.parquet \
--parquet_genotype_metadata $F/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.variants_metadata.parquet \
--parquet_phenotype $F/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.expression.Liver.parquet \
--window 1000000 \
--verbosity 7 \
--sub_batches 1000 \
--sub_batch 492 \
--output_hyperparameters results/Liver_492.hyperparameters.txt.gz \
--output_stats results/Liver_492.stats.txt.gz

#python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/BSLMMOnStudy.py \
#--gemma_command gemma \
#--intermediate_folder intermediate/Liver_492 \
#--gene_annotation /group/im-lab/nas40t2/scott/gtex_v7_imputed_europeans/prepare_data/expression/gencode.v19.genes.patched_contigs.parsed.txt \
#--parquet_genotype /group/im-lab/nas40t2/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.variants.parquet \
#--parquet_genotype_metadata /group/im-lab/nas40t2/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.variants_metadata.parquet \
#--parquet_phenotype /group/im-lab/nas40t2/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.expression.Liver.parquet \
#--window 1000000 \
#--verbosity 7 \
#--sub_batches 1000 \
#--sub_batch 492 \
#--output_hyperparameters results/Liver_492.hyperparameters.txt.gz \
# > /dev/null