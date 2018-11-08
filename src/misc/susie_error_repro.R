library(dplyr)
library(readr)
library(susieR)

#dataframe with some entries from eQTL
d <- read_tsv("b_d.txt.gz")

#covariance matrix for those variants
m <- scan("b_m.txt.gz") %>% matrix(byrow=1010, nrow=1010)

res <- susie_bhat(d$slope, d$slope_se, m, n=175)

