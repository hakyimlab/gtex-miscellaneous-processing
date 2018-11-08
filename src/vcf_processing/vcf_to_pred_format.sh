#!/bin/bash
#PBS -N job_gtex_v8_to_pred_format_eur
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


########################################################################################################################
# Convert VCF like those in GTEx to predictdb format

convert ()
{
NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Starting conversion $NOW"

#- is redirection from stdin
echo -ne "varID\t" | gzip - | cat - > $2
bcftools query -l $1 | tr '\n' '\t' | sed 's/\t$/\n/' - | gzip - |  cat - >> $2
#the awk command adds the genotype into a dosage.
#The old line '%CHROM\_%POS\_%REF\_%ALT\_b38[\t%GT]\n'
bcftools query -e 'MAF<0.01' -f '%ID[\t%GT]\n'  $1 | \
awk '
{
for (i = 1; i <= NF; i++) {
    if (substr($i,0,1) == "c") {
        printf("%s",$i)
    } else if ( substr($i, 0, 1) == ".") {
        printf("\tNA")
    } else if ($i ~ "[0-9]|[0-9]") {
        n = split($i, array, "|")
        printf("\t%d",array[1]+array[2])
    } else {
        #printf("\t%s",$i)
        printf("Unexpected: %s",$i)
        exit 1
    }
}
printf("\n")
}
' | \
gzip - | cat - >>  $2

NOW=$(date +%Y-%m/%d:%H:%M:%S)
echo "Ending conversion $NOW"
}

#I=gtex_v8_eur_combined_sites.vcf.gz
#O=gtex_v8_eur.txt.gz
#I=gtex_v8_afr_shapeit2_phased_maf01.vcf.gz
#O=gtex_v8_afr_shapeit2_phased_maf01.txt.gz
I=gtex_v8_eur_shapeit2_phased_maf01.vcf.gz
O=gtex_v8_eur_shapeit2_phased_maf01.txt.gz

convert $I $O
