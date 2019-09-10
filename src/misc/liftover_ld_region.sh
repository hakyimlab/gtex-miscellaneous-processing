#!/usr/bin/env bash

#python genomic_tools/liftover_ld_region.py \
#-input /home/numa/Documents/Projects/data/3rd/ldetect-data/EUR/fourier_ls-all.bed \
#-output results/eur_ld.bed.gz \
#-liftover /home/numa/Documents/Projects/data/LiftOver/hg19ToHg38.over.chain.gz
module load gcc/6.2.0 python/3.5.3

lift()
{
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/liftover_ld_region.py \
-input /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/ldetect-data/$1/fourier_ls-all.bed \
-output results/$2_ld.bed.gz \
-liftover /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/liftover/hg19ToHg38.over.chain.gz
}

lift EUR eur
#lift AFR afr
#lift ASN asn