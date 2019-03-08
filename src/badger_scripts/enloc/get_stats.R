# Title     : TODO
# Objective : TODO
# Created by: numa
# Created on: 2/4/19

library(dplyr)
d <- read.delim("enloc_sqtl_wrapup.txt")
d %>% group_by(tissue) %>% top_n(wt=memory, n= 1) %>% ungroup %>% select(trait, tissue, walltime, memory) %>% write.table("enloc_sqtl_tissue_spec.txt", row.names=FALSE, quote=FALSE)