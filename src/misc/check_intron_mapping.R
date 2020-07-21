library(tidyverse)

a__ <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/intron_gene_map/intron_gene_map_Whole_Blood.txt.gz"
a_ <- a__ %>% read_tsv()

b__ <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/intron_id_mapping/Whole_Blood.leafcutter.phenotype_groups.txt.gz"
b_ <- b__ %>% read_tsv()

m_ <- a_ %>% inner_join(b_, by=c("gene_id", "intron_id"))