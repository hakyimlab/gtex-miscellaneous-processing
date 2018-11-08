#!/usr/bin/env bash

#OUTPUT="results/simulated_study_small/bimbam/study"
#python genomic_tools/SimulateStudy.py -bimbam_output_prefix $OUTPUT -verbosity 50 #-snps_per_chromosome 10

#OUTPUT="results/simulated_study_small/parquet/study"
#python genomic_tools/simulate_study.py -parquet_output_prefix $OUTPUT

OUTPUT="results/simulated_study_small/sbam"
python genomic_tools/simulate_study.py -sbam_output_folder $OUTPUT
