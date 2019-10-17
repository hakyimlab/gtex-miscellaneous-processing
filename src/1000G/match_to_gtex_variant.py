__author__ = "alvaro barbeira"
import gzip
import os

def run(args):
    print("Reading gtex key map")
    variants = set()
    with gzip.open(args.key_map) as f:
        f.readline()
        for l in f:
            comps = l.decode().split()
            variants.add(comps[2])

    p = os.path.split(args.output)[0]
    if not os.path.exists(p):
        os.makedirs(p)

    print("Processing")
    with gzip.open(args.input) as i:
        with gzip.open(args.output, "w") as o:
            for l in i:
                comps = l.decode().strip().split()
                chr = "chr"+comps[0]
                pos = comps[2]
                ref_allele = comps[3]
                eff_allele = comps[4]

                var_id = "{}_{}_{}_{}_b38".format(chr, pos, ref_allele, eff_allele)
                if var_id in variants:
                    comps[1] = var_id
                    ol = "{}\n".format("\t".join(comps))
                    o.write(ol.encode())
                    next

                var_id = "{}_{}_{}_{}_b38".format(chr, pos, eff_allele, ref_allele)
                if var_id in variants:
                    comps[1] = var_id
                    comps[3], comps[4] = comps[4], comps[3]
                    comps[5] = str(1-float(comps[5]))
                    d = list(map(lambda x: str(2-int(x)), comps[6:]))
                    comps = comps[0:6] + d
                    ol = "{}\n".format("\t".join(comps))
                    o.write(ol.encode())
    print("Finished")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser("get variants and match to GTEX")
    parser.add_argument("-input")
    parser.add_argument("-output")
    parser.add_argument("-key_map")

    args = parser.parse_args()
    run(args)
