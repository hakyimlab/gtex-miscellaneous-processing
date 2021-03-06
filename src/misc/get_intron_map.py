#!/usr/bin/env python
__author__ = "alvaro barbeira"
import os
import gzip
import sys
I="/gpfs/data/gtex-group/v8/63881/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/sqtl/GTEx_Analysis_v8_sQTL_all_associations"
O="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/intron_gene_map/intron_gene_map{}.txt.gz"
names = sorted([x for x in os.listdir(I) if "allpairs" in x])

O_ = os.path.split(O)[0]
if not os.path.exists(O_):
    os.makedirs(O_)

def intron_name_from_line(line):
    c = line.decode().split()[0]
    comps = c.split(":")
    name = "intron_{}_{}_{}".format(comps[0].replace("chr",""), comps[1], comps[2])
    key = "{}_{}".format(name, comps[4])
    return key, comps, name

def gtex_name(line):
    c = line.decode().split()[0]
    comps = c.split(":")
    return c, comps, c

_name = intron_name_from_line

########################################################################################################################
if len(sys.argv) > 1:
    names=[names[int(sys.argv[1]) -1 ]]
    _p = names[0].split(".v8")[0]
    O = O.format("_"+_p)
else:
    O = O.format("")
paths = map(lambda x: os.path.join(I,x), names)

mapped=set()


print("starting")
with gzip.open(O, "w") as o_:
    o_.write("intron_id\tgene_id\tchromosome\tstart\tend\n".encode())
    for p in paths:
        print(p)
        with gzip.open(p) as f:
            for i,line in enumerate(f):
                if i==0: continue
                key, comps, name = _name(line)
                if key in mapped:
                    continue

                mapped.add(key)
                print("{}:{}".format(len(mapped), name))

                l = "{}\t{}\t{}\t{}\t{}\n".format(name, comps[4], comps[0].replace("chr",""), comps[1], comps[2]).encode()
                o_.write(l)
print("done")
