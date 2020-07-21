#!/usr/bin/env bash



#module load gcc/6.2.0 qctool/2.0
module load gcc/6.2.0 plink/2.0

OF=/scratch/abarbeira3/data/1000G_hg37_bgen_from_plink
[ -d  $OF ] || mkdir -p $OF

#qctool_v2.0-rc5 \
#-g /scratch/abarbeira3/data/1000G_hg37/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#-og $OF/chr22.bgen

plink2 \
--vcf /scratch/abarbeira3/data/1000G_hg37/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--export bgen-1.3 ref-first \
--out $OF/chr22 \
--threads 1