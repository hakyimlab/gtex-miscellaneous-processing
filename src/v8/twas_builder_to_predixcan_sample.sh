#!/bin/bash11684756.cri16sc001
#PBS -N job_gtex_v8_filter
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=16gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/predixcan_model_from_twas_builder.py \
-input /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/twas_builder/Adipose_Subcutaneous.twb.gz \
-output /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/twas_builder/Adipose_Subcutaneous.db \
-snp_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
-gene_annotation /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/gencode.v26.annotation.gtf.gz \
-parsimony 9
#-snp_zscore_threshold 4