#!/usr/bin/env python
__author__ = "alvaro barbeira"

import re
import os
import gzip

r = re.compile(r"(chr([\d]+)_([\d]+)_([GCTA]+)_([GCTA]+)_b38)")

def _gather_file(file_path):
    s=set()
    with open(file_path) as file:
        for line in file:
            keys = {x[0] for x in r.findall(line)}
            s.update(keys)
    return s

def _gather_folder(folder):
    s=set()
    paths = [os.path.join(folder,x) for x in os.listdir(folder)]
    for p in paths:
        _s = _gather_file(p)
        s.update(_s)
    return s

def _to_line(comps): return "{}\n".format("\t".join(comps)).encode()

ids = _gather_folder("/home/heroico/Documents/Projects/data/xqwen/dapg")
with gzip.open("/home/heroico/Documents/Projects/data/xqwen/gtex_ids.txt.gz", "w") as f:
    f.write(_to_line(["id", "chromosome", "position", "ref", "eff"]))
    for id in ids:
        comps = id.split("_")
        f.write(_to_line([id, comps[0], comps[1], comps[2], comps[3]]))