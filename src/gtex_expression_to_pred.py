#!/usr/bin/env python
__author__ = "alvaro barbeira"

# module load gcc/6.2.0
# module load python/3.5.3

import re
import os
import gzip

def read_samples(path):
    s=[]
    with open(path) as f:
        for line in f:
            s.append(line.strip())
    return s

def to_line(comp_0, comps_e, sample_index):
    o = [comp_0] + [comps_e[_i] for _i in sample_index]
    return "{}\n".format("\t".join(o))

def _open(path, gzipped):
    _o = gzip.open if gzipped else open
    return _o(path)

def _iline(line, gzipped):
    return line.decode() if gzipped else line

def run(sample_path, input_folder, file_regexp, output_folder, output_postfix, row_name, name_index, gzipped=True):
    samples = read_samples(sample_path)
    _re = re.compile(file_regexp)
    files = [os.path.join(input_folder,x) for x in sorted(os.listdir(input_folder)) if _re.search(x)]
    if not os.path.exists(output_folder): os.makedirs(output_folder)
    for f in files:
        file_name = _re.search(os.path.split(f)[1]).group(1)
        print("processing ", file_name)
        output_file_name = os.path.join(output_folder, file_name+output_postfix)
        with _open(f, gzipped) as input_:
            sample_index=[]
            with open(output_file_name, "w") as output_:
                for i,line in enumerate(input_):
                    line = _iline(line, gzipped)
                    comps = line.strip().split()
                    if i == 0:
                        sample_index = [comps.index(x) for x in samples if x in comps]
                        output_.write(to_line(row_name, comps, sample_index))
                        continue

                    output_.write(to_line(comps[name_index], comps, sample_index))

if __name__ == "__main__":
    IF = "/group/im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_expression_matrices"
    OF = "expression"
    EXPR = "(.*).v8.normalized_expression.bed.gz$"
    SAMPLES = "/scratch/abarbeira3/test/eur_samples.txt"
    OP="_Analysis.expression.txt"
    ROW_NAME="Name"
    NAME_INDEX=3
    run(SAMPLES, IF, EXPR, OF, OP, ROW_NAME, NAME_INDEX)