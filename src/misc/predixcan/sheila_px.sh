#!/bin/bash
###############################
# Resource Manager Directives #
###############################
### Set the name of the job
#PBS -N predixcan.pbs
### Select the shell you would like to script to execute within
#PBS -S /bin/bash
### Inform the scheduler of the expected runtime
#PBS -l walltime=0:30:00
### Inform the scheduler of the number of CPU cores for your job
#PBS -l nodes=2:ppn=2
### Inform the scheduler of the amount of memory you expect
#PBS -l mem=2gb
### Set the destination for your program's output and error
#PBS -o ./${PBS_JOBNAME}.o${PBS_JOBID}
#PBS -e ./${PBS_JOBNAME}.e${PBS_JOBID}
#################
# Job Execution #
#################
# load needed modules

module load gcc/6.2.0
module load python/3.5.0

pathname=/gpfs/data/im-lab/nas40t2/prajagopal/predixcan
o=/scratch/abarbeira3/v8_process/kk
export MKL_NUM_THREADS=1
export OPEN_BLAS_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1

cd $pathname

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/PrediXcan2/Software/PrediXcan.py --predict \
--dosages $pathname/genotype/ \
--dosages_prefix BRCA_chr \
--samples $pathname/samples.txt \
--weights /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/elastic_net_models/en_Breast_Mammary_Tissue.db \
--pheno $pathname/phenotype/BRCA_white.fam \
--output_prefix $pathname/results
