suppressMessages(library(dplyr))
suppressMessages(library(readr))
suppressMessages(library(argparse))
suppressWarnings(library(data.table))
suppressMessages(source("/gpfs/data/im-lab/nas40t2/abarbeira/projects/prediction_models/code/_helpers.R", chdir=TRUE))

# if (FALSE) {
#  parser <- ArgumentParser(description="compare measured expression to prediction")
#  parser$add_argument("-observed")
#  parser$add_argument("-predicted")
#  parser$add_argument("-tissue")
#  parser$add_argument("-method")
#  parser$add_argument("-key")
#  parser$add_argument("-output")
#  args <- parser$parse_args()
# } else {
   args <- list(key="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/predixcan_geuvadis_hg38/expression_prediction_key.txt.gz",
                observed="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/expression.txt.gz",
                predicted="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/predixcan_geuvadis_hg38/ctimp/Whole_Blood_predicted_expression.txt",
                tissue="Whole_Blood",
                method="v8_ctimp",
                output="Whole_Blood_comparison.txt")
# }

if(file.exists(args$output)) {
  stop("Output already present")
}

read_expression_ <- function(path, key) {
  e <- r_tsv_(path)
  g_ <- e$id
  ind_ <- colnames(e %>% select(-id))
  d_ <- e %>% select(-id) %>% transpose
  colnames(d_) <- g_
  g_ <- g_[g_ %in% key$expression_id]
  d_ <- d_  %>% select_(.dots=g_)
  d_$id <- ind_
  d_ %>% select_(.dots=c("id",g_))
}

read_prediction_ <- function(prediction, key) {
  r_tsv_(prediction) %>% select(-FID) %>% rename(id=IID) %>% select_(.dots=c("id", key$gene_id))
}

message("Reading key")
key <- r_tsv_(args$key, col_types=cols_only(gene_id="c", tissue="c", method="c", expression_id="c")) %>% filter(tissue == args$tissue, method == args$method ) %>% unique
message("Reading observed")
observed <- read_expression_(args$observed, key)
message("Reading predicted")
predicted <- read_prediction_(args$predicted, key)

message("Processing")
r <- list()
for (i in 1:nrow(key)) {
  message(i, "/", nrow(key))
  e_ <- key$expression_id[i]
  g_ <- key$gene_id[i]
  d_ <- cbind( observed %>% select_(.dots=e_) %>% rename_(.dots=c("x"=e_)),
              predicted %>% select_(.dots=g_) %>% rename_(.dots=c("y"=g_)))
  m_ <- lm(y ~ x, data=d_)
  spearman <- cor.test(d_$x, d_$y, method="spearman")
  r[[i]] <- data.frame(e=e_, p=g_,
             pvalue=pf(summary(m_)$fstatistic[1], summary(m_)$fstatistic[2], summary(m_)$fstatistic[3],lower.tail=F),
             r2 = summary(m_)$r.squared,
             spearman_r2 = spearman$estimate ** 2,
             spearman_pvalue = spearman$p.value,
             t = summary(m_)$coefficients[6],
             tissue = args$tissue,
             method = args$method,
             stringsAsFactors = FALSE)
}
r <- do.call(rbind, r)
save_delim(r, args$output)
message("Finished")
