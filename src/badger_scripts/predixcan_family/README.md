
`metaxcan.jinja` is a multipurpose job template for running S-PrediXcan.
In the `metaxcan*yaml` covered here, the prefixes mean:
`metaxcan_imputed`: GTEx v8 harmonized and imputed traits.
`gtexv6p`, `gtexv7`, `gtexv8` relate to specific GTEx data releases.
`_en_` means that Elastic Models are used. `dapgw` are models where Elastic Net used DAPG PIP as penalty weights on variants with high PIP.
`splicing` are models from splicing instead of expression.
`streamed` is an experimental mode for large prediction models databases and covariance compilations, loading  one gene at a time. These are less lenient on the input data format.
`starnet` is related to models trained on Star Net cohort


`smultixcan.jinja` is an S-MultiXcan job template. There are two yamls (`smultixcan_imputed_gtexv8_en.yaml` and `smultixcan_imputed_gtexv8_en_splicing.yaml`), for running on expression and splicing models.

`predixcan` folder contains yaml scripting to submit predixcan jobs on GEUVADIS genotypes.
`metaxcan_single_snp` are S-PrediXcan jobs using single-snp models (i.e. models where each gene has a single snp as explanatory variable)