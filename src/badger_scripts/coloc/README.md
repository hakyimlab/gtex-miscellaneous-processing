
`build_coloc_info_gwas.py` is a script that was used to parse prior probabilities as estimated from ENLOC, to build the list of tissue-trait specific priors that COLOc needs.

There are different yamls corresponding to different ways of running COLOC. In their names, observe th following:

* `bse` prefixes means that COLOC is run with effect sizes and standard errors from both GWAS and eQTL.
* `zbse` prefixes means that COLOC is run with effect sizes and standard errors from eQTL, and zscores from GWAS.
* `gp` and `eqtlp` mean that COLOC will be run using pvalues from GWAs or eQTl, respectively.
* `enloc_prior` prefixes means that ENLOC enrichment estimates will be used.
* `swapped` exhanges p1 and p2 (this was done to ascertain a possible issue with GTEx groups's enloc runs that had suspicious priors)
 