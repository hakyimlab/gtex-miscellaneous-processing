#!/bin/bash

module load gcc/6.2.0 python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/compute_genomic_mapping.py \
-liftover /gpfs/data/im-lab/nas40t2/abarbeira/data/liftover/hg17ToHg38.over.chain.gz \
-db_snp_file /gpfs/data/im-lab/nas40t2/abarbeira/data/ucsc-hg/snp125_hg17.txt.gz \
-snp_reference_metadata /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered_maf0.01_monoallelic_variants.txt.gz \
-output map_snp125_hg17.txt.gz \
-discard unmatched_snp125_hg17.txt.gz