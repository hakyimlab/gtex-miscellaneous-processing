#!/bin/bash
#PBS -N download_1000G
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=2:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=2gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -t 1-22

cd $PBS_O_WORKDIR

#I=1
#for I in {1..22}
#do
wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000_genomes_project/release/20190312_biallelic_SNV_and_INDEL/ALL.chr${PBS_ARRAYID}.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz
wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000_genomes_project/release/20190312_biallelic_SNV_and_INDEL/ALL.chr${PBS_ARRAYID}.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz.tbi
#done