#!/bin/bash
#PBS -N parse_splicing
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=8:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/parse_splicing_for_stats.py \
-gencode /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/expression/gencode_v26_parsed.txt \
-input /gpfs/data/gtex-group/v8/Leafcutter/GTEx_Analysis_v8_sQTL_phenotype_matrices/Liver.v8.leafcutter_phenotypes.bed.gz \
-output Whole_Blood_clusters.txt.gz
