library(dplyr)
library(readr)

FOLDER <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/intron_gene_map_gtex"
names <- list.files(FOLDER)
names <- names[grepl("intron_gene_map_",names)]
logic <- data.frame(name = names, stringsAsFactors=FALSE) %>%
    mutate(path = file.path(FOLDER, name)) %>%
    mutate(tissue = gsub("intron_gene_map_(.*).txt.gz", "\\1", name))

d <- data.frame()
for (i in 1:nrow(logic)) {
    cat(i, " ",  logic$tissue[i], "\n")
    d <- logic %>% .[i,] %>% .$path %>% read_tsv %>% mutate(tissue = logic$tissue[i]) %>% rbind(d)
}

d <- d %>% rename(chr=chromosome, start_location=start, end_location=end) %>%
    arrange(chr, start_location, end_location)

f <- gzfile(file.path(FOLDER,"intron_gene_map.txt.gz"),"w")
d %>% select(intron_id, gene_id, chr, start_location, end_location) %>% unique() %>%
    write.table(f, quote=FALSE, sep="\t", row.names=FALSE)
close(f)
f <- gzfile(file.path(FOLDER,"intron_gene_map_full.txt.gz"),"w")
d %>% write.table(f, quote=FALSE, sep="\t", row.names=FALSE)
close(f)