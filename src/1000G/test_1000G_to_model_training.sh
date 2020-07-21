#!/bin/bash
#PBS -N job_1000G_EUR_to_mt
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=12gb
#PBS -o logs_ge/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_ge/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -t 1-22
########################################################################################################################
#CRI submission dandruff

#cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load python/3.5.3

O=/scratch/abarbeira3/data/1000G_EUR_MT
[ -d $O ] || mkdir -p $O

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/predixcan_format_to_model_training.py \
-snp_reference_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/genotype/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
-samples /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/1000G/selected_hg38_eur_id.txt \
-genotype /scratch/abarbeira3/data/1000G_EUR/chr${PBS_ARRAYID}.txt.gz \
-output_prefix $O/chr${PBS_ARRAYID}
