#!/usr/bin/env Rscript
library(stringr)
library(readr)
library(ggplot2)
library(dplyr)

read_ <- function(path) {
    suppressMessages(read_tsv(path, col_types = cols_only(gtex_variant_id="c", chromosome="c", position="d", zscore="d"))) %>% mutate(position = as.integer(position))
}

get_file_logic_ <- function(folder) {
    REGEXP <- "(.*).txt.gz"

    files <- sort(list.files(folder))
    #files <- c("50_standing_height_imputed_ns_cr0.01.txt.gz")
    r <- data.frame()
    for (file in files) {
        if (grepl(REGEXP, file)) {
            trait <- str_match(file, REGEXP)[2]
        } else {
            next
        }
        r <- rbind(r, data.frame(trait=trait, path=file.path(folder, file) , stringsAsFactors=FALSE))
    }
    r
}

plot_ <- function(d1, d2) {
    d <- d1 %>% inner_join(d2, by=c("chromosome", "position", "gtex_variant_id"))
    ggplot(d) + theme_bw() +
        geom_point(aes(x=zscore.x, y=zscore.y), size=0.5) + geom_abline(slope=1, intercept=0, color="gray")
}

print_plot_ <- function(p, path, height, width) {
    png(path, width=width, height=height)
    print(p)
    dev.off()
}


compare_plot <- function(folder1, folder2, output_folder) {
    if (!dir.exists(output_folder)) {
        dir.create(output_folder, recursive=TRUE)
    }

    l1 <- get_file_logic_(folder1)
    l2 <- get_file_logic_(folder2)
    ml <- l1 %>% inner_join(l2, by="trait")
    for (i in 1:nrow(ml)) {
        message("Loading ", ml$trait[i])
        d1 <- ml$path.x[i] %>% read_
        d2 <- ml$path.y[i] %>% read_
        message("plotting...")
        p <- plot_(d1, d2)
        path <- paste0(file.path(output_folder, ml$trait[i]), ".png")
        message("saving...")
        print_plot_(p, path, 800, 800)
    }
}


F1 <- "/group/im-lab/nas40t2/Data/SummaryResults/formatted_gwas_hg38_1.0"
F2 <- "/group/im-lab/nas40t2/Data/SummaryResults/formatted_gwas_hg38_1.1"
OUTPUT <- "results"

compare_plot(F1, F2, OUTPUT)
