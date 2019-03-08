__author__ = "alvaro barbeira"
import os
import gzip
import re
def run(args):
    pattern = re.compile(args.pattern)

    i = [x for x in sorted(os.listdir(args.input_folder)) if pattern.search(x)]

    o = os.path.split(args.output_file)[0]
    if not os.path.exists(o):
        os.makedirs(o)

    print("Started")
    with gzip.open(args.output_file, "w") as o:
        for nf,f in enumerate(i):
            s = pattern.search(f)
            trait = s.group(1)
            tissue = s.group(2)
            print(trait, tissue)
            with open(os.path.join(args.input_folder,f)) as r:
                for n,l in enumerate(r):
                    if n == 0:
                        if nf == 0:
                            header = l.strip() + ",trait,tissue\n"
                            o.write(header.encode())
                        continue

                    l = "{},{},{}\n".format(l.strip(), trait, tissue).encode()
                    o.write(l)
    print("End")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser("concatenate phenotype-tissue results")
    parser.add_argument("-input_folder")
    parser.add_argument("-output_file")
    parser.add_argument("-pattern")
    args = parser.parse_args()

    run(args)