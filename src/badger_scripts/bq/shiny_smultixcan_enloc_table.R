suppressMessages(library(dplyr))
suppressMessages(library(readr))
suppressMessages(library(argparse))
suppressWarnings(library(data.table))
suppressMessages(source("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/analysis/_helpers.R", chdir=TRUE))

# if (FALSE) {
  parser <- ArgumentParser(description="compare measured expression to prediction")
  parser$add_argument("-sm")
  parser$add_argument("-e")
  parser$add_argument("-fe")
  parser$add_argument("-o")
  parser$add_argument("-k")
  args <- parser$parse_args()


if(file.exists(args$o)) {
  stop("Output already present")
}

message("Reading smultixcan")
sm <- args$sm %>% read_tsv %>% suppressMessages

if (length(args$k)>0 && nchar(args$k) > 0) {
  sm <- sm %>% mutate(key = args$k)
}


if (length(args$fe) > 0 && nchar(args$fe) >0) {
  message("Reading fastenloc")
  e <- args$fe %>% read_tsv(col_types=cols_only(gene_id="c", tissue="c", rcp="d")) %>% suppressMessages
  e_ <- e %>% group_by(gene_id) %>% arrange(-rcp) %>% slice(1) %>% ungroup %>%
    rename(gene=gene_id)
} else if (length(args$e) > 0 && nchar(args$e) >0 && file.exists(args$e)) {
  message("Reading enloc")
  e <- args$e %>% read_tsv(col_types=cols_only(molecular_qtl_trait="c", tissue="c", locus_rcp="d")) %>% suppressMessages %>%
    rename(gene_id=molecular_qtl_trait, rcp=locus_rcp)
  e_ <- e %>% group_by(gene_id) %>% arrange(-rcp) %>% slice(1) %>% ungroup %>%
    rename(gene=gene_id)
} else {
  message("no colocalization to read")
  e_ <- data.frame(gene=character(), tissue=character(), rcp=numeric())
}

message("processing")

d <- sm %>% left_join(e_, by="gene") %>% select(-tissue)

cols_ <- c("gene", "gene_name", "pvalue", "n", "n_indep", "p_i_best", "t_i_best", "p_i_worst", "t_i_worst", "status", "phenotype", "rcp")
if (length(args$k)>0 && nchar(args$k) > 0) {
  cols_ <- c(cols_, "key")
}

d %>% select_( .dots=cols_) %>%
  write.table(args$o, sep="\t", row.names = FALSE, quote=FALSE)
message("End")