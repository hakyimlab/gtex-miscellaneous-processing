#!/bin/bash
#PBS -N convert_dbsnp
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=16:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=2gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load python/3.5.3

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/parse_db_snp.py \
-input /group/im-lab/nas40t2/abarbeira/data/ucsc-hg/snp125_hg17.txt.gz \
-output results/snp125_hg17_parsed.txt.gz

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/parse_db_snp.py \
-input /group/im-lab/nas40t2/abarbeira/data/ucsc-hg/snp130_hg18.txt.gz \
-output results/snp130_hg18_parsed.txt.gz

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/parse_db_snp.py \
-input /group/im-lab/nas40t2/abarbeira/data/ucsc-hg/snp150_hg19.txt.gz \
-output results/snp150_hg19_parsed.txt.gz

#python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/parse_db_snp.py \
#-input /group/im-lab/nas40t2/abarbeira/data/ucsc-hg/snp150_hg38.txt.gz \
#-output results/snp150_hg38_parsed.txt.gz

