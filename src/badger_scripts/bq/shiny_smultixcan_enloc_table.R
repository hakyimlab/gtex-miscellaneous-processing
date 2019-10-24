suppressMessages(library(dplyr))
suppressMessages(library(readr))
suppressMessages(library(argparse))
suppressWarnings(library(data.table))
suppressMessages(source("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/analysis/_helpers.R", chdir=TRUE))

# if (FALSE) {
  parser <- ArgumentParser(description="compare measured expression to prediction")
  parser$add_argument("-sm")
  parser$add_argument("-e")
  parser$add_argument("-o")
  args <- parser$parse_args()


if(file.exists(args$o)) {
  stop("Output already present")
}

message("Reading smultixcan")
sm <- args$sm %>% read_tsv %>% suppressMessages
message("Reading enloc")
e <- args$e %>% read_tsv(col_types=cols_only(gene_id="c", tissue="c", rcp="d")) %>% suppressMessages

message("processing")
e_ <- e %>% group_by(gene_id) %>% arrange(-rcp) %>% slice(1) %>% ungroup %>%
  rename(gene=gene_id)

d <- sm %>% left_join(e_, by="gene") %>%
    mutate(rcp=ifelse(is.na(rcp), 0, rcp)) %>% select(-tissue)

d %>% select(gene, gene_name, pvalue, n, n_indep, p_i_best, t_i_best, p_i_worst, t_i_worst,	status,	phenotype, rcp) %>%
  write.table(args$o, sep="\t", row.names = FALSE, quote=FALSE)
message("End")