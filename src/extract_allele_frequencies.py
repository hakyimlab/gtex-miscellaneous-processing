#!/usr/bin/env python
__author__ = "alvaro barbeira"

import gzip
import numpy
import sys

def run(input_file, output_file):
    print("Opening {}".format(input_file))
    with gzip.open(input_file) as i_:
        #discard header
        i_.readline()
        print("Writing {}".format(output_file))
        with gzip.open(output_file, "w") as o_:
            o_.write("variant\tfrequency\n".encode())
            for line in i_:
                comps = line.decode().strip().split()
                n = [x for x in comps[1:] if x != "NA"]
                n = numpy.array(n, dtype=numpy.float32)
                freq = numpy.mean(n)/2
                l = "{}\t{}\n".format(comps[0], freq).encode()
                o_.write(l)

if __name__ == "__main__":
    #run("gtex_v8_afr_shapeit2_phased_maf01.txt.gz", "gtex_v8_afr_shapeit2_phased_maf01_snps.txt.gz")
    run(sys.argv[1], sys.argv[2])