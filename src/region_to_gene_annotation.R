library(dplyr)
library(readr)

I <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/eur_ld.bed.gz"
O <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/eur_ld.annot.gz"
d <- read_tsv(I) %>%
    mutate(gene_id = sprintf("region_%s_%d_%d", chr, start, stop)) %>%
    mutate(feature_type = "region", gene_name = gene_id, gene_type= "region") %>%
    rename(chromosome = chr, start_location=start, end_location=stop) %>%
    select(chromosome, start_location, end_location, feature_type, gene_id, gene_name, gene_type)

gz1 <- gzfile(O, "w")
write.table(d, gz1, row.names = FALSE, sep="\t", quote=FALSE)
close(gz1)


d <- read_tsv(I) %>% filter(!is.na(chr), !is.na(start), !is.na(stop)) %>%
    mutate(region = sprintf("region_%s_%d_%d", chr, start, stop)) %>%
    rename(chromosome = chr, start_location=start, end_location=stop) %>%
    select(region, chromosome, start_location, end_location)


write.table(d, "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/eur_ld.txt", row.names = FALSE, sep="\t", quote=FALSE)
