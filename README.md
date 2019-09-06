# Introduction

This repository contains scripts to process GTEx data.
Since these scripts were run in UCHicago's HPC Gardner cluster (CRI), it contains paths in that filesystem.

Subfolders may contain in-detail Readmes. An overview of each of those will be progressively added here.

There is a wide variety of scripts, written in bash, python, R and a few more tools. There is a heavy dependency on 
[Badger](https://github.com/hakyimlab/badger) job submission (an overview is given below in this readme).



# Layout

The folder `src/badger_scripts` contains different processing schemes centered around badger scripts (but also contain other kinds of scripts).

The other folders may contain miscellaneous processing and verifications, most of them needed for one-shot analysis or data exploration.


## Processing genotypes

GTEx genotypes are obtained in vcf format. A combination of samtools, awk and python is used to convert and process them.

`src/vcf_processing/filter_shapeit_vcf_disk_efficient.sh` is a script that preprocesses GTEx data, filtering for specific individuals.

`src/vcf_processing/vcf_to_pred_format.sh` converts the output from the previous script  into PredictDBPipeline genotype formats.

These can be taken as a starting point to extract GTEx data into convenient text files.

## Geuvadis

`src/geuvadis` contains GEUVADIS data parsing. The outputs are mostly used for predicting expression in GEUVADIS data, and comparing said predictions with GEUVADIS measured expression.
`src/geuvadis/1000G_geuv_eur_conversion.sh` is another example of parsing a vcf file (1000G in hg38)


## Badger-based workflows

Most GTEx data processing involving job submission was handled via [Badger](https://github.com/hakyimlab/badger)

### BigQuery

There are several scripts to process and upload text files into google BigQuery.

See `src/badger_scripts/bq` for details.

For GWAS preprocessing, first convert to plain text files with phenotype column (`column_add_gwas.yaml`),
then convert mixed data columns (`n_samples`, `sample_size` that might have integers and floats depending on pandas whims),
then upload to big query

