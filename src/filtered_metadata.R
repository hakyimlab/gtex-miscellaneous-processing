library(readr)
library(dplyr)

args = commandArgs(trailingOnly=TRUE)
I <- args[1]
O <- args[2]
A <- args[3]
F <- as.double(args[4])

metadatize_ <- function(d) {
    message("Building metadata")
    r_ <- "(.*)_([0-9]+)_([A-Z]+)_([A-Z]+)_b38"
    d %>% mutate(chromosome = gsub(r_, "\\1", variant)) %>%
        mutate(position = as.integer(gsub(r_, "\\2", variant))) %>%
        mutate(non_effect_allele = gsub(r_, "\\3", variant)) %>%
        mutate(effect_allele = gsub(r_, "\\4", variant)) %>%
        rename(id=variant)
}

order_ <- function(d) {
    d %>% mutate(chr = as.integer(gsub("chr","", chromosome))) %>%
        arrange(chr, position) %>%
        select(chromosome, position, id, allele_0, allele_1, allele_1_frequency, rsid)
}

message("loading input")
d <- read_tsv(I)
message("Loaded ", nrow(d), " entries")

d <- d %>% metadatize_()

message("Loading snp annotation")
a <- read_tsv(A, col_types=cols_only(variant_id="c", rs_id_dbSNP150_GRCh38p7="c")) %>% rename(variant_id=id,  rs_id_dbSNP150_GRCh38p7=rsid)
message("Loaded")
d <- d %>% inner_join(a, by="id")

d <- d %>% filter((F<frequency) & (frequency<(1-F)))
message("Kept ", nrow(d), " variants after MAF filter")

d <- d %>% group_by(chromosome, position) %>% top_n(n=1, wt=frequency)
message("Kept ", nrow(d), " variants after MAF selection")
d <- d %>% select(variant, chromosome, position, non_effect_allele, effect_allele, frequency)


d <- d %>% filter(grepl("chr(\\d+)$", chromosome))
message("Kept ", nrow(d), " variants after filtering to chromosomes 1-22")

message("Finalizing")
d <- d %>% order_()

#out_ <- gzfile(O, "w")
message("Writing")
write.table(d, file=O, quote=FALSE, sep="\t", row.names=FALSE)
message("gzipping")
system(paste0("gzip ",O))

