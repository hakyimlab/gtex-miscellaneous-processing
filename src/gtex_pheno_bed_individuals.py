#!/usr/bin/env python
__author__ = "alvaro barbeira"

# module load gcc/6.2.0
# module load python/3.5.3

import os
import pandas
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

def run(args):
    print("Start")
    if len(args.individuals) == 3:
        individuals = pandas.read_table(args.individuals[0])
        individuals = individuals[individuals[args.individuals[1]] == 1]
        whitelist = {x for x in individuals[args.individuals[2]]}
    else:
        raise RuntimeError("Unsupported individuals arguments")

    with gzip.open(args.bed) as pheno:
        h = pheno.readline().decode()
        h = h.split()[4:]
        h = [x for x in h if x in whitelist]

    with open(args.output, "w") as o:
        for i in h:
            o.write(i+"\n")
    print("Done")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser("extract individuals using whitelist")
    parser.add_argument("-bed")
    parser.add_argument("-individuals", nargs="+")
    parser.add_argument("-output")
    args = parser.parse_args()
    run(args)
