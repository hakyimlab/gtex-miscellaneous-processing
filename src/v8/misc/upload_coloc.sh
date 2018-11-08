#!/bin/bash
#PBS -N upload_coloc
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs_u/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_u/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load miniconda2

source activate numa_gc

cd $PBS_O_WORKDIR

STORE=/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/coloc

EP=results_coloc__enloc_priors.tar.gz
tar -czvpf $EP results_enloc_priors
gsutil cp -a public-read $EP gs://coloc/
mv $EP $STORE

EPBSE=results_coloc__enloc_priors_bse.tar.gz
tar -czvpf $EPBSE results_enloc_priors_bse
gsutil cp -a public-read $EPBSE gs://coloc/
mv $EPBSE $STORE