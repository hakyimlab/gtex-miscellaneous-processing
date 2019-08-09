#/usr/bin/env python
import os
import gzip
import sys
import re

r = re.compile("(.*).allpairs.txt.gz")
F="/gpfs/data/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_all_associations"
O="/home/abarbeira3/nas40t2/abarbeira/projects/gtex_v8/data/genes_in_eqtl"

def _to_line(x):
    return "{}\t{}\n".format(x[0], x[1]).encode()

def _write(o, x):
   o.write(_to_line(x))

files = [x for x in sorted(os.listdir(F)) if r.search(x)]
found = set()
#from IPython import embed; embed(); exit()
if len(sys.argv) == 2:
    files = [files[int(sys.argv[1])-1]]
    mod="_{}".format(r.search(files[0]).groups()[0])
else:
    mod=""
path = os.path.join(O, "gene_table{}.txt.gz".format(mod))
with gzip.open(path, "w") as o:
    _write(o, ["gene_id", "tissue"])
    for file in files:
        name = r.search(file).groups()[0]
        print(file)
        with gzip.open(os.path.join(F,file)) as i:
            for l,line in enumerate(i):
                if l == 0: continue
                comps = line.decode().strip().split()
                if not comps[0] in found:
                    _write(o, [comps[0],name])
                    found.add(comps[0])

print("done")


