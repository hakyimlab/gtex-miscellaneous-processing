###############################################################################
# Initial mashr models, from GTERx eQTL on all individuals for expression, "V0"

library(dplyr)
library(readr)
library(tidyr)
FOLDER <- "/gpfs/data/gtex-group/v8/independent_eQTL/MASH/DAPG_pip_gt_0.01-AllTissues"
files <- list.files(FOLDER)
files <- file.path(FOLDER, files[grepl(".posterior.rds", files)])


filter_ <- (function(){
    FOLDER <- "/gpfs/data/im-lab/nas40t2/rbonazzola/GTEx/v8/one_snp_models/data/Sets_of_independent_SNPs/DAPG"
    files <- list.files(FOLDER)
    filter_ <- list()
    for (i in 1:length(files))  {
        filter_[[i]] <- file.path(FOLDER, files[i]) %>% read_tsv(col_types=cols_only(gene_id="c")) %>% unique %>%
            mutate(tissue = gsub("DAPG_pip_gt_0.01-(.*)-filtered_variants.txt", "\\1", files[i]))
    }
    do.call(rbind,filter_)
})()

OUTPUT <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/mashr_weights"

message("loading")
tissues <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/tissues.txt" %>% scan( what=character())
gencode <- read_tsv("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_stranded_everything.txt")
gencode_ <- gencode %>% mutate(gene_=gsub("(.*)\\.(.*)", "\\1", gene_id)) %>% select(gene_, gene_id, gene_name) %>% unique

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
        mutate(tissue = gsub("[.]", "-", tissue)) %>% inner_join(filter_, by=c("gene_id", "tissue"))
}
r <- do.call(rbind, r)

message("saving")
for (tissue_ in unique(r$tissue)) {
    message(tissue_)
    t_ <- r %>% filter(tissue == tissue_) %>% select(gene_id, gene_name, variant, weight)
    t_ %>% write.table(file.path(OUTPUT, tissue_) %>% paste0(".txt"), sep="\t", row.names = FALSE, quote=FALSE)
}