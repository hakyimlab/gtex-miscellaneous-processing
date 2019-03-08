__author__ = "alvaro barbeira"

import os
import re
import gzip
import sqlite3
import pandas

def rename_columns(df):
    columns = df.columns.values
    _rename={}
    for c in columns:
        if "." in c:
            _rename[c] = c.replace(".", "_")
    return _rename


def run(args):
    pattern = re.compile(args.pattern)

    i = [x for x in sorted(os.listdir(args.input_folder)) if pattern.search(x)]

    o = os.path.split(args.output_prefix)[0]
    if not os.path.exists(o):
        os.makedirs(o)

    _extra = args.output_prefix + "_extra.csv.gz"
    _weights = args.output_prefix + "_weights.csv.gz"
    print("Started")
    with gzip.open(_extra, "w") as _extra:
        with gzip.open(_weights, "w") as _weights:
            for nf, f in enumerate(i):
                tissue = pattern.search(f).group(1)
                print(tissue)
                with sqlite3.connect(os.path.join(args.input_folder, f)) as conn:
                    extra = pandas.read_sql("select * from extra", conn).assign(tissue = tissue)
                    extra.rename(columns=rename_columns(extra), inplace=True)
                    e = extra.to_csv(index = False, header = (nf == 0), na_rep="NA").encode()
                    _extra.write(e)

                    weights = pandas.read_sql("select * from weights", conn).assign(tissue = tissue)
                    weights.rename(columns=rename_columns(weights), inplace=True)
                    w = weights.to_csv(index = False, header = (nf == 0),na_rep="NA").encode()
                    _weights.write(w)
    print("Ended")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser("concatenate phenotype-tissue results")
    parser.add_argument("-input_folder")
    parser.add_argument("-output_prefix")
    parser.add_argument("-pattern")
    args = parser.parse_args()

    run(args)