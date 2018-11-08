#!/usr/bin/env bash

##GEMMA_PATH="/home/numa/Downloads/gemma.linux"
#GEMMA_PATH="/home/numa/Documents/Projects/3rd/GEMMA/bin/gemma"
#STUDY_PREFIX="intermediate/GID1/study"
#OUTPUT_DIR="intermediate/GID1/results"
#OUTPUT="results"
##GEMMA has "output" folder as default
#[ -d "$OUTPUT_DIR" ] || mkdir -p "$OUTPUT_DIR"
#
#$GEMMA_PATH \
#-g "$STUDY_PREFIX.geno.txt.gz" \
#-p "$STUDY_PREFIX.pheno.txt" \
#-a "$STUDY_PREFIX.snp.txt" \
#-bslmm 1 \
#-outdir $OUTPUT_DIR \
#-o "$OUTPUT"

GEMMA_PATH=/home/numa/Documents/Projects/3rd/GEMMA/bin/gemma
STUDY_PREFIX="results/simulated_study_small/bimbam/study"
OUTPUT_DIR="results/simulated/bslmm"
OUTPUT="results"

#GEMMA has "output" folder as default
[ -d "$OUTPUT_DIR/$OUTPUT" ] || mkdir -p "$OUTPUT_DIR/$OUTPUT"

$GEMMA_PATH \
-g "$STUDY_PREFIX.geno.txt.gz" \
-p "$STUDY_PREFIX.pheno.txt" \
-a "$STUDY_PREFIX.snp.txt" \
-bslmm 1 \
-outdir $OUTPUT_DIR \
-o "$OUTPUT"
