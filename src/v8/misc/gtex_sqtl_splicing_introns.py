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
saved=set()
with gzip.open(I) as i_:
    i_.readline()
    with gzip.open(O, "w") as o_:
        o_.write(to_l(["gene_id", "intron_id", "cluster_id", "chromosome", "start_location", "end_location"]))
        for i,l in enumerate(i_):
            comps = l.decode().strip().split()
            id_comps = comps[0].split(":")
            chr_=id_comps[0].replace("chr","")
            intron_id = "intron_{}_{}_{}".format(chr_, id_comps[1], id_comps[2])
            key="{}_{}_{}".format(id_comps[4], intron_id, id_comps[3])
            if key in saved:
                continue
            else:
                saved.add(key)
            o_.write(to_l([id_comps[4], intron_id, id_comps[3], id_comps[0], id_comps[1], id_comps[2]]))

print("done")

