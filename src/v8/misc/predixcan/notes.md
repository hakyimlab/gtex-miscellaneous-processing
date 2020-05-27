
Old:
- PrediXcan doesn't handle palindromic
- only uses effect allele
- supports only one input genotype format
- supports only one output format
- only supports snv's
- assumes genotypes have the same variants than the model
- old predixcan needs to be run from the folder where the script lies (uses *wd* to look for './PrediXcanAssociation.R' )

New:
- Handles palindromic
- uses effect and reference alleles
- handles indels
- early skip of variants outside the model, biggest gain in BGEN that averts loading alltogether
- faster
- summary output
- supports old format, vcf (regular and Michigan imputation Server), bgen (phased and unphased)
- supports old output format and HDF5
- supports mapping of variants to models (i.e. convert from hg19 to gtex v8)

I tested that new code and old code yield the same results in GTEx v6 EN.
In GTEx v8, as there are palindromic variants in the EN models, there are irreconciliable differences
