#/usr/bin/env python
__author__ = "alvaro barbeira"

import gtex_expression_to_pred

if __name__ == "__main__":
    IF = "/group/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_covariates"
    OF = "covariates"
    OP = "_Analysis.combined_covariates.txt"
    COVARIATE = "(.*).v8.covariates.txt$"
    SAMPLES = "/scratch/abarbeira3/test/eur_samples.txt"
    ROW_NAME="ID"
    NAME_INDEX=0
    gtex_expression_to_pred.run(SAMPLES, IF, COVARIATE,OF, OP, ROW_NAME, NAME_INDEX, gzipped=False)