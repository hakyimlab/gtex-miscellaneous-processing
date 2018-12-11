library(dplyr)


trunc_mem <- function(m) {
    ifelse(m<3800, floor(m/500)*0.5,
    ifelse(m<7000, floor(m/1000), floor(m/2000)*2))
}

d <- read.delim("susier_wb_wrapup.txt") %>% arrange(chromosome, sub_job) %>% mutate(key = sprintf("%d_%d", chromosome, sub_job))
r <- d %>% select(key, walltime, memory) %>% filter(memory > 500)
spec <- r %>% mutate(memory = ifelse(memory < 1800, 2000,
                           ifelse(memory < 3800, 4000,
                           ifelse(memory < 7000, 8000,
                            (floor(memory/2000)+1)*2000)))) %>%
    mutate(walltime = ifelse(walltime < 12600, 14400,
                    ifelse(walltime<79200, 86400, 576000))) %>%
    mutate(memory = sprintf("%dgb", memory/1000)) %>%
    mutate(walltime = sprintf("%d:00:00",walltime/3600))
write.table(spec, "spec.txt", row.names=FALSE, sep="\t", quote=FALSE)


r_ <- r %>% mutate(memory = memory/1000) %>%
    mutate(consumption = ifelse(memory <= 4, 1/8,
                                ifelse(memory == 8, 1/4,
                                ifelse(memory == 12, 1/3,
                                ifelse(memory == 16, 1/2,1))))) %>%
    mutate(cost = walltime/3600*CPU_HOUR*consumption)
sum(r_$cost) * 49