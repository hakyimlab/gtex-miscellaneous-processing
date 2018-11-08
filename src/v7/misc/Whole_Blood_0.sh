#!/bin/bash
#PBS -N job_BSLMM_Whole_Blood_0
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

#cd $PBS_O_WORKDIR

#module load gcc/6.2.0
#module load gemma/0.96
#module load python/3.5.3

D=/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2

python3 "/home/heroico/Documents/Projects/nextgen/genomic_tools/src/genomic_tools/BSLMMOnStudy.py" \
--gemma_command gemma \
--intermediate_folder intermediate/kk1 \
--gene_annotation "/home/heroico/Documents/Projects/data/scott/gencode.v19.genes.patched_contigs.parsed.txt" \
--parquet_genotype "$D/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.variants.parquet" \
--parquet_genotype_metadata "$D/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.variants_metadata.parquet" \
--parquet_phenotype "$D/abarbeira/projects/gtex_v7/model_training_v7_europeans/results/gtex_v7_eur_hapmapceu.expression.Whole_Blood.parquet" \
--window 1000000 \
--verbosity 5 \
--sub_batches 1000 \
--sub_batch 0 \
--output_weights results/Whole_Blood_0.weights.txt.gz \
--output_covariance results/Whole_Blood_0.covariance.txt.gz \
--output_stats results/Whole_Blood_0.stats.txt.gz
