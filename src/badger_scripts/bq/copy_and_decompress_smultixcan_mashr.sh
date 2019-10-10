#!/bin/bash
#################################
## Resource Manager Directions ##
#################################
#PBS -N copy_and_decompress_smultixcan_mashr
#PBS -S /bin/bash
#PBS -l walltime=2:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS - q express
#PBS -o logs_other/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_other/${PBS_JOBNAME}.e${PBS_JOBID}.err

###################
## Job Execution ##
###################
cd ${PBS_O_WORKDIR}
for file in `ls /gpfs/data/im-lab/nas40t2/miltondp/phenomexcan/smultixcan_gtex_v8_on_neale2018/smultixcan_mashr`;
do
  cp /gpfs/data/im-lab/nas40t2/miltondp/phenomexcan/smultixcan_gtex_v8_on_neale2018/smultixcan_mashr/${file} input
  gunzip input/${file}
  echo Extracted
done
