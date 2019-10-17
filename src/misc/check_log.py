__author__ = "alvaro barbeira"
import os
import re
import pandas
import logging

from helpers import helpers
########################################################################################################################

def run(args):
    r, subfield_names, subfield_positions = helpers.name_parse_prepare(args.name_subfield_regexp, args.name_subfield)

    job_regexp = re.compile(args.jobs_pattern)
    job_names, job_paths = helpers.parse_with_regexp(args.jobs_folder, job_regexp)

    err_regexp = re.compile(args.logs_pattern)
    logs_by_name = helpers.identify_with_regexp(args.logs_folder, err_regexp)

    result=[]

    for (i,job_name) in enumerate(job_names):
        values = helpers.name_parse(job_name, r, subfield_positions) if r else None
        if not job_name in logs_by_name:
            log_path = None
            present = False
        else:
            log_path = os.path.join(args.logs_folder, logs_by_name[job_name])
            present = helpers.check_present(log_path, args.finish_token)

        r = (job_name, job_paths[i], log_path, present)
        if values:
            r += tuple(values)

        if args.check_product:
            arguments = helpers.argumentize(subfield_names, subfield_positions, values)
            for product, pattern in args.check_product:
                target = pattern.format(**arguments)
                r += (os.path.exists(target),)

        result.append(r)

    columns = ["job_name", "job_path", "log_path", "complete"]
    if subfield_names:
        columns += subfield_names
    if args.check_product:
        columns_ = [name for name,pattern in args.check_product]
        columns += columns_

    result = pandas.DataFrame(result, columns=columns)
    helpers.ensure_requisite_folders(args.output)
    result.to_csv(args.output, sep="\t", index=False, na_rep="NA")

    if args.resubmit or args.resubmit_log_only or args.clean_target or args.check_product:
        helpers.post_check(result, args.resubmit, args.resubmit_log_only, args.clean_target, subfield_names, subfield_positions, args.check_product)

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser("Compare jobs to expected result")
    parser.add_argument("-jobs_folder", help="Where the submission jobs will be saved", default="jobs")
    parser.add_argument("-jobs_pattern", help="Job name pattern", default="(.*).sh")
    parser.add_argument("-logs_folder", help= "Path to results files")
    parser.add_argument("-logs_pattern", help="Log name pattern", default="(.*)\.e(\d+)\.cri(.*)\.err$")
    parser.add_argument("-finish_token", help="what to look for in the file")
    parser.add_argument("-output", help="Path where the output will be saved", default="job_log.txt")
    parser.add_argument("-parsimony", help="Log verbosity level. 1 is everything being logged. 10 is only high level messages, above 10 will hardly log anything", default = 10, type=int)
    parser.add_argument("--check_product", help="name of product, and pattern to find it", nargs="+", action="append", default=[])
    parser.add_argument("--resubmit", help="wether to submit missing jobs", action="store_true")
    parser.add_argument("--resubmit_log_only", help="wether to submit missing jobs", action="store_true")
    parser.add_argument("--name_subfield", help="Specify multiple key-value pairs to specify format conversion", nargs=2, action="append", default =[])
    parser.add_argument("--name_subfield_regexp", help="Specify multiple key-value pairs to specify format conversion")
    parser.add_argument("--clean_target", help="pattern of stuff to be removed", action="append", default=[])

    #parser.add_argument("--serialize_local", help="If resubmitting job, just run locally", action="store_true", default=False)
    #parser.add_argument("--log_file", help="On top of everything else, save to a file")

    args = parser.parse_args()

    helpers.configure_logging(int(args.parsimony))

    run(args)