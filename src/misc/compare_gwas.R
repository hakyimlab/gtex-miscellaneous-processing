#!/usr/bin/env Rscript
library(argparse)
library(dplyr)
library(readr)
library(ggplot2)

logic_ <- function(folder) {
    cat(folder, "\n")
    names <- sort(list.files(folder))
    names <- names[grepl(".txt.gz", names)]
    paths <- file.path(folder, names)
    names <- gsub(".txt.gz", "", names)
    data.frame(name=names, path=paths, stringsAsFactors=FALSE)
}

run <- function(input_1, input_2, output) {
    l1 <- logic_(input_1)
    l2 <- logic_(input_2)
    l <- l1 %>% inner_join(l2, by="name")
    dir.create(output, showWarnings = FALSE)
    for (i in 1:nrow(l)) {
        l_ <- l[i,]
        cat(l_$name, "\n")
        d1 <- suppressWarnings(read_tsv(l_$path.x, col_types=cols_only(panel_variant_id="c", chromosome="c", zscore="d"))) %>% filter(chromosome == "chr1")
        d2 <- suppressWarnings(read_tsv(l_$path.y, col_types=cols_only(gtex_variant_id="c", chromosome="c", zscore="d"))) %>% filter(chromosome == "chr1") %>% mutate(panel_variant_id = gtex_variant_id)
        p <- d1 %>% full_join(d2, by="panel_variant_id") %>% mutate(zscore.x = ifelse(is.na(zscore.x), 0, zscore.x), zscore.y = ifelse(is.na(zscore.y), 0, zscore.y)) %>%
            ggplot() + theme_bw() + geom_point(aes(x=zscore.x, y=zscore.y))
        png(paste0(file.path(output, l_$name), ".png"), 500, 500)
        print(p)
        dev.off()
    }
}

parser <- ArgumentParser(description='Process some integers')
parser$add_argument('-input_folder_1')
parser$add_argument('-input_folder_2')
parser$add_argument('-output')
args <- parser$parse_args(commandArgs(trailingOnly = TRUE))
run(args$input_folder_1, args$input_folder_2, args$output)
