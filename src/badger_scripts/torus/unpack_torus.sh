#!/usr/bin/env bash
#PBS -N unpack_torus
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

tar -xzvpf torus_eqtl_priors.tar.gz
mkdir torus_prior
mv results/torus_prior torus_prior/eqtl
