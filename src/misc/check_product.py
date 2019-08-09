__author__ = "alvaro barbeira"
import os
import re
import pandas
import logging
from helpers import helpers

########################################################################################################################

def run(args):
    logging.info("Deprecated, superceded by check_log.py")
    return
    job_re = re.compile(args.jobs_pattern)
    job_names, job_paths = helpers.parse_with_regexp(args.jobs_folder, job_re)

    re_re = re.compile(args.results_pattern)
    results_by_name = helpers.identify_with_regexp(args.results_folder, re_re)

    complete =[]
    result_path=[]
    for job_name in job_names:
        if not job_name in results_by_name:
            complete.append(False)
            result_path.append(None)
            continue


        r_ = os.path.join(args.results_folder, results_by_name[job_name])
        result_path.append(r_)
        complete.append(True)

    r = pandas.DataFrame({"job_name":job_names, "job_path":job_paths, "result_path":result_path, "complete":complete})
    r.to_csv(args.output, sep="\t", index=False)

    if args.resubmit:
        helpers.resubmit(r)

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser("Compare jobs to expected result")
    parser.add_argument("-jobs_folder", help="Where the submission jobs will be saved", default="jobs")
    parser.add_argument("-jobs_pattern", help="Select job name token", default="jobs")
    parser.add_argument("-results_folder", help= "Path to results files")
    parser.add_argument("-results_pattern", help="Select job esult token")
    parser.add_argument("-output", help="Path where the output will be saved", default="job_log.txt")
    parser.add_argument("-verbosity", help="Log verbosity level. 1 is everything being logged. 10 is only high level messages, above 10 will hardly log anything", default = 10, type=int)
    parser.add_argument("--resubmit", help="wether to submit missing jobs", action="store_true")
    #parser.add_argument("--serialize_local", help="If resubmitting job, just run locally", action="store_true", default=False)
    #parser.add_argument("--log_file", help="On top of everything else, save to a file")

    args = parser.parse_args()

    helpers.configure_logging(int(args.verbosity))

    run(args)