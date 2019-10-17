order in which this was done:
- setup_samples.sh: gets legacy IDS from GEUVADIS and looks those available in hg38
- build_expression.R: converts and filters GEUVADIS expression
- `get_geuvadis_snps.py` merely extarcts the snps available from selected geuvadis dosages and builds an annotation file
- `geuvadis_eur_gene_name_key.py` builds a mapping from geuvdis gene names to genes in prediction models