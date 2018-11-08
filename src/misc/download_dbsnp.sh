#!/bin/bash
#PBS -N download_dbsnp
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=2:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=2gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

wget http://hgdownload.cse.ucsc.edu/goldenPath/hg17/database/snp125.txt.gz -O snp125_hg17.txt.gz
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg18/database/snp130.txt.gz -O snp130_hg18.txt.gz
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/snp150.txt.gz -O snp150_hg19.txt.gz

#wget http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/snp150.txt.gz -O snp150_hg38.txt.gz