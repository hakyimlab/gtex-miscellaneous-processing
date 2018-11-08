#!/usr/bin/env python
#run with
# module load gcc/6.2.0
# module load python/3.5.3
__author__ = "alvaro barbeira"

import pandas
import os

P="/scratch/abarbeira3/data/GWAS"

def get_count(folder):
    files = sorted(os.listdir(folder))
    r = []
    for i,file in enumerate(files):
        print(file)
        d = pandas.read_table(os.path.join(folder,file), usecols=["effect_allele", "non_effect_allele"])
        d["key"] = d.effect_allele + d.non_effect_allele
        count = d[d.key.isin({"AT", "TA", "CG", "GC"})].shape[0]
        percentage = count*100/d.shape[0]
        name = file.split(".txt.gz")[0]
        r.append((name, count, d.shape[0], percentage))

    return pandas.DataFrame(r, columns=["trait", "count", "total", "percentage"])

r = get_count(P)
r.to_csv("count.txt.gz", sep="\t", index=None, compression="gzip")
