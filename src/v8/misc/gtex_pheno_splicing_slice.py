#!/usr/bin/env python
import sys
import gzip
import re
import os
__author__ = "alvaro barbeira"

I = sys.argv[1]
O = sys.argv[2]

d_ = os.path.split(O)[0]
if not os.path.exists(d_):
    os.makedirs(d_)

def to_l(_l):
    _l = "\t".join(_l) + "\n"
    return _l.encode()

print("start")
with gzip.open(I) as i_:
    i_.readline()
    with gzip.open(O, "w") as o_:
        o_.write(to_l(["chr", "start", "position", "gene_id", "intron_id", "cluster_id"]))
        for i,l in enumerate(i_):
            comps = l.decode().strip().split()

            id_comps = comps[3].split()
            intron_id = "{}_{}_{}".format(id_comps[0].replace("chr",""), id_comps[1], id_comps[2])
            o_.write(to_l([comps[0], comps[1], comps[2], id_comps[4], intron_id, id_comps[3]]))
print("done")

