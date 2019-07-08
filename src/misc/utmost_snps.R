library(dplyr)
library(readr)
library(RSQLite)

F <- "/scratch/abarbeira3/v8_process/kk/sample_data/weight_db_GTEx"
files <- list.files(F)
files <- files %>% .[grepl(".db", files)]
files <- file.path(F,files)

rsid <- c()
for (i in 1:length(files)) {
    cat(files[i], "\n")
    con <- dbConnect(SQLite(), files[i])
    rsid_ <- dbGetQuery(con, "select rsid from weights")
    dbDisconnect(con)
    rsid <- c(rsid, unlist(rsid_)) %>% unique
}

hapmap <- "/gpfs/data/im-lab/nas40t2/abarbeira/data/hapmapSnpsCEU_f.list.gz" %>% read_tsv
hmrsid <- hapmap$rsid

length(rsid[rsid %in% hmrsid])
rsid[!(rsid %in% hmrsid)] %>% head

gtex_v8 <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/varians.txt.gz" %>% read_tsv
length(rsid[rsid %in% gtex_v8$rsid])