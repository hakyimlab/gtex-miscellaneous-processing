#!/usr/bin/env bash

#python genomic_tools/liftover_ld_region.py \
#-input /home/numa/Documents/Projects/data/3rd/ldetect-data/EUR/fourier_ls-all.bed \
#-output results/eur_ld.bed.gz \
#-liftover /home/numa/Documents/Projects/data/LiftOver/hg19ToHg38.over.chain.gz

lift()
{
python genomic_tools/liftover_ld_region.py \
-input /home/numa/Documents/Projects/data/3rd/ldetect-data/$1/fourier_ls-all.bed \
-output results/$2_ld.bed.gz \
-liftover /home/numa/Documents/Projects/data/LiftOver/hg19ToHg38.over.chain.gz
}

#lift EUR eur
lift AFR afr
#lift ASN asn