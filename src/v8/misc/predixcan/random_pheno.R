library(tidyverse)

F="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/1000G/random_pheno"
dir.create(F, recursive=TRUE, showWarnings = FALSE)
hg37_ <- "/scratch/abarbeira3/test/vcfhg37_mashr/Whole_Blood__predict.txt" %>% read_tsv
p37_ <- hg37_ %>% select(FID, IID) %>% mutate(pheno = rnorm(n = 2504))
p37_ %>% write.table(file.path(F,"random_pheno_1000G_hg37.txt"), sep="\t", quote=FALSE, row.names=FALSE)


hg38_ <- "/scratch/abarbeira3/test/vcfhg38_mashr_b/Whole_Blood_predict.txt" %>% read_tsv
p38_ <- hg38_ %>% select(FID, IID) %>% mutate(pheno = rnorm(n = 2548))
p38_ <- p38_ %>%
    left_join(p37_ %>% select(IID, pheno_2=pheno), by="IID") %>%
    mutate(pheno = ifelse(is.na(pheno_2), pheno, pheno_2))

p38_ %>%  select(-pheno_2) %>% write.table(file.path(F,"random_pheno_1000G_hg38.txt"), sep="\t", quote=FALSE, row.names=FALSE)