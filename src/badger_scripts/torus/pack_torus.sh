#!/usr/bin/env bash
#PBS -N parse_torus
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=16gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd /scratch/abarbeira3/v8_process/torus/eqtl
tar -czvpf torus_eqtl_priors.tar.gz results