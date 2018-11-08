__author__ = "alvaro barbeira"

import re
import os
import pandas

r_ = re.compile("(.*)_chr([0-9]+)_sb([0-9]+)_reg0.1_ff0.01_by_region.txt.gz")
r2_ = re.compile("gwas_parsing_(.*)_chr([0-9]+)_sb([0-9]+)_by_region.sh")


def _r(path, r):
    files = os.listdir(path)
    results = []
    for f in files:
        s = r.search(f)
        results.append((s.group(1), s.group(2), s.group(3)))
    return  results

def _p(results):
    results = pandas.DataFrame(data=results,columns= ["trait", "chromosome", "sb"])
    results["k"] = results.chromosome + "_" + results.sb
    g = results[["trait", "k"]].groupby("trait").aggregate(["count"])
    g= g.reset_index(level="trait", col_level=1)
    g.columns = g.columns.droplevel()
    g = g.sort_values(by="count")
    return g

results = _r("results_summary_imputation", r_)
results = _p(results)

jobs = _r("old/jobs_summary_imputation/", r2_)
jobs = _p(jobs)
#from  import embed; embed()