#!/bin/bash
#PBS -N get_intron_map
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=04:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=2gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -t 1-50

module load gcc/6.2.0
module load python/3.5.3

cd $PBS_O_WORKDIR

python3 \
/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/get_intron_map.py \
${PBS_ARRAYID}