library(readr)
library(dplyr)

args = commandArgs(trailingOnly=TRUE)
I <- args[1]
O <- args[2]

d <- read_tsv(I)
d <- d %>% mutate(sample_size=as.integer(sample_size), n_cases=as.integer(n_cases))
write.table(d, O, sep="\t", row.names = FALSE, quote=FALSE)
