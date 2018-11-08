#!/usr/bin/env Rscript
library(argparse)
library(dplyr)
library(readr)
library(ggplot2)

logic_ <- function(folder) {
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
    r <- data.frame()
    for (i in 1:nrow(l)) {
        l_ <- l[i,]
        cat(l_$name, "\n")
        d1 <- suppressWarnings(read_tsv(l_$path.x, col_types=cols_only(panel_variant_id="c", chromosome="c", zscore="d")))
        d2 <- suppressWarnings(read_tsv(l_$path.y, col_types=cols_only(gtex_variant_id="c", chromosome="c", zscore="d"))) %>% rename(panel_variant_id = gtex_variant_id)
        p <- d1 %>% inner_join(d2, by="panel_variant_id") %>% mutate(g = sign(zscore.x) == sign(zscore.y))
        m_ <- p %>% .$g %>% mean(na.rm=TRUE)
        r <- rbind(r, data.frame(name=l_$name,good=m_, stringsAsFactors=FALSE))
        cat(m_,"\n")
    }
    write.table(r, output, quote=FALSE, row.names=FALSE, sep="\t")
}

parser <- ArgumentParser(description='Process some integers')
parser$add_argument('-input_folder_1')
parser$add_argument('-input_folder_2')
parser$add_argument('-output')
args <- parser$parse_args(commandArgs(trailingOnly = TRUE))
run(args$input_folder_1, args$input_folder_2, args$output)
