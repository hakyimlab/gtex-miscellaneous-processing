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

module load gcc/4.9.4
module load bcftools/1.4.0
module load python/3.6.0
########################################################################################################################

I=gtex_v8_eur_shapeit2_phased_maf01.vcf.gz
O=gtex_v8_eur_shapeit2_phased_maf01_snpmaf.txt.gz


cd $PBS_O_WORKDIR

AF ()
{
NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Starting conversion $NOW"

echo -ne "variant_id\tAF\n" | gzip > $2
bcftools query -fill-tags -f '%ID\t%AF\n' $1 | gzip >> $2

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Ending at $NOW"
}


echo "shapeit"

AF \
/group/gtex-group/v8/59348/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.SHAPEIT2_phased.vcf.gz \
gtex_v8_shapeit_freq.txt.gz

echo "other"

AF \
/group/gtex-group/v8/57603/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.vcf.gz \
gtex_v8_freq.txt.gz
