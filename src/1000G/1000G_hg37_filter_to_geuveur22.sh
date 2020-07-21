#!/bin/bash
#PBS -N job_1000g_conversion
#PBS -S /bin/bash
#PBS -l walltime=72:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=32gb
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
#echo -ne "varID\t" | gzip > $3
#bcftools view $1 -S $2 --force-samples -Ou |  bcftools query -l | tr '\n' '\t' | sed 's/\t$/\n/' | gzip >> $3

#The first python inline script will check if a variant is blacklisted
#[ -f $3 ] && rm $3
NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Starting at $NOW"
bcftools view -S $2 --force-samples $1 -Oz > $3

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Ending at $NOW"
}

PBS_ARRAYID=22
INPUT=/scratch/abarbeira3/data/1000G_hg37/ALL.chr${PBS_ARRAYID}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
SAMPLES=/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage/sample_ids.txt
OUTPUT=/scratch/abarbeira3/data/1000G_hg37_geuv_eur/chr${PBS_ARRAYID}.txt.gz
[ -d /scratch/abarbeira3/data/1000G_hg37_geuv_eur ] || mkdir -p /scratch/abarbeira3/data/1000G_hg37_geuv_eur

filter_and_convert $INPUT $SAMPLES  $OUTPUT