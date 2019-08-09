#!/usr/bin/env python
__author__ = "alvaro barbeira"
from helpers import helpers
import re
import os
import pandas
import logging

def _to_sec(s):
    return sum(x * int(t) for x, t in zip([3600, 60, 1], s.split(":")))

def run(args):
    r, subfield_names, subfield_position, subfield_regexp = helpers.name_parse_prepare(args.name_subfield_regexp, args.name_subfield)
    p = re.compile("Resources Used:\s+cput=(.*),vmem=(.*)kb,walltime=(.*),mem=(.*)kb,energy_used=(.*)")

    files = [x for x in os.listdir(args.logs_folder) if r.search(x)]
    r = []
    for i, file in enumerate(files):
        path = os.path.join(args.logs_folder, file)
        logging.log(9, "%s", file)

        with open(path) as f:
            for line in f:
                s = p.search(line)

                if s:
                    values = helpers.name_parse(file, subfield_regexp, subfield_position)
                    mem  = int(s.group(4))/1024
                    vmem = int(s.group(2))/1024
                    walltime= _to_sec(s.group(3))
                    cputime = _to_sec(s.group(1))
                    r_ = (file, mem, vmem, walltime,cputime)
                    if values:
                        r_ += values
                    r.append(r_)

    r = pandas.DataFrame(r, columns=["name", "memory", "v_memory", "walltime", "cputime"] + subfield_names)
    r.to_csv(args.output, sep="\t", index=False)

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser("Compare jobs to expected result")
    parser.add_argument("-logs_folder", help="Where the submission jobs will be saved", default="jobs")
    parser.add_argument("-output", help="Path where the output will be saved", default="job_log.txt")
    parser.add_argument("-verbosity", help="Log verbosity level. 1 is everything being logged. 10 is only high level messages, above 10 will hardly log anything", default = 10, type=int)
    parser.add_argument("-name_subfield", help="Specify multiple key-value pairs to specify format conversion", nargs=2, action="append", default =[])
    parser.add_argument("-name_subfield_regexp", help="Specify multiple key-value pairs to specify format conversion")

    args = parser.parse_args()

    helpers.configure_logging(int(args.verbosity))

    run(args)