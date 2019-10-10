###############################################################################
# Initial mashr models, from GTERx eQTL on all individuals for expression, "V0"
library(dplyr)
library(readr)
library(tidyr)

get_paths <- function(folder) {
    files <- list.files(folder)
    file.path(folder, files[grepl(".posterior.rds", files)])
}

save_data <- function(r, folder) {
    if (!file.exists(folder)) {
        dir.create(folder, showWarnings = FALSE, recursive=TRUE)
    }
    message("saving")
    for (tissue_ in unique(r$tissue)) {
        message(tissue_)
        t_ <- r %>% filter(tissue == tissue_) %>% select(gene_id, gene_name, variant, weight)
        t_ %>% write.table(file.path(folder, tissue_) %>% paste0(".txt"), sep="\t", row.names = FALSE, quote=FALSE)
    }
}

message("preparing")
tissues <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/tissues.txt" %>% scan( what=character())

message("expression")
(function(){
    gencode <- read_tsv("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_all.txt")
    gencode_ <- gencode %>% mutate(gene_=gsub("(.*)\\.(.*)", "\\1", gene_id)) %>% select(gene_, gene_id, gene_name) %>% unique

    files <- get_paths("/gpfs/data/im-lab/nas40t2/yanyul/GTExV8/mashr_output_eur/expression-fixed_fix_na")

    r <- list()
    for (i in 1:length(files)) {
        message(files[i])
        d <- files[i] %>% readRDS %>% .$PosteriorMean
        #WATCH OUT! we are keeping only autosomes
        d <- d[grepl("(.*)_(\\d+)_(\\d+)_(.*)_(.*)", row.names(d)),]
        names <- row.names(d)

        r[[i]] <- data.frame(stringsAsFactors=FALSE,
                gene_ = gsub("(.*)_(\\d+)_(\\d+)_(.*)_(.*)", "\\1", names),
                variant= gsub("(.*)_(\\d+)_(\\d+)_(.*)_(.*)", "chr\\2_\\3_\\4_\\5_b38", names)) %>%
            inner_join(gencode %>% mutate(gene_=gsub("(.*)\\.(.*)", "\\1", gene_id)) %>% select(gene_, gene_id, gene_name) %>% unique, by="gene_") %>%
            cbind(data.frame(d)) %>% select(-gene_) %>% gather("tissue", "weight", -gene_id, -gene_name, -variant) %>%
            mutate(tissue = gsub("[.]", "-", tissue))
    }
    r <- do.call(rbind, r)

    save_data(r, "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/mashr_weights_eur/expression")
})()

message("splicing")
(function(){
    files <- get_paths("//gpfs/data/im-lab/nas40t2/yanyul/GTExV8/mashr_output_eur/splicing_fix_na")

    r <- list()
    for (i in 1:length(files)) {
        message(files[i])
        d <- files[i] %>% readRDS %>% .$PosteriorMean
        #WATCH OUT! we are keeping only autosomes
        d <- d[grepl("(.*)_(\\d+)_(\\d+)_(.*)_(.*)", row.names(d)),]
        names <- row.names(d)

        r[[i]] <- data.frame(stringsAsFactors=FALSE,
                gene_id = gsub("(.*)_(\\d+)_(\\d+)_(.*)_(.*)", "\\1", names),
                variant= gsub("(.*)_(\\d+)_(\\d+)_(.*)_(.*)", "chr\\2_\\3_\\4_\\5_b38", names)) %>%
            mutate(gene_name=gene_id) %>%
            cbind(data.frame(d)) %>% gather("tissue", "weight", -gene_id, -gene_name, -variant) %>%
            mutate(tissue = gsub("[.]", "-", tissue))
    }
    r <- do.call(rbind, r)

    save_data(r, "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/mashr_weights_eur/splicing")
})()