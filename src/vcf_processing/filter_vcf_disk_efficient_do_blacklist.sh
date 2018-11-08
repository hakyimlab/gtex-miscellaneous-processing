#!/bin/bash
#PBS -N job_gtex_v8_filter
#PBS -S /bin/bash
#PBS -l walltime=120:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=64gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err
########################################################################################################################
#CRI submission dandruff
cd $PBS_O_WORKDIR
#module load gcc/6.2.0
#module load zlib/1.2.8
#module load bzip2/1.0.6
#module load xz/5.2.2
#module load htslib/1.4.0
module load gcc/4.9.4
module load bcftools/1.4.0
module load python/3.6.0
########################################################################################################################

########################################################################################################################

# Filter files like those in GTEx to specific individuals, keeping only biallelic snps with MAF<0.01
#bcftools view -S $SAMPLES -e 'MAF[0]<0.01 | TYPE!="snp" | N_ALT!=1' -o $OUTPUT -Oz --force-samples $I

#I=/group/gtex-group/v8/57603/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.vcf.gz
#SAMPLES=afr_samples.txt
#OUTPUT=gtex_v8_afr_combined_sites.vcf.gz

#Should never have listened and used this file.
#I=/group/gtex-group/v8/59348/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.SHAPEIT2_phased.MAF01.vcf.gz
#bcftools view -S $SAMPLES -e 'MAF<0.01' -o $OUTPUT -Oz --force-samples $I



filter_and_convert ()
{
echo -ne "varID\t" | gzip > $4

bcftools view $1 -S $2 --force-samples -Ou |  bcftools query -l | tr '\n' '\t' | sed 's/\t$/\n/' - | gzip >> $4
#The first python inline script will check if a variant is blacklisted
NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Starting at $NOW"
bcftools view $1 -S $2 --force-samples -Ou | \
bcftools query -f '%ID[\t%GT]\n' | \
awk '
{
for (i = 1; i <= NF; i++) {
    if (substr($i,0,1) == "c") {
        printf("%s",$i)
    } else if ( substr($i, 0, 1) == ".") {
        printf("\tNA")
    } else if ($i ~ "[0-9]/[0-9]") {
        n = split($i, array, "/")
        printf("\t%d",array[1]+array[2])
    } else {
        #printf("\t%s",$i)
        printf("Unexpected: %s",$i)
        exit 1
    }
}
printf("\n")
}
' | python3 -c '
import sys
import gzip
import re

#read blacklist
b = set()
with gzip.open(sys.argv[1]) as f:
  for l in f:
    comps = l.decode().strip().split()
    b.add(comps[0])

with gzip.open(sys.argv[2], "a") as f:
  for l in sys.stdin:
    v = l.split()[0]
    # Works for the header line too, pay attention if in need to modify
    if v in b:
      continue
    f.write(l.encode())
' $3 $4

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Ending at $NOW"
}

INPUT=/group/gtex-group/v8/57603/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.vcf.gz
SAMPLES=eur_samples.txt
OUTPUT=gtex_v8_eur_filtered.txt.gz
BLACKLIST=gtex_variants_blacklist.txt.gz
filter_and_convert $INPUT $SAMPLES $BLACKLIST $OUTPUT