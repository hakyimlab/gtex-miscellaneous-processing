#!/bin/bash
#PBS -N gtex_v8_filtered_metadata
#PBS -S /bin/bash
#PBS -l walltime=16:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=16gb
#PBS -o ../logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e ../logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/3.5.3
module load R/3.4.1

cd $PBS_O_WORKDIR

cp /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/extract_allele_frequencies.py .
cp /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/filtered_metadata.R .

echo "frequencies!"
python3 extract_allele_frequencies.py

echo "metadata"
Rscript filtered_metadata.R