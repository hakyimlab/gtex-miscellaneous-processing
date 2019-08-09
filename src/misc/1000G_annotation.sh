#!/bin/bash
#PBS -N job_1000g_conversion
#PBS -S /bin/bash
#PBS -l walltime=4:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
#PBS -t 1-22
########################################################################################################################
#CRI submission dandruff
cd $PBS_O_WORKDIR

module load gcc/4.9.4
module load bcftools/1.4.0
module load python/3.6.0
########################################################################################################################


filter_and_convert ()
{
echo -ne "chromosome\tvariant\tposition\tref_allele\talt_allele\tMAF\n" | gzip > $3
#bcftools view $1 -S $2 --force-samples -Ou |  bcftools query -l | tr '\n' '\t' | sed 's/\t$/\n/' | gzip >> $3

#The first python inline script will check if a variant is blacklisted
#[ -f $3 ] && rm $3
NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Starting at $NOW"
bcftools view -S $2 --force-samples $1 -Ou | \
bcftools +fill-tags | bcftools query -f '%CHROM\t%ID\t%POS\t%REF\t%ALT\t%MAF\n' | gzip >> $3

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Ending at $NOW"
}

INPUT=/scratch/abarbeira3/data/1000G/ALL.chr${PBS_ARRAYID}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
SAMPLES=/gpfs/data/im-lab/nas40t2/abarbeira/data/1000G/afr_ids.txt
OUTPUT=/scratch/abarbeira3/data/1000G_AFR/chr${PBS_ARRAYID}.txt.gz
filter_and_convert $INPUT $SAMPLES  $OUTPUT

#Can be conctenated with
#
#echo -ne "chromosome\tvariant\tposition\tref_allele\talt_allele\tMAF\n" > 1000G_AFR_annotation.txt
zcat chr1.txt.gz > 1000G_AFR_annotation.txt
zgrep -vh '^chromosome' chr{2..22}.txt.gz >> 1000G_AFR_annotation.txt
gzip 1000G_AFR_annotation.txt