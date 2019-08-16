__author__ = "alvaro barbeira"

import argparse
import logging
from helpers import helpers

parser = argparse.ArgumentParser("Compare jobs to expected result")
parser.add_argument("-input")
parser.add_argument("-output")
parser.add_argument("-columns", nargs="+", type=int)
parser.add_argument("-parsimony", help="Log verbosity level. 1 is everything being logged. 10 is only high level messages, above 10 will hardly log anything", default = 10, type=int)
args = parser.parse_args()

helpers.configure_logging(int(args.parsimony))

logging.info("Started")
with open(args.input) as i:
    with open(args.output, "w") as o:
        for line in i:
            comps = line.strip().split()
            for column in args.columns:
                if "." in comps[column]:
                    comps[column] = comps[column].split(".")[0]
            line = "{}\n".format("\t".join(comps))
            o.write(line)
logging.info("Ended")