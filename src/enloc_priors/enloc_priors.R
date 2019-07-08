#!/usr/bin/Rscript

args <- commandArgs(TRUE);
PPATH <- args[1]
ABBR <- args[2]
TISSUE <- args[3]
EST <- args[4] # e.g. ADHD.enrich.est
QTLPIP <- args[5]
TRAIT <- args[6]

## read enloc enrichment estimates
est=read.table(EST, head=F, as.is=T)
a0=est$V1[1] # estimate of the intercept term
a1=est$V1[2] # enrichment estimate

## read mean of SNP-level eqtl posteriors
pip=read.table(QTLPIP, head=F, as.is=T)
prd1=pip$V1

## calculate coloc p1,p2,p12 priors
p1=(exp(a0)/(1 + exp(a0))) * (1 - prd1)
p2=1/(1 + exp(a0 + a1)) * prd1
p12=exp(a0 + a1)/(1 + exp(a0 + a1)) * prd1

message("Using p1: ", p1)
message("Using p2: ", p2)
message("Using p12: ", p12)

dat=data.frame(trait=TRAIT,tissue=TISSUE, p1=p1, p2=p2, p12=p12, new_abbreviation=ABBR,pm1=p1+p12, pm2=p2+p12)

write.table(dat, file=paste0(PPATH,"/",ABBR,"_",TISSUE,"_coloc_prior_est_by_enloc.txt"), sep='\t', quote=F, col.names=F, row.names=F)

q(save="no")