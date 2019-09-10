# BigQuery upload

The general idea is that the badger scipts add a few columns extracted from the filenames, then uploads them to google bigquery.

Take a look at GWAS upload:

1) Convert to plain text files with phenotype column (`column_add_gwas.yaml`).
2) Convert mixed data columns (`n_samples`, `sample_size` that might have integers and floats depending on pandas whims), using `gwas_clean.yaml`.
3) Upload to big query. Examine `bq_dapg_upload.sh`; this script can easily be modified to upload any sort of tabular text data (i.e. csv or tsv).