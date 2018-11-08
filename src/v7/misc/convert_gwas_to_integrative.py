#!/usr/bin/env python
__author__ = "alvaro barbeira"

import pandas
import numpy
import gzip

LDB = "/home/numa/Documents/Projects/data/3rd/ldetect-data/EUR/fourier_ls-all.bed"
GWAS = "/home/numa/Documents/Projects/data/GWAS/DIAGRAM/diagram_scott/DIAGRAM_SCOTT.txt.gz"
O = "/home/numa/Documents/Projects/data/GWAS/DIAGRAM/diagram_scott/DIAGRAM_SCOTT_e.txt.gz"

print("Load ld blocks")
ld = pandas.read_table(LDB, sep="\s+")
ld = ld.assign(chr = ld.chr.str.split("chr").str.get(1).astype(numpy.int))

print("Load GWAS", sep="\s+")
gwas = pandas.read_table(GWAS)
print("Processing GWAS", sep="\s+")
gwas = gwas.assign(z = gwas.Effect/gwas.StdErr)
gwas.sort_values(by=["chromosome", "position"], inplace=True)
total=gwas.shape[0]
#gwas = gwas.sort_values(by=["chromosome", "position"])
#gwas = gwas.assign(chromosome = "chr"+gwas.chromosome.map(str))

def add_ld(gwas, ld):
    r = []
    for i,t in enumerate(gwas.itertuples()):
        if i%10000 == 0: print("{} complete".format(i*100/total))
        ld_ = ld.loc[(ld.chr == t.chromosome) & (ld.start <= t.position) & (t.position <= ld.stop)]
        if ld_.shape[0] == 0:
            print("No region for {}".format(t.rsid))
        region = ld_.index.values[0]+1
        r.append((t.rsid, "Loc{}".format(region), region))
    r = pandas.DataFrame(r, columns=["rsid", "region", "_region"])
    gwas = gwas.merge(r, on="rsid")
    gwas = gwas.sort_values(by="_region")
    return gwas

def _to_line(comps): return "{}\n".format("\t".join(comps)).encode()

def save_gwas_with_ld_block(gwas, ld, output):
    with gzip.open(output, "w") as f:
        for i,t in enumerate(gwas.itertuples()):
            if i%10000 == 0: print("{} complete".format(i*100/total))
            ld_ = ld.loc[(ld.chr == t.chromosome) & (ld.start <= t.position) & (t.position <= ld.stop)]
            if ld_.shape[0] == 0:
                print("No region for {}".format(t.rsid))
            region = ld_.index.values[0]+1
            f.write(_to_line((t.rsid, "Loc{}".format(region), "{0:.2f}".format(t.z))))


#print("Get gwas regions")
#gwas = add_ld(gwas, ld)
#print("Saving")
#gwas = gwas[["rsid", "region", "z"]]
#gwas.to_csv(O, index=False, header=False, sep="\t")

print("Converting GWAS")
save_gwas_with_ld_block(gwas, ld, O)
print("Ran")
