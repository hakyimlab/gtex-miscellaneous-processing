#!/bin/bash
#PBS -N job_gtex_v8_filter
#PBS -S /bin/bash
#PBS -l walltime=120:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=32gb
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

I=/group/gtex-group/v8/59348/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.SHAPEIT2_phased.vcf.gz
O=kk.txt.gz

python3 -c '
import sys
import gzip
import re

with gzip.open(sys.argv[2], "w") as _of:
  with gzip.open(sys.argv[1]) as _if:
    for i,l in enumerate(_if):
        l = l.decode()
        comps = l.strip().split()

        if len(comps) < 3: continue

        v = comps[2]
        cv = v.split("_")
        if cv[0] != "chr4": continue

        p = int(cv[1])
        if p < 49100000: continue
        if p > 49190000: break
        _l = "l_{}\t{}\n".format(i, "\t".join(comps)).encode()
        _of.write(_l)
' $I $O

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Ending at $NOW"
