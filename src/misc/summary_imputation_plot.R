#!/usr/bin/env Rscript
library(stringr)
library(readr)
library(ggplot2)
library(dplyr)

read_ <- function(path) {
    suppressMessages(read_tsv(path, col_types = cols_only(chromosome="c", position="d", zscore="d", imputation_status="c")))
}

read_2_ <- function(path, chr_="chr1") {

    cols <- cols_only(chromosome="c", position="d", effect_allele="c", non_effect_allele="c", zscore="d", imputation_status="c")
    #cols <- cols_only(chromosome="c", position="d", effect_allele="c", non_effect_allele="c", gtex_variant_id="c", zscore="d", imputation_status="c")
    d <- suppressMessages(read_tsv(path, col_types = cols))
    if (!is.null(chr_)) {
        d <- d %>% filter(chromosome == chr_)
    }
    d <- d %>% mutate(e = ifelse(effect_allele < non_effect_allele,
            paste0(effect_allele, "_", non_effect_allele),
            paste0(non_effect_allele, "_", effect_allele))) # %>%
        #mutate(key=paste(chromosome, position, e, collapse = "_"))
    d <- d %>% select(-effect_allele, -non_effect_allele)
    d
}

get_sfile_logic <- function(folder) {
    CR_REGEXP <- "_cr_(\\d+\\.*\\d*).txt.gz"
    REG_REGEXP <- "_reg_(\\d+\\.*\\d*).txt.gz"

    files <- list.files(folder)
    #files <- c("50_standing_height_imputed_ns_cr0.01.txt.gz")
    r <- data.frame()
    for (file in files) {
        if (grepl(CR_REGEXP, file)) {
            param <- paste0("cr_",str_match(file, CR_REGEXP)[2])
            trait <- str_replace(file, CR_REGEXP, "")
        } else if (grepl(REG_REGEXP, file)){
            param <- paste0("reg_", str_match(file, REG_REGEXP)[2])
            trait <- str_replace(file, REG_REGEXP, "")
        } else {
            param <- NA
            trait <- gsub(".txt.gz", "", file)
        }
        r <- rbind(r, data.frame(trait=trait, param=param, path=file.path(folder, file) , stringsAsFactors=FALSE))
    }
    r
}

prepare_ <- function(d) {
    o_ <- d %>% filter(imputation_status == "original")
    i_ <- d %>% filter(imputation_status == "imputed")
    o_ %>% inner_join(i_, by=c("chromosome", "position"))
}

prepare_2_ <- function(d) {
    o_ <- d %>% filter(imputation_status == "original")
    i_ <- d %>% filter(imputation_status == "imputed")
    o_ %>% inner_join(i_, by=c("chromosome", "position", "e"))
}

plot_imp <- function(m) {
    #model <- lm(zscore.y ~ zscore.x, m)
    #coef <- summary(model)$coefficients[2,1]
    #annot <- data.frame(x=-20,y=20, text=paste0("slope: ",coef))

    ggplot(m) + geom_point(aes(x=zscore.x, y=zscore.y), size=1) +
        geom_abline(slope=1, intercept=0, color="gray") +
        theme_bw() + xlab("original") + ylab("imputed")
}

plot_imp_density <- function(m, colorize = FALSE) {
    a_ <- if (colorize) {
        aes(x=zscore.x, y=zscore.y, color=chromosome)
    } else {
        aes(x=zscore.x, y=zscore.y)
    }
    ggplot(m) + #stat_density_2d(aes(x=zscore.x, y=zscore.y, fill=..level..), geom="polygon") +
        geom_point(a_, size=0.5, alpha= 0.5) +
        geom_density_2d(aes(x=zscore.x, y=zscore.y), size=2) +
        geom_abline(slope=1, intercept=0, color="gray") +
        theme_bw() + xlab("original") + ylab("imputed")
}


print_plot <- function(p, path, height, width) {
    png(path, width=width, height=height)
    print(p)
    dev.off()
}

process <- function(input_path, output_path) {
    if (!dir.exists(output_path)) {
        dir.create(output_path, recursive=TRUE)
    }
    message("Getting file logic")
    file_logic <- get_sfile_logic(input_path)

    for (i in 1:nrow(file_logic)) {
        f <- file_logic[i,]
        message("Processing: ", f$trait, "/", f$param)
        d <- read_(f$path)
        #d <- suppressMessages(read_tsv(f$path, col_types = cols_only(chromosome="c", position="d", zscore="d", imputation_status="c", gtex_variant_id="c")))
        m <- prepare_(d)
        message("Plotting")
        p_ <- plot_imp_density(m) #+ facet_wrap(~chromosome)
        op_ <- file.path(output_path, paste0(f$trait, f$param, ".png"))
        print_plot(p_, op_, 600, 600)
    }
}

process_2 <- function(input_path, output_path) {
    if (!dir.exists(output_path)) {
        dir.create(output_path, recursive=TRUE)
    }
    message("Getting file logic")
    file_logic <- get_sfile_logic(input_path)

    for (i in 1:nrow(file_logic)) {
        f <- file_logic[i,]
        message("Reading: ", f$trait, "/", f$param)
        d <- read_2_(f$path)
        message("Preparing")
        m <- prepare_2_(d)
        message("Plotting")
        p_ <- plot_imp_density(m) #+ facet_wrap(~chromosome)
        op_ <- file.path(output_path, paste0(f$trait, f$param, ".png"))
        print_plot(p_, op_, 600, 600)
    }
}

process_3 <- function(input_path, output_path) {
    if (!dir.exists(output_path)) {
        dir.create(output_path, recursive=TRUE)
    }
    message("Getting file logic")
    file_logic <- get_sfile_logic(input_path)

    for (i in 1:nrow(file_logic)) {
        f <- file_logic[i,]
        message("Processing: ", f$trait, "/", f$param)
        d <- read_(f$path)
        for (chromosome_ in paste0("chr", 1:22)) {
            d_ <- d %>% filter(chromosome == chromosome_)
            m <- prepare_(d_)
            p_ <- plot_imp_density(m)
            op_ <- file.path(output_path, paste0(f$trait, chromosome_, f$param, ".png"))
            print_plot(p_, op_, 600, 600)
        }
    }
}

process_data_ <- function(d, output) {
    m <- prepare_(d)
    p_ <- plot_imp_density(m)
    print_plot(p_, output, 600, 600)
}

process_file <- function(input, output) {
    d <- suppressMessages(read_tsv(input, col_types = cols_only(chromosome="c", position="d", zscore="d", imputation_status="c")))
    process_data_(d, output)
}

#INPUT_PATH <- "/home/numa/Documents/Projects/data/GWAS_IMPUTED"
# INPUT_PATH <- "/home/numa/Documents/Projects/data/GWAS_IMPUTED/processed_summary_imputation"
# OUTPUT_PATH <- "results/imputation_plots"
# process(INPUT_PATH, OUTPUT_PATH)

# INPUT_PATH <- "/scratch/abarbeira3/v8_process/summary_imputation_collect/keep_all/processed_summary_imputation/"
# OUTPUT_PATH <- "results_imputation_plots"
# process_2(INPUT_PATH, OUTPUT_PATH)

#d <- read_2_("/scratch/abarbeira3/v8_process/summary_imputation_collect/keep_all/processed_summary_imputation/imputed_1160_Sleep_duration.txt.gz")

d <- read_2_("/scratch/abarbeira3/v8_process/summary_imputation_postprocess/processed_summary_imputation/imputed_GIANT_WHR_Combined_EUR_all_2.txt.gz")
d %>% prepare_2_ %>% plot_imp_density %>% print_plot("kk.png", 1200, 1200)
d %>% filter(chromosome == "chr16") %>% prepare_2_ %>% plot_imp_density %>% print_plot("kk2.png", 1200, 1200)

#d <- read_2_("/scratch/abarbeira3/v8_process/summary_imputation_postprocess/processed_summary_imputation/imputed_GIANT_WHR_Combined_EUR_all_2.txt.gz", "chr16")
#d %>% prepare_2_ %>% plot_imp_density %>% print_plot("kk2.png", 1200, 1200)
    
#OUTPUT_PATH_2 <- "results/imputation_plots_by_chrom"
#process_2(INPUT_PATH, OUTPUT_PATH_2)

#d <- read_2_("/home/numa/Documents/Projects/data/GWAS_IMPUTED/processed_summary_imputation/imputed_50_Standing_height.txt.gz")
# d <- read_("/home/numa/Documents/Projects/data/GWAS_IMPUTED/processed_summary_imputation/imputed_50_Standing_height.txt.gz")
# d_ <- d #%>% filter(chromosome == "chr6")
# m <- prepare_2_(d_) #%>% filter((abs(zscore.x)>5))
# p_ <- plot_imp_density(m)
# print_plot(p_, "results/imputation_plots/UKB_height_test_2.png", 1200, 1200)


# d <- read_("/home/numa/Documents/Projects/data/GWAS_IMPUTED/50_standing_height_imputed_w1e5_reg_0.1.txt.gz")
# d_ <- d #%>% filter(chromosome == "chr6")
# m <- prepare_(d_) #%>% filter((abs(zscore.x)>5))
# p_ <- plot_imp_density(m)
# print_plot(p_, "results/imputation_plots/UKB_height_unormalised.png", 1200, 1200)

#d_r <- read_("/home/numa/Documents/Projects/data/GWAS_IMPUTED/50_standing_height_imputed_w1e5_reg_0.1.txt.gz")
#m_r <- prepare_(d_r) %>% mutate(type="raw") %>% filter(abs(zscore.x) < 6)
#rm(d_r)
#d_n <- read_("/home/numa/Documents/Projects/data/GWAS_IMPUTED/50_standing_height_imputed_nd_cr0.1.txt.gz")
#m_n <- prepare_(d_n) %>% mutate(type="normalised") %>% filter(abs(zscore.x) < 6)
#rm(d_n)
#m <- rbind(m_r, m_n)
#p_ <- plot_imp_density(m) + facet_wrap(~type)
#print_plot(p_, "results/imputation_plots/UKB_height_norm_vs_unnorm.png", 800, 1600)

