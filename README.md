# Introduction

This repository contains scripts to process GTEx data.
Since these scripts were run in UCHicago's HPC Gardner cluster (CRI), it contains paths in that filesystem.

Subfolders contain in-detail Readmes. An overview of each of those will be progressively added here.

# BigQuery
See `src/badger_scripts/bq`.

For GWAS preprocessing, first convert to plain text files with phenotype column (`column_add_gwas.yaml`),
then convert mixed data columns (`n_samples`, `sample_size` that might have integers and floats depending on pandas whims),
then upload to big query
