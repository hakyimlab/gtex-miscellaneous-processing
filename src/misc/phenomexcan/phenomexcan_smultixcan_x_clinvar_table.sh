#!/bin/bash
#PBS -N process_phenomexcan_pairs
#PBS -S /bin/bash
#PBS -l walltime=6:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs_phenomexcan/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_phenomexcan/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/3.5.3

cd $PBS_O_WORKDIR

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/phenomexcan/phenomexcan_smultixcan_x_clinvar_table.py