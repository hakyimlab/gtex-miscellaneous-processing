# DAPG

These runs depend on `dapg`, available at [DAP](https://github.com/xqwen/dap) repository.

This DAP-G scripting assumes torus priors results (see `src/badger_scripts/torus`), and  genotype, expression and covariates in parquet files.
For genotypes, see [this](https://github.com/hakyimlab/summary-gwas-imputation/wiki/Reference-Data-Set-Compilation) (also `src/vcf_processing`, `src/v8/ModelTrainingToParquetV8CRI.sh`)
Expression, splicing and covariates are converted in `src/badger_scripts/formatting`.

- `dap_on_study_v8_eqtl.yaml`, `dap_job_spec_eqtl.yaml` are DAP-G runs on expression. 
- `dap_on_study_v8_sqtl.yaml`, `dap_job_spec_sqtl.yaml` are DAP-G runs on splicing.

The jobs cover execution of DAPG in a Tissue, chromosome, and sub baches. Specifics are different for splicing and expression.
To make the job management easier, each job outputs into its own folder. To be usable by ENLOC, the results must be grouped in a folder.
`collapse_dapg.sh` does that.
`check_log_dap_eqtl.sh` will inspect the logs and expected results for job completion. You can enable resubmission if needs be.

`pack_dapg_*qtl.yaml` (one ofr eqtl and another for sqtl)  will build a tar.gz archive of each tissue folder in case a smarter storage is needed.
`parse_dapg_*qtl.yaml` will read the miscellaneous DAPG outputs and build tidy data tables.
 
 Since enloc only supports alphanumeric names for QTL, you can rename DAPG sQTL results using `rename_dap_sqtl.yaml`, which additionally outputs a table mapping from old to new names.
 
 `parse_wrapup_dapg_*qtl.sh` will read xQTL log outputs and build a table of job measured resources (i.e. how much memory each job took)
 `build_eqtl_spec.py` will process the job resource statistics and build an optimized specification of resource declaration per each job (this will write `dap_job_spec_eqtl.yaml` mentioned earlier)
  
 `upload_dapg_sqtl.sh` will upload to google cloud storage the packed results

`