#!/bin/bash
#################################
## Resource Manager Directions ##
#################################
#PBS -N move_decompressed_files_to_lab_share
#PBS -S /bin/bash
#PBS -l walltime=12:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o other_logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e other_logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

###################
## Job Execution ##
###################
cd ${PBS_O_WORKDIR}
echo "There are `ls extracted_input | wc -l` files to copy"
for file in `ls extracted_input/`
do
  cp extracted_input/${file} /gpfs/data/im-lab/nas40t2/owen/spredixcan_mashr/decompressed_input
done
echo "Finished extracting"
echo "There are `ls /gpfs/data/im-lab/nas40t2/owen/spredixcan_mashr/decompressed_input | wc -l` files in the target"