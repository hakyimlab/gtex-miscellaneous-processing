#!/usr/bin/env bash

I=gtex_v8_afr_shapeit2_phased_maf01.vcf.gz
O=gtex_v8_afr_shapeit2_phased_maf01_snps.txt.gz

module load gcc/4.9.4
module load bcftools/1.4.0

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Starting conversion $NOW"

bcftools query +fill-tags -f '%ID\n' $I | gzip - | cat - >> $O

NOW=$(date +%Y-%m-%d/%H:%M:%S)
echo "Ending at $NOW"

