library(dplyr)

d <- read.delim("dap_ms_wrapup.txt") %>% arrange(chromosome, sub_job)

r <- d %>% group_by(chromosome, sub_job) %>% top_n(1, wt=memory) %>% select(chromosome, sub_job, memory) %>%
    inner_join(d %>% group_by(chromosome, sub_job) %>% top_n(1, wt=walltime) %>% select(chromosome, sub_job, walltime), by=c("chromosome", "sub_job")) %>%
    data.frame %>%select(chromosome, sub_job, memory, walltime) %>%
    mutate(key = sprintf("%d_%d", chromosome, sub_job)) %>%
    data.frame %>% select(key, walltime, memory)

r <- r %>% mutate(memory = ifelse(memory < 1800, 2000,
                           ifelse(memory < 3800, 4000,
                           ifelse(memory < 7300, 8000, 16000)))) %>%
           mutate(walltime = ifelse(walltime < 12600, 14400, 172800)) %>%
          mutate(memory = sprintf("%dgb", memory/1000)) %>%
           mutate(walltime = sprintf("%3d:00:00", walltime/3600))
r %>% select(key, walltime, memory) %>% write.table("spec.txt", row.names=FALSE, sep="\t", quote=FALSE)


CPU_HOUR<-0.267 #8 cpus, 30gb

r <- d %>% select(key, walltime, memory)
r <- r %>% mutate(memory = ifelse(memory < 1800, 2000,
                           ifelse(memory < 3800, 4000,
                           ifelse(memory < 7000, 8000, 16000)))) %>%
           mutate(memory = memory/1000) %>% mutate(walltime = walltime/3600)

r_ <- r %>% mutate(consumption = ifelse(memory == 2, 1/8,
                                ifelse(memory == 4, 1/4, 1/3))) %>%
    mutate(cost = walltime*CPU_HOUR*consumption)
sum(r$cost) * 49
