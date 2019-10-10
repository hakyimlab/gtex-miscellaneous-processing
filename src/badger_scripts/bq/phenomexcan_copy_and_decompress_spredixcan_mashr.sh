#!/bin/bash
#################################
## Resource Manager Directions ##
#################################
#PBS -N copy_and_decompress_spredixcan_mashr
#PBS -S /bin/bash
#PBS -l walltime=6:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS - q express
#PBS -o other_logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e other_logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

###################
## Job Execution ##
###################
cd ${PBS_O_WORKDIR}
for file in `ls /gpfs/data/im-lab/nas40t2/miltondp/phenomexcan/spredixcan_gtex_v8_on_neale2018/spredixcan_mashr`;
do
  cp /gpfs/data/im-lab/nas40t2/miltondp/phenomexcan/spredixcan_gtex_v8_on_neale2018/spredixcan_mashr/${file} input
  tar -xzf input/${file} -C extracted_input/
  echo Extracted
done
echo Done
