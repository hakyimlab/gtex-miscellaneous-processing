#!/usr/bin/env python
__author__ = "alvaro barbeira"
import pandas
import re

def _metadatize(i):
    print("extracting metadata...")
    k = i.variant.str.split("_")
    i["chromosome"] = k.str.get(0)
    i["position"] = k.str.get(1).astype(int)
    i["non_effect_allele"] = k.str.get(2)
    i["effect_allele"] = k.str.get(3)
    return i

def __keep_most_frequent(i):
    print("keeping most frequent...")
    top = i.groupby(["chromosome", "position"]).\
        apply(lambda x: x.sort_values(by="frequency", ascending=False)).\
        reset_index(drop=True).groupby(["chromosome", "position"]).\
        head(1)

    top.drop("k", axis=1, inplace=True)
    print("{} variants kept after selecting most frequent variant".format(i.shape[0]))
    return top

def _keep_most_frequent(i):
    print("keeping most frequent...")
    i["k"] = i.chromosome + "_" + i.position.astype(str)
    top = i.groupby("k").\
        apply(lambda x: x.sort_values(by="frequency", ascending=False)).\
        reset_index(drop=True).groupby("k").\
        head(1)

    top.drop("k", axis=1, inplace=True)

    print("{} variants kept after selecting most frequent variant".format(top.shape[0]))
    return top


def _filter_by_frequency(i, freq_filter):
    print("filtering...")
    if freq_filter:
        i = i.loc[(freq_filter < i.frequency) & (i.frequency < (1- freq_filter))]
    print("{} variants after filtering".format(i.shape[0]))
    return i

def _order(i):
    print("ordering...")
    i["chr"] = i.chromosome.str.split("chr").str.get(1).astype(int)
    i = i.sort_values(by=["chr", "position"])
    i.drop("chr", axis=1, inplace=True)
    return i

def _filter_chromosomes(i):
    pattern = re.compile("chr(\d+)$")
    i = i[i.chromosome.str.match(pattern)]
    return i

def run(infile, outfile, freq_filter=None):
    print("loading")
    i = pandas.read_table(infile)
    print("{} variants read".format(i.shape[0]))

    i = _filter_by_frequency(i, freq_filter)

    i = _metadatize(i)

    i = _keep_most_frequent(i)

    i = _filter_chromosomes(i)

    i = _order(i)

    i = i[["variant", "chromosome", "position", "non_effect_allele", "effect_allele", "frequency"]]

    i.to_csv(outfile, index=False, compression="gzip", sep="\t")

if __name__ == "__main__":
    run("kk.txt.gz", "kkm.txt.gz", 0.01)