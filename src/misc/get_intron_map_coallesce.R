library(dplyr)
library(readr)

FOLDER <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data"
names <- list.files(FOLDER)
names <- names[grepl("intron_gene_map_",names)]
logic <- data.frame(name = names, stringsAsFactors=FALSE) %>%
    mutate(path = file.path(FOLDER, name)) %>%
    mutate(tissue = gsub("intron_intron_gene_map_(.*).txt.gz", "\\1", name))

d <- data.frame()
for (i in 1:nrow(logic)) {
    cat(i, "\n")
    d <- logic %>% .[i,] %>% .$path %>% read_tsv %>% rbind(d)
}

d <- d %>% mutate(chr = as.integer(gsub("intron_(.*)_(.*)_(.*)", "\\1", intron_id)),
            start_location = as.integer(gsub("intron_(.*)_(.*)_(.*)", "\\2", intron_id)),
            end_location = as.integer(gsub("intron_(.*)_(.*)_(.*)", "\\3", intron_id))) %>%
    arrange(chr, start_location, end_location) %>% unique()

write.table(d, "intron_gene_map.txt.gz", quote=FALSE, sep="\t", row.names=FALSE)