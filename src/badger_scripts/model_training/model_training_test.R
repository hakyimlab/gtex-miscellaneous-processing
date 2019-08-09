library(readr)
source("/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/elastic_net.R")

x <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/data/sample_model_training/x.txt" %>% read_tsv
y <- "/gpfs/data/im-lab/nas40t2/abarbeira/projects/data/sample_model_training/y.txt" %>% read_tsv

x_ <-x
y_ <- y

observation_weights <- NULL
penalty_factor <- NULL

x <- matrixify_(x)
y <- as.double(unlist(data.frame(y)[1]))
    if (is.null(observation_weights)) {
        observation_weights = rep(1, nrow(x))
    }
    if (is.null(penalty_factor)) {
        penalty_factor = rep(1, ncol(x))
    }

n_train_test_folds <- 5
n_k_folds <- 10
alpha <- 0.5

n_samples <- length(y)

res <- train_elastic_net(y, x, n_train_test_folds, n_k_folds, alpha, observation_weights, penalty_factor)
