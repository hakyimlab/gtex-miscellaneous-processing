library(tidyverse)

message("read old")
o_ <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/predixcan_geuvadis_hg38_v1/mashr/Whole_Blood_predicted_expression.txt" %>% read_tsv
message("read new")
n_ <- "/scratch/abarbeira3/kk/predict_kk.txt" %>% read_tsv

go_ <- o_ %>% select(-FID, -IID) %>% colnames
gn_ <- n_ %>% select(-FID, -IID) %>% colnames

missing <- go_[!(go_ %in% gn_)]
shared <- go_[(go_ %in% gn_)]

d <- list()
for (i in 1:length(shared)) {
    gene <- shared[i]
    d[[i]] <- data.frame(gene=gene, diff=sum(o_[gene] - n_[gene]))
}
d <- do.call(rbind, d)

o_ %>% select(FID, IID) %>% mutate(pheno = rnorm(n = 341)) %>% write.table("random_pheno.txt", sep="\t", quote=FALSE, row.names=FALSE)
