#!/bin/bash
#PBS -N job_gtex_v8_filter
#PBS -S /bin/bash
#PBS -l walltime=120:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=16gb
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
NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Starting at $NOW"

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "filtering samples at $NOW"

I0=i_0.vcf.gz
I1=i_1.txt.gz

# -Ov | head -5000 | gzip > $I0 for debugging
bcftools view -S $2 --force-samples $1 -o $I0 -Oz

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "converting to pred format at $NOW"

echo -ne "varID\t" | gzip > $I1
bcftools query -l $1 | tr '\n' '\t' | sed 's/\t$/\n/' - | gzip  >> $I1
bcftools query -f '%ID[\t%GT]\n' i_0.vcf.gz | gzip >> $I1

echo "deleting previous intermediate"
rm $I0

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Filtering and imputing to mean at $NOW"
#The first python inline script will check if a variant is blacklisted and impute to mean
python3 -c '
import sys
import gzip
import re

#read blacklist
b = set()
with gzip.open(sys.argv[1]) as f:
  for l in f:
    comps = l.decode().strip().split()
    b.add(comps[0])

def dosage(comps):
    def _t(x):
      if x[0] == ".": return "NA"
      c = x.split("/")
      return int(c[0]) + int(c[1])
    d = [_t(x) for x in comps[1:]]
    return d

def to_line(comps):
    d = dosage(comps)
    comps = [comps[0]] + [str(x) if x != "NA" else "NA" for x in d]
    return "{}\n".format("\t".join(comps))

#import numpy
#def qdi(comps):
#    d = dosage(comps)
#    mean = numpy.mean(numpy.array([x for x in d if x != "NA"], dtype=numpy.float32))
#    mean = str(mean)
#    comps = [comps[0]] + [str(x) if x != "NA" else mean for x in d]
#    return "{}\n".format("\t".join(comps))

with gzip.open(sys.argv[3]) as _i:
    with gzip.open(sys.argv[2], "w") as _o:
        for i,l in enumerate(_i):
            if i ==0:
                _o.write(l)
                continue
            comps = l.decode().strip().split()
            v = comps[0]
            # Works for the header line too, pay attention if in need to modify
            if v in b:
                continue
            _o.write(to_line(comps).encode())
' $3 $4 $I1

echo "deleting previous intermediate"
rm $I1

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Ending at $NOW"
}

INPUT=/group/gtex-group/v8/57603/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.vcf.gz
SAMPLES=eur_samples.txt
OUTPUT=gtex_v8_eur_filtered.txt.gz
BLACKLIST=gtex_variants_blacklist.txt.gz
filter_and_convert $INPUT $SAMPLES $BLACKLIST $OUTPUT