import os
import gzip
import shutil

gtex_variants="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/PredictDB_Pipeline_GTEx_v8/prepare_data/genotype/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz"
I="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/ctimp_chr1_as_defect"
O="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/ctimp_chr1_as"

print("getting rsid to gtex id mapping")
k={}
with gzip.open(gtex_variants) as variants:
    for i,line in enumerate(variants):
        if i ==0: continue
        comps = line.decode().strip().split()
        k[comps[6]] = comps[2]

if not os.path.exists(O):
    os.makedirs(O)

files = sorted([x for x in os.listdir(I)])
covs = [x for x in files if "gz" in x]


for cov in covs:
    print(cov)
    i = os.path.join(I, cov)
    o = os.path.join(O, cov)
    with gzip.open(i) as ic:
        header = ic.readline()
        with gzip.open(o, "w") as oc:
            oc.write(header)
            for line in ic:
                comps = line.decode().strip().split()
                if comps[1] in k:
                    comps[1] = k[comps[1]]
                if comps[2] in k:
                    comps[2] = k[comps[2]]
                l = "{} {} {} {}\n".format(*comps).encode()
                oc.write(l)

dbs = [x for x in files if "db" in x]
for db in dbs:
    print(db)
    i = os.path.join(I, db)
    o = os.path.join(O, db)
    shutil.copy(i, o)
