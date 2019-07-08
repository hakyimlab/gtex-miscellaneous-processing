library(dplyr)
library(readr)
library(argparse)

# parser <- ArgumentParser(description="compare measured expression to prediction")
# parser$add_argument("-expression")
# parser$add_argument("-splicing")
# parser$add_argument("-intron_mapping")
# parser$add_argument("-sub_batches")
# parser$add_argument("-sub_batch")
# parser$add_argument("-output")
# args <- parser$parse_args()
args <- list()
args$splicing <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/predixcan/en_splicing/Whole_Blood_predicted_expression.txt"
args$expression <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/predixcan/en/Whole_Blood_predicted_expression.txt"
args$intron_mapping <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/intron_gene_map/intron_gene_map_Whole_Blood.txt.gz"
args$output <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/expression_vs_splicing/wb.txt"
args$sub_batches <- NULL
args$sub_batch <- NULL

# args$sub_batches <- 20
# args$sub_batch <- 3


splicing <- args$splicing %>% read_tsv
expression <- args$expression %>% read_tsv
intron_mapping <- args$intron_mapping %>% read_tsv

genes <- expression %>% select(-FID, -IID) %>% colnames
introns <- splicing %>% select(-FID, -IID) %>% colnames

intron_mapping <- intron_mapping %>% filter(intron_id %in% introns)


split_df <- function(df, sub_job, sub_jobs) {
  cat("Splitting ", nrow(df), " into ", sub_job,"/", sub_jobs, "\n")
  l_ <- nrow(df)
  k_ <- ceiling(l_/sub_jobs)
  indexes_ <- seq(1, l_)
  splits_ <- split(indexes_, rep(1:sub_jobs, each=k_+1)[1:l_])
  split_ <- splits_[[sub_job]]
  df <- df[split_,]
  cat("Kept ", split_[1], "-", split_[length(split_)], "\n")
  df
}

if (!is.null(args$sub_sub_batches) && !is.null(args$sub_batch)) {
  message("splittiing")
  split_ <- split_df(intron_mapping, as.integer(args$sub_batch), as.integer(args$sub_batches))
} else {
  split_ <- intron_mapping
}


message("Starting analysis")
r <- list()
for (i in 1:nrow(split_)) {
    message(i, ":", split_$intron_id[i], ":",split_$gene_id[i])
    s_ <- splicing[[split_$intron_id[i]]]
    e_ <- expression[[split_$gene_id[i]]]
    if (!is.null(e_) && !all(s_ == 0) && !all(e_ == 0)) {
      l_ <- lm(e_ ~s_)
      spearman <- cor.test(e_, s_, method="spearman")
      pearson <- cor.test(e_, s_)
      r[[i]] <- data.frame(
             intron=split_$intron_id[i],
             gene=split_$gene_id[i],
             pvalue=pf(summary(l_)$fstatistic[1], summary(l_)$fstatistic[2], summary(l_)$fstatistic[3],lower.tail=F),
             r = pearson$estimate,
             r_pvalue = pearson$p.value,
             spearman_r = spearman$estimate,
             spearman_pvalue = spearman$p.value,
             t = summary(l_)$coefficients[6],
             stringsAsFactors = FALSE)

    } else {
            r[[i]] <- data.frame(
             intron=split_$intron_id[i],
             gene=split_$gene_id[i],
             pvalue=NA,
             r = NA,
             r_pvalue = NA,
             spearman_r = NA,
             spearman_pvalue = NA,
             t = NA,
             stringsAsFactors = FALSE)
    }
}
r <- do.call(rbind, r)
write.table(r, args$output, sep="\t", row.names = FALSE, quote=FALSE)
message("Finished")