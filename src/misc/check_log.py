__author__ = "alvaro barbeira"
import os
import re
import pandas

from helpers import helpers
########################################################################################################################

def run(args):
    job_regexp = re.compile(args.jobs_pattern)
    job_names, job_paths = helpers.parse_with_regexp(args.jobs_folder, job_regexp)

    err_regexp = re.compile(args.logs_pattern)
    logs_by_name = helpers.identify_with_regexp(args.logs_folder, err_regexp)

    result=[]
    log_path=[]
    for job_name in job_names:
        if not job_name in logs_by_name:
            result.append(False)
            log_path.append(None)
            continue

        l_ = os.path.join(args.logs_folder, logs_by_name[job_name])
        log_path.append(l_)
        result.append(helpers.check_present(l_, args.finish_token))

    r = pandas.DataFrame({"job_name":job_names, "job_path":job_paths, "log_path":log_path, "complete":result})
    helpers.ensure_requisite_folders(args.output)
    r.to_csv(args.output, sep="\t", index=False)

    if args.resubmit or args.resubmit_log_only:
        helpers.resubmit(r, args.resubmit_log_only)

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
    parser.add_argument("--resubmit", help="wether to submit missing jobs", action="store_true")
    parser.add_argument("--resubmit_log_only", help="wether to submit missing jobs", action="store_true")
    #parser.add_argument("--serialize_local", help="If resubmitting job, just run locally", action="store_true", default=False)
    #parser.add_argument("--log_file", help="On top of everything else, save to a file")

    args = parser.parse_args()

    helpers.configure_logging(int(args.parsimony))

    run(args)