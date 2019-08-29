#!/bin/bash
#PBS -N upload_coloc
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs_u/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_u/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0 python/2.7.13

cd $PBS_O_WORKDIR

cd /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/enloc/eqtl
tar -czvpf enloc_eqtl_eur.tar.gz results_eur
gsutil cp -a public-read enloc_eqtl_eur.tar.gz gs://gtex-gwas-share/enloc/enloc_eqtl_eur.tar.gz
rm enloc_eqtl_eur.tar.gz


cd /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/enloc/sqtl
 cp -r formatted/ results_sqtl_eur
tar -czvpf enloc_sqtl_eur.tar.gz results_sqtl_eur
gsutil cp -a public-read enloc_sqtl_eur.tar.gz gs://gtex-gwas-share/enloc/enloc_sqtl_eur.tar.gz
rm -rf results_sqtl_eur
rm enloc_sqtl_eur.tar.gz