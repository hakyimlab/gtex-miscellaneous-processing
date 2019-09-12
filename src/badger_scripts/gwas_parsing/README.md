
`gwas_parsing*` yamls are about taking publicly available GWAS and formatting them into an homogeneous format.
Genomic positions might be added, if missing, from dbSNP data. Genomic coordinates might be lifted over to hg38.

The actual magic in each GWAS is coded in [Genomic tools](git@github.com:hakyimlab/summary-gwas-imputation.git)'s `src/gwas_parsing.py`.

`gwas_parameters.yaml` contains the parsing arguments for each GWAS or family of GWAS.
 This exploited the fact that some different GWAS might have a common format, so that the conversion configuration can be shared. 
 `gwas_parameters.yaml` acts as a central database for conversion of all GWAS.
 
 The main motivation to have a master configuration file, and a master conversion file, was to share parsing mechanisms across any GWAS traits as necessary.