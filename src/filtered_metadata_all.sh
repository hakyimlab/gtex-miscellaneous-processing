#!/bin/bash
#PBS -N gtex_v8_filtered_metadata_all
#PBS -S /bin/bash
#PBS -l walltime=16:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=16gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/3.5.3
module load R/3.4.1

cd $PBS_O_WORKDIR

cp /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/extract_allele_frequencies.py .
cp /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/filtered_metadata.R .

echo "frequencies!"
#python3 extract_allele_frequencies.py gtex_v8_all.txt.gz gtex_v8_all_frequency.txt.gz

echo "metadata"
Rscript filtered_metadata.R \
gtex_v8_all_frequency.txt.gz \
gtex_v8_all_selected_variants.txt \
/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
0.01

gzip gtex_v8_all_selected_variants.txt

echo "done"