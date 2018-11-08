#!/usr/bin/env bash
#GEMMA_PATH="/home/numa/Downloads/gemma.linux"
GEMMA_PATH="/home/numa/Documents/Projects/3rd/GEMMA/bin/gemma"
STUDY_PREFIX="/home/numa/Documents/Projects/data/3rd/stephens_like/simulated_study_small/study"
OUTPUT="bslmm/results"

#GEMMA has "output" folder as default
[ -d "output/$OUTPUT" ] || mkdir -p "output/$OUTPUT"

$GEMMA_PATH \
-g "$STUDY_PREFIX.geno.txt.gz" \
-p "$STUDY_PREFIX.pheno.txt" \
-a "$STUDY_PREFIX.snp.txt" \
-bslmm 1 \
-o "$OUTPUT"

#/home/numa/Downloads/gemma.linux \
#-g /home/numa/Documents/Projects/data/3rd/stephens_like/simulated_study_small/study.geno.txt.gz \
#-p /home/numa/Documents/Projects/data/3rd/stephens_like/simulated_study_small/study.pheno.txt \
#-a /home/numa/Documents/Projects/data/3rd/stephens_like/simulated_study_small/study.snp.txt \
#-bslmm 1 \
#-o results/bslmm_test/result
