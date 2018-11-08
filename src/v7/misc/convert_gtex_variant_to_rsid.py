#!/usr/bin/env python
__author__ = "alvaro barbeira"

import re
import os
import gzip

def load_key_map(path):
    km = {}
    with gzip.open(path) as file:
        for i,line in enumerate(file):
            comps = line.decode().strip().split()
            value = comps[6]
            if value == ".": continue
            key = comps[2]
            km[key] = value
    return km

r = re.compile(r"(chr([\d]+)_([\d]+)_([GCTA]+)_([GCTA]+)_b38)")
def transform(input_path, output_path, d):
    with open(input_path) as input_file:
        with open(output_path, "w") as output_file:
            for iline in input_file:
                keys = [x[0] for x in r.findall(iline)]
                if len(keys) == 0:
                    l = iline
                else:
                    l = r.sub(r"{\1}", iline)
                    _d = {k:(d[k] if k in d else k) for k in keys}
                    l = l.format(**_d)
                output_file.write(l)

def transform_folder(input_folder, output_folder, d):
    names = sorted(os.listdir(input_folder))
    input_files = [os.path.join(input_folder,x) for x in names]
    output_files = [os.path.join(output_folder,x) for x in names]
    for i in range(0, len(input_files)):
        input_file, output_file = input_files[i], output_files[i]
        transform(input_file, output_file, d)

I="/home/numa/Documents/Projects/data/xqwen/dap/Whole_Blood/fm_rst"
O="/home/numa/Documents/Projects/data/xqwen/dap/Whole_Blood/fm_rst_converted"
if not os.path.exists(O): os.makedirs(O)
#TODO: load keys from somewhere
print("load key map")
d = load_key_map("/home/numa/Documents/Projects/data/GTEx/v8/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz")
print("transform")
transform_folder(I,O, d)
