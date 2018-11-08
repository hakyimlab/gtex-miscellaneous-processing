#!/bin/bash
#PBS -N get_reference_metadata
#PBS -S /bin/bash
#PBS -l walltime=12:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=32gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
########################################################################################################################
#CRI submission dandruff


module load gcc/6.2.0
module load python/3.5.3

cd $PBS_O_WORKDIR

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/get_reference_metadata.py \
-genotype /group/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered.txt.gz \
-annotation /group/im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/genotype/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
-filter MAF 0.01 \
-filter TOP_CHR_POS_BY_FREQ \
-output gtex_v8_eur_filtered_maf0.01_monoallelic_variants.txt.gz