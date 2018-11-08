#!/usr/bin/env Rscript
library(dplyr)
library(readr)

whitelist_ <- function(path) {
    read_tsv(path) %>% mutate(GTEx_GWAS=ifelse(GTEx_GWAS == "yes", "Yes", GTEx_GWAS)) %>% filter(GTEx_GWAS == "Yes") %>% .$Tag
}

whitelist_("GWAS_ukbiobank_neale_lab_metadata_ukb_neale_2018_02_13.tsv") %>% write("gwas_ukbiobank_neale_lab_whitelist.txt", sep="\n")
whitelist_("GWAS_public_meta_analysis_metadata_2017_02_13.tsv") %>% write("gwas_public_meta_analysis_whitelist.txt", sep="\n")
