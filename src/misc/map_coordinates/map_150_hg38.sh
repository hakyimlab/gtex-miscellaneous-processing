#!/bin/bash
#PBS -N map_150_hg38
#PBS -S /bin/bash
#PBS -l walltime=08:00:00
#PBS -l mem=16gb
#PBS -l nodes=1:ppn=1
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0 python/3.5.3

cd $PBS_O_WORKDIR

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/compute_genomic_mapping.py \
-db_snp_file /gpfs/data/im-lab/nas40t2/abarbeira/data/ucsc-hg/snp150_hg38.txt.gz \
-snp_reference_metadata /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered_maf0.01_monoallelic_variants.txt.gz \
-output results/map_snp150_hg38.txt.gz \
-discard results/unmatched_snp150_hg38.txt.gz