#!/usr/bin/env python
__author__ = "alvaro barbeira"

import re
import os
import logging
from submissions import Submissions

def _loop(args):
    r = re.compile(args.eqtl_regex)
    f = [x for x in os.listdir(args.eqtl_folder) if r.search(x)]
    names = [r.search(x).group(1) for x in f]
    paths = [os.path.join(args.eqtl_folder,x) for x in f]
    for i in range(0, len(names)):
        yield names[i], paths[i]

def build_command(args, name, eqtl_file):
    job_name = "gtex_eqtl_conversion_{}".format(name)
    header = Submissions.build_header(job_name, email=args.email, walltime="4:00:00", mem="10gb", module_clause=
"""module load gcc/6.2.0
module load python/3.5.3""")

    output = os.path.join(args.output_folder, "{}_eqtl.parquet".format(name))
    command = header

    command += "python3 {} \\\n".format(args.tool_command)
    command += "-snp_annotation {} \\\n".format(args.snp_annotation)
    command += "-gtex_eqtl_file {} \\\n".format(eqtl_file)
    command += "-parquet_output {} \\\n".format(output)
    command += "-verbosity {}".format(args.verbosity)
    return command, name

def run(args):
    if not os.path.exists(args.jobs_folder): os.makedirs(args.jobs_folder)
    if not os.path.exists(args.logs_folder): os.makedirs(args.logs_folder)
    if not os.path.exists(args.output_folder): os.makedirs(args.output_folder)

    logging.info("Started submitting GTEx eQTL conversion")

    for name, eqtl_file in _loop(args):
        command, the_name = build_command(args, name, eqtl_file)
        id = Submissions.submit(args, the_name, command)
        logging.info("Submission: {}/{}".format(name, str(id)))

    logging.info("Ran.")

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser("Submit GTEx conversion files")
    parser.add_argument("-tool", help="Where the actual conversion script lies")
    parser.add_argument("-eqtl_folder", help="Path to GTEx eQTL studies")
    parser.add_argument("-eqtl_regex", help= "Regular expression to select eQTL file name")
    parser.add_argument("-snp_annotation", help = "GTEx file annotation")
    parser.add_argument("-output_folder", help= "Where to store the output")
    parser.add_argument("-jobs_folder", help="Where to keep the job submission scripts")
    parser.add_argument("-logs_folder", help="Where to keep the log files")
    parser.add_argument("-fake_submit", help="Don't actually submit to the queue, just generate the scripts", action="store_true", default=False)
    parser.add_argument("-verbosity", help="Verbosity of this script and generated jobs", type=int, default=10)
    parser.add_argument("-email", help="Where should the queue send messages to")

    args = parser.parse_args()

    Submissions.configure_logging(args.verbosity)
    run(args)