library(dplyr)


trunc_mem <- function(m) {
    ifelse(m<3800, floor(m/500)*0.5,
    ifelse(m<7000, floor(m/1000), floor(m/2000)*2))
}

d <- "/scratch/abarbeira3/v8_process/susier/sqtl/susier_ms_sqtl_wrapup.txt" %>% read.delim() %>%
    arrange(chromosome, sub_job) %>% mutate(key = sprintf("%d_%d", chromosome, sub_job))

r <- d %>% mutate(memory = ifelse((memory == 16384 & v_memory > memory), v_memory, memory)) %>% select(key, walltime, memory)
r %>% filter(memory > 65536) %>% .$key %>% write("black_list.txt")

r <- r %>% filter(memory < 65536)

spec <- r %>% mutate(memory = ifelse(memory < 1800, 2000,
                           ifelse(memory < 3800, 4000,
                           ifelse(memory < 7000, 8000,
                            (floor(memory/2000)+1)*2000)))) %>%
    mutate(memory = sprintf("%dgb", memory/1000)) %>%
    mutate(walltime = "72:00:00")
write.table(spec, "spec_sqtl.txt", row.names=FALSE, sep="\t", quote=FALSE)
