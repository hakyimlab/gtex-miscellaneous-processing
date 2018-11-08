#/usr/bin/env python
import os
import gzip
F="/group/gtex-group/v8/59349/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/eqtl/GTEx_Analysis_v8_eQTL/"

def _to_line(x):
    return "{}\t{}\n".format(x[0], x[1]).encode()

def _write(o, x):
   o.write(_to_line(x))

files = [x for x in os.listdir(F) if "egenes" in x]
found = set()
with gzip.open("gene_table.txt.gz", "w") as o:
    _write(o, ["gene_id", "gene_name"])
    for file in files:
        print(file)
        with gzip.open(os.path.join(F,file)) as i:
            for l,line in enumerate(i):
                if l == 0: continue
                comps = line.decode().strip().split()
                if not comps[0] in found:
                    _write(o, comps[0:2])
                    found.add(comps[0])

print("done")


