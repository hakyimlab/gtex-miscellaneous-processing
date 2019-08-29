#!/bin/bash
#PBS -N upload_torus
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -o logs_u/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_u/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/2.7.13

cd $PBS_O_WORKDIR


gsutil cp -a public-read \
/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/torus_eqtl_priors.tar.gz \
gs://gtex-gwas-share/torus/torus_eqtl_priors.tar.gz

#rm /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/torus_eqtl_priors.tar.gz