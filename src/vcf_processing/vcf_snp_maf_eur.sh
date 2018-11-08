#!/usr/bin/env bash

I=gtex_v8_eur_shapeit2_phased_maf01.vcf.gz
O=gtex_v8_eur_shapeit2_phased_maf01_snpmaf.txt.gz

module load gcc/4.9.4
module load bcftools/1.4.0
cd $PBS_O_WORKDIR

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Starting conversion $NOW"

echo -ne "varID\tMAF\n" | gzip - | cat - > $O
bcftools query -fill-tags -f '%ID\t%MAF\n' $I | gzip - | cat - >> $O

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Ending at $NOW"

