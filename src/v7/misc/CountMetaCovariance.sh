#!/bin/bash
#PBS -N gtex_v7_count_meta
#PBS -S /bin/bash
#PBS -l walltime=4:00:00
#PBS -l mem=4gb
#PBS -l nodes=1:ppn=1
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load python/3.5.3

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/count_keyed_entries.py \
-input_file /group/im-lab/nas40t2/abarbeira/data/metaxcan/meta_covariance_v7/snp_covariance_v7.txt.gz \
-output_file results/v7_covariance_count.txt.gz \
-parsimony 7