
These runs depend on `enloc`'s code, available at [DAP](https://github.com/xqwen/integrative) repository, and precompiled torus and dap ([this repository](https://github.com/xqwen/dap))

It assumes DAP-G results (see `src/badger_scripts/dapg`), and GWAS summary statistics in a specific format (`src/badger_scripts/gwas-parsing/slice_gwas_by_region.yaml`)

* `enloc.jinja` is the template. It creates a configuration file with settings that nloc will use.
* `enloc_*qtl.yaml` are the general submission yamls for eqtl and sqtl.
* `enloc_*qtl_tissue_spec.yaml` are the resource definitions to make jobs slimmer, listing expected resource consumption per tissue.

`fix_gtex_gene_name*` are scripts to process GTEx groups' ENLOC runs using all individuals.

`parse_enloc_result*` are badger scripts that postprocess enloc rcp results into tidier formats.

`check_enloc_eqtl.sh` will check the logs and expected outputs for presence, to determine wether any job failed.
`parse_wrapup_enloc*` will parse the logs to get resource consumption per job.
`build_enloc*` will read the parsed wrapup and build job-specific resource requirements. These were used to build the per-tissue job specs mentioned earlier.

## Closing remarks

enloc's basic perl implementation is very rigid with the filenames.
Having underscores `_` anywhere in the filename breaks the file name parsing.
I had to convert sQTL dapg intron names from `intron_chr1_1000_1050.txt` to `intron1.txt`

There is a specific file describing the name change for each tissue. Thus the dapg results renaming, 
and the enloc results renaming.