library(dplyr)
library(readr)

d <- "/scratch/abarbeira3/v8_process/CTIMP/ctimp_eqtl_spec.txt" %>% read_tsv
o <- d %>% arrange(chromosome, sub_batch) %>% mutate(key = paste0(chromosome, "_", sub_batch)) %>% select(key, walltime, memory)
o <- o %>% mutate(memory = paste0(ceiling(memory/1000), "gb")) %>%
    mutate(walltime = walltime/3600) %>%
    mutate(walltime = ifelse(walltime < 3.6, 4, ceiling(walltime)+1)) %>%
    mutate(walltime = paste0(walltime, ":00:00"))

write.table(o, "/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/badger_scripts/model_training_ctimp/ctimp_eqtl_spec.txt", sep="\t", quote=FALSE, row.names=FALSE)