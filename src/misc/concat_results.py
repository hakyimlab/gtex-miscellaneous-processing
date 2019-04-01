__author__ = "alvaro barbeira"
import os
import gzip
import re
def run(args):
    pattern = re.compile(args.pattern[0])
    fields = args.pattern[1:]

    i = [x for x in sorted(os.listdir(args.input_folder)) if pattern.search(x)]

    o = os.path.split(args.output_file)[0]
    if not os.path.exists(o):
        os.makedirs(o)

    print("Started")
    format = args.sep.join(["{}"]*(len(fields)+1)) + "\n"

    with gzip.open(args.output_file, "w") as o:
        for nf,f in enumerate(i):
            if args.max_files and nf >= args.max_files:
                print("early abort")
                break

            s = pattern.search(f)
            fields_ = [s.group(x+1) for x in range(0,len(fields))]
            print(*fields_)
            with open(os.path.join(args.input_folder,f)) as r:
                for n,l in enumerate(r):
                    if n == 0:
                        if nf == 0:
                            header = format.format(*([l.strip()]+fields))
                            o.write(header.encode())
                        continue

                    line = format.format(*([l.strip()]+fields_)).encode()
                    o.write(line)
    print("End")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser("concatenate phenotype-tissue results")
    parser.add_argument("-input_folder")
    parser.add_argument("-output_file")
    parser.add_argument("-sep", default="\t")
    parser.add_argument("-pattern", nargs="+")
    parser.add_argument("-max_files", type=int)
    args = parser.parse_args()

    run(args)