# BigQuery upload

The general idea is that the badger scipts add a few columns extracted from the filenames, then uploads them to google bigquery.

Take a look at GWAS upload:

1) Convert to plain text files with phenotype column (`column_add_gwas.yaml`).
2) Convert mixed data columns (`n_samples`, `sample_size` that might have integers and floats depending on pandas whims), using `gwas_clean.yaml`.
3) Upload to big query. Examine `bq_dapg_upload.sh`; this script can easily be modified to upload any sort of tabular text data (i.e. csv or tsv).

## phenomexcan

There is a related, similar project dealing with predixcan/enloc application to UKB traits.
To build tables for a necessary shiny app, here we ran the following scripts in this order:
```bash
phenomexcan_column_add_smultixcan_eqtl_mashr.yaml
phenomexcan_postprocess_fastenloc_eqtl.yaml
phenomexcan_sme_table_files.yaml

column_add_smultixcan_eqtl_mashr_eur.yaml
badger_scripts/bq/postprocess_enloc_eqtl.yaml
phenomexcan_sme_public_gwas_table_files.yaml

phenomexcan_bq_shinyapp_support.sh
```