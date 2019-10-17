# Title     : TODO
# Objective : TODO
# Created by: numa
# Created on: 5/21/19
library(dplyr)
library(readr)

ids <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage/sample_ids.txt" %>% scan(character())
d <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/GD462.GeneQuantRPKM.50FN.samplename.resk10.txt.gz" %>% read_tsv

e <- d %>% rename(id=TargetID) %>% select_(.dots=c("id", ids))
gz1 <- gzfile("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/expression.txt.gz", "w")
e %>% write.table(gz1, sep="\t", row.names = FALSE, quote=FALSE)
close(gz1)