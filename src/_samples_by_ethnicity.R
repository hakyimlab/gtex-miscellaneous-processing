#!/usr/bin/env Rscript
library(readr)
library(dplyr)
library(tidyr)

#Modify these paths to whatever you want.
ind_ <- "/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/GTEx_ethnicity.txt"
flagged_ <- "/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=gtex-group/v8/57603/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_support_files/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_flagged_donors.txt"
eur_ <-  "/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/eur_samples.txt"
afr_ <-  "/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/afr_samples.txt"

ethnicity <- read_tsv(ind_) %>% rename(id = SAMPLE_ID)
flagged <- read_tsv(flagged_) %>% rename(id = Donor_ID)

ethnicity <- ethnicity %>%
    separate(id, sep="-", into=c("id1", "id2", "id3", "id4", "id5")) %>%
    mutate(short_id=paste(id1, id2, sep="-", collapse=NULL), id=paste(id1, id2, id3, id4, id5, sep="-", collapse=NULL)) %>%
    select(-id1, -id2, -id3, -id3, -id4, -id5)

#must match the ids in the vcf Header! thatś why we use the short id
eur <- ethnicity %>% filter(!(short_id %in% flagged$id), InferredRace == "EUR" )
write.table(eur %>% select(short_id), eur_, row.names=FALSE, col.names=FALSE, quote=FALSE)

afr <- ethnicity %>% filter(!(short_id %in% flagged$id), InferredRace == "AFR" )
write.table(afr %>% select(short_id), afr_, row.names=FALSE, col.names=FALSE, quote=FALSE)