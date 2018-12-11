__author__ = "alvaro barbeira"
import os
import gzip
import re
r = re.compile(".v8.normalized_expression.bed.gz$")
O = "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/individuals"
if not os.path.exists(O):
    os.makedirs(O)
F = "/gpfs/data/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_expression_matrices"
names = [x for x in os.listdir(F) if r.search(x)]
paths = [os.path.join(F,x) for x in names]
names = [x.split(".v8.normalized_expression.bed.gz")[0] for x in names]

for i in range(0, len(names)):
    #os.remove(os.path.join(O,names[i]) + ".txt")
    with gzip.open(paths[i]) as _i:
        ids = _i.readline().decode().strip().split()[4:]
        with open(os.path.join(O,names[i]) + ".txt", "w") as _o:
            for id in ids:
                _o.write(id+ "\n")

