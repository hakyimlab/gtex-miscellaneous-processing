#!/usr/bin/env bash

O="/gpfs/data/im-lab/nas40t2/abarbeira/projects/kk/geuvadis.tar.gz"
tar -czvpf $O \
data/input/annotations/gene_annotation/gencode.v12.genes.gtf \
data/input/annotations/snp_annotation/geuvadis.annot.txt \
data/input/expression_phenotypes/geuvadis.expr.txt \
data/input/genotypes/geuvadis.snps.txt \
data/intermediate/annotations/gene_annotation/gencode.v12.genes.parsed.* \
data/intermediate/annotations/snp_annotation/geuvadis.annot.chr* \
data/intermediate/expression_phenotypes/geuvadis.expr.RDS \
data/intermediate/genotypes/geuvadis.snps.chr* \
data/output/allBetas/gEUVADIS.allBetas.txt \
data/output/allCovariances/gEUVADIS.txt.gz \
data/output/allResults/gEUVADIS.allResults.txt \
data/output/dbs/gEUVADIS_HapMap_alpha0.5_window*

