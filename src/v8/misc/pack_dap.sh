#!/bin/bash
#PBS -N pack_dapg
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=32:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

F=results/dapg
OF=/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/dapg

for file in $F/*; do
    echo $(basename ${file})
    printf "\npacking\n\n"
    tar -czvpf dapg_v8_$(basename ${file}).tar.gz $file
    printf "\nmoving\n\n"
    mv dapg_v8_$(basename ${file}).tar.gz $OF
done

printf "\ndone\n\n"
