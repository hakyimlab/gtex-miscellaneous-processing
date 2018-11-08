#!/bin/bash
#PBS -N job_snp_maf_all
#PBS -S /bin/bash
#PBS -l walltime=96:00:00
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
########################################################################################################################

I=/group/gtex-group/v8/57603/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.vcf.gz
O=gtex_v8_all_af.txt.gz

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Starting conversion $NOW"

echo -ne "varID\tAF\n" | gzip - | cat - > $O
bcftools query -fill-tags -f '%ID\t%AF\n' $I | gzip - | cat - >> $O

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Ending at $NOW"