__author__ = "alvaro barbeira"
import os
import gzip
import re
def run(args):
    fields = args.fields

    if args.pattern:
        pattern = re.compile(args.pattern)
        input_file = os.path.split(args.input_file)[1]
        s = pattern.search(input_file)
        values = [s.group(x + 1) for x in range(0, len(fields))]
    elif args.values:
        values = args.values
    else:
        raise RuntimeError("Need values")

    o = os.path.split(args.output_file)[0]
    if not os.path.exists(o):
        os.makedirs(o)

    print("Started")
    format = args.sep.join(["{}"]*(len(fields)+1)) + "\n"

    if "gz" in args.input_file:
        read_ = gzip.open
        l_ = lambda x: x.decode()
    else:
        read_ = open
        l_ = lambda x: x

    with read_(args.input_file) as f:
        with open(args.output_file, "w") as o:
            for n,l in enumerate(f):
                l = l_(l)
                if n == 0:
                    header = format.format(*([l.strip()]+fields))
                    o.write(header)
                    continue

                line = format.format(*([l.strip()]+values))
                o.write(line)
    print("End")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser("concatenate phenotype-tissue results")
    parser.add_argument("-input_file")
    parser.add_argument("-output_file")
    parser.add_argument("-sep", default="\t")
    parser.add_argument("-pattern")
    parser.add_argument("-fields", nargs="+")
    parser.add_argument("-values", nargs="+")
    args = parser.parse_args()

    run(args)