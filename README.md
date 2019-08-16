# BigQuery
See `src/badger_scripts/bq`.

For GWAS preprocessing, first convert to plain text files with phenotype column (`column_add_gwas.yaml`),
then convert mixed data columns (`n_samples`, `sample_size` that might have integers and floats depending on pandas whims),
then upload to big query