#!/bin/bash
#PBS -N upload_covariances
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -o logs_u/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_u/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load miniconda2

source activate numa_gc

cd $PBS_O_WORKDIR

F=/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/dapg/parsed_dapg_maf0.01_w1000000

echo "cluster correlations"
gsutil cp -a public-read $F/*.cluster_correlations.txt.gz gs://gtex-gwas-share/dapg_parsed/sqtl/cluster_correlations
echo "clusters"
gsutil cp -a public-read $F/*.clusters.txt.gz gs://gtex-gwas-share/dapg_parsed/sqtl/clusters
echo "model summary"
gsutil cp -a public-read $F/*.model_summary.txt.gz gs://gtex-gwas-share/dapg_parsed/sqtl/model_summary
echo "models"
gsutil cp -a public-read $F/*.models.txt.gz gs://gtex-gwas-share/dapg_parsed/sqtl/models
echo "models variants"
gsutil cp -a public-read $F/*.models_variants.txt.gz gs://gtex-gwas-share/dapg_parsed/sqtl/models_variants
echo "variants pip"
gsutil cp -a public-read $F/*.variants_pip.txt.gz gs://gtex-gwas-share/dapg_parsed/sqtl/variants_pip


