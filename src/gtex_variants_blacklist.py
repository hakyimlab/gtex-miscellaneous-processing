#!/usr/bin/env python
__author__ = "alvaro barbeira"
import gzip
import pandas

def _gen(input_file):
    with gzip.open(input_file) as f:
        for i, line in enumerate(f):
            line = line.decode()
            comps = line.strip().split()
            chr = comps[0]
            pos = comps[1]
            variant = comps[2]
            key = "{}_{}".format(chr, pos)

            yield chr, pos, variant, key, comps

def get_key_black_list(input_file):
    found = set()
    key_black_list = set()
    for chr, pos, variant, key, comps in _gen(input_file):
        if key in found:
            key_black_list.add(key)
            continue
        found.add(key)
    return key_black_list

def get_blacklisted(input_file, key_black_list, frequency_file):
    print("gathering variants")
    d=[]
    for chr, pos, variant, key, comps in _gen(input_file):
        if key in key_black_list:
            d.append((chr, pos, key, variant))
    d = pandas.DataFrame(d, columns=["chromosome", "position", "key", "variant"])
    _v = {x for x in d.variant}

    print("getting frequencies")
    #Extra line with the header, we don't care
    f = []
    with gzip.open(frequency_file) as f_:
        for i,l in enumerate(f_):
            comps = l.decode().strip().split()
            v = comps[0]
            if v in _v:
                f.append((comps[0], comps[1]))
    f = pandas.DataFrame(f, columns=["variant", "frequency"])
    m = d.merge(f, on="variant")

    top = m.groupby("key").\
        apply(lambda x: x.sort_values(by="frequency", ascending=False)).\
        reset_index(drop=True).groupby("key").\
        head(1).sort_values(by=["chromosome", "position"])
    top_variants = {x for x in top.variant}

    blacklisted = m.loc[~m.variant.isin(top_variants)]

    return blacklisted[["variant", "chromosome", "position", "frequency"]]

def generate_discarded(input_file, output_file, key_black_list):
    with gzip.open(output_file, "w") as _o:
        _o.write(b"variant_id\n")
        for chr, pos, variant, key, comps in _gen(input_file):
            if key in key_black_list:
                _o.write("{}\n".format(variant).encode())

def do_blacklist(input_file, output_file):
    print("scanning")
    key_black_list = get_key_black_list(input_file)
    print("saving")
    generate_discarded(input_file, output_file, key_black_list)

def do_blacklist_2(input_file, output_file, frequency_file):
    print("scanning")
    key_black_list = get_key_black_list(input_file)
    print("assembling blacklist")
    variant_black_list = get_blacklisted(input_file, key_black_list, frequency_file)
    print("saving")
    variant_black_list.to_csv(output_file, index=False, sep="\t", compression="gzip")
    print("done")

I="/home/numa/Documents/Projects/data/GTEx/v8/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz"
F="/home/numa/Documents/Projects/data/GTEx/v8/synth/gtex_v8_all_af.txt.gz"
#F="/home/numa/Documents/Projects/data/GTEx/v8/synth/kk_af.txt.gz"
O="results/gtex_variants_blacklist.txt.gz"
do_blacklist_2(I,O,F)



