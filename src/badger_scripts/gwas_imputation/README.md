
`summary_imputation.yaml` is ther main imputation badger scripts. The others are experiments or tests. 
The imputation was performed with a Ridge-like (Tikhonov) regularization. Each job will impute in a specific trait, chromosome and list of regions. 
i.e. to better use paralelization, each trait-chromosome dataset was split in 10 sub-batches.

`postprocess_summary_imputation.yaml` picks up the outputs for each trait's imputation jobs, and compiles a final harmonized/imputed GWAS summary statistics results file.