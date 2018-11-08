#!/usr/bin/env Rscript
library(argparse)
library(dplyr)
library(readr)

run <- function(input, output) {
    names <- list.files(input)
    names <- names[grepl(".txt.gz", names)]
    k <- data.frame()
    for (name in names) {
        cat("Loading ",name, "\n")
        d <- suppressWarnings(read_tsv(file.path(input, name), col_types=cols_only(chromosome="c", position="i", panel_variant_id="c")))
        cat("Processing...\n")
        k_ <- d %>% group_by(chromosome, position) %>% summarise(n = n()) %>% filter(n > 1)
        if (nrow(k_) > 0) {
            cat(nrow(k_)*100.0/nrow(d), " % Duplicates found\n")
            k <- rbind(k, d %>% inner_join(k_, by=c("chromosome", "position")) %>% mutate(name = name))
        }
    }
    write.table(k, output, row.names = FALSE, sep="\t", quote=FALSE)
}

parser <- ArgumentParser(description='Process some integers')
parser$add_argument('-input_folder')
parser$add_argument('-output')
args <- parser$parse_args(commandArgs(trailingOnly = TRUE))
run(args$input, args$output)
