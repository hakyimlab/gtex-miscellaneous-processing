# Title     : TODO
# Objective : TODO
# Created by: numa
# Created on: 2/14/19
library(dplyr)
library(readr)

d <- "enloc_sqtl_wrapup_1.txt" %>% read_tsv %>%
    rbind("enloc_sqtl_wrapup_2.txt" %>% read_tsv) %>%
    rbind("enloc_sqtl_wrapup_3.txt" %>% read_tsv) %>%
    rbind("enloc_sqtl_wrapup_4.txt" %>% read_tsv) %>%
    rbind("enloc_sqtl_wrapup_5.txt" %>% read_tsv) %>%
    rbind("enloc_sqtl_wrapup_6.txt" %>% read_tsv)

walltime <- d %>% select(tissue, walltime) %>%
    group_by(tissue) %>% arrange(-walltime) %>% slice(1) %>% ungroup

memory <- d %>% select(tissue, memory) %>%
    group_by(tissue) %>% arrange(-memory) %>% slice(1) %>% ungroup

vmem <- d %>% select(tissue, v_memory) %>%
    group_by(tissue) %>% arrange(-v_memory) %>% slice(1) %>% ungroup

walltime %>% inner_join(memory, by="tissue") %>% select(tissue, memory, walltime) %>%
    write.table("/scratch/abarbeira3/v8_process/enloc/sqtl/enloc_sqtl_tissue_spec.txt", quote=FALSE, row.names=FALSE, sep="\t")