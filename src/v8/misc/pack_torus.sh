#!/bin/bash
#PBS -N pack_torus
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=8:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

echo "packing"
tar -czvpf torus.tar.gz results

echo "copying"
mv torus.tar.gz /group/im-lab/nas40t2/abarbeira/projects/gtex_v8

printf "\ndone\n\n"
#echo "unpacking"
#cd /group/im-lab/nas40t2/abarbeira/projects/gtex_v8/
#tar -xzvpf torus.tar.gz
#rm torus.tar.gz