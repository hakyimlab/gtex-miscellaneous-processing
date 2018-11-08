#!/usr/bin/env python
import os
import re
import logging

from submissions import Submissions

def _loop(args):
    regex = re.compile(args.expression_regex)
    expression_files = sorted([x for x in os.listdir(args.expression_folder) if regex.search(x)])

    expression_names = [regex.search(x).group(1) for x in expression_files]
    expression_files = [os.path.join(args.expression_folder,x) for x in expression_files]
    for i in range(0, len(expression_names)):
        name = expression_names[i]
        if should_skip(args, name):
            logging.info("Skipping %s", name)
            continue
        file = expression_files[i]
        if args.sub_batches:
            for j in range(0, args.sub_batches):
                yield name, file, j
        else:
            yield name, file, None

def _the_name(args, name, sub_batch):
    name_a = name
    if args.sub_batches: name_a = "bslmm_{}_{}".format(name_a, sub_batch)
    return name_a

def build_command(args, name, expression_file, sub_batch):
    if args.sub_batches >= 1000:
        mem ="8gb"
    else:
        mem= "16gb"
    name_a = _the_name(args, name, sub_batch)
    #at the moment, gemma 0.96 is way faster than 0.97 oin CRI
    header = Submissions.build_header(name_a, email=args.email, walltime="60:00:00", mem=mem, module_clause=
"""module load gcc/6.2.0
module load gemma/0.96
module load python/3.5.3""")

    command = header
    command += "python3 {} \\\n".format(args.tool_command)
    command += "-gemma_command {} \\\n".format(args.gemma_command)
    command += "-intermediate_folder {} \\\n".format(os.path.join(args.intermediate_folder, name_a))
    command += "-gene_annotation {} \\\n".format(args.gene_annotation)
    command += "-parquet_genotype {} \\\n".format(args.study_prefix+".variants.parquet")
    command += "-parquet_genotype_metadata {} \\\n".format(args.study_prefix+".variants_metadata.parquet")
    command += "-parquet_phenotype {} \\\n".format(expression_file)
    command += "-window {} \\\n".format(args.window)
    command += "-verbosity {} \\\n".format(args.verbosity)

    if args.sub_batches:
        command += "-sub_batches {} \\\n".format(args.sub_batches)
        command += "-sub_batch {} \\\n".format(sub_batch)

    if args.output_weights:
        command += "-output_weights {} \\\n".format(os.path.join(args.output_folder, name_a+ ".weights.txt.gz"))
    if args.output_covariance:
        command += "-output_covariance {} \\\n".format(os.path.join(args.output_folder, name_a+ ".covariance.txt.gz"))
    if args.output_hyperparameters:
        command += "-output_hyperparameters {} \\\n".format(os.path.join(args.output_folder, name_a + ".hyperparameters.txt.gz"))
    if args.output_stats:
        command += "-output_stats {}".format(os.path.join(args.output_folder, name_a+ ".stats.txt.gz"))

    if args.discard_gemma_output:
        command += " > /dev/null"

    return command, name_a

def should_skip(args, name):
    if not args.white_list:
        return False
    else:
        white_list = [re.compile(p) for p in args.white_list]

    should_skip_ = True
    for p in white_list:
        if p.search(name):
            should_skip_ = False
            break
    return should_skip_

def run(args):
    if not os.path.exists(args.jobs_folder): os.makedirs(args.jobs_folder)
    if not os.path.exists(args.logs_folder): os.makedirs(args.logs_folder)
    if not os.path.exists(args.output_folder): os.makedirs(args.output_folder)
    if not os.path.exists(args.intermediate_folder): os.makedirs(args.intermediate_folder)

    for name, expression_file, sub_batch in _loop(args):
        command, the_name = build_command(args, name, expression_file, sub_batch)
        id = Submissions.submit(args, the_name, command)
        logging.info("Submission: {}/{}".format(the_name, str(id)))

    logging.info("Ran.")

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser("Submit BSLMM jobs")
    parser.add_argument("-gemma_command", help="which gemma executable to use")
    parser.add_argument("-tool_command", help="path to the conversion script")
    parser.add_argument("-expression_folder", help="path to expression folder")
    parser.add_argument("-expression_regex", help="expression to extract study name")
    parser.add_argument("-gene_annotation", help="gencode-like gene annotation")
    parser.add_argument("-study_prefix", help="Prefix for the output study")
    parser.add_argument("-output_folder", help="where will the study be output")
    parser.add_argument("-intermediate_folder", help="Intermediate folder to save temporary working stuff")
    parser.add_argument("-sub_batches", help="Split each job into this number of job batches", type=int, default=None)
    parser.add_argument("-window", help="How many positions tou want the window to be long", type=int, default=None)
    parser.add_argument("-jobs_folder", help="Where will the jobs be output")
    parser.add_argument("-logs_folder", help="Where to output the logs")
    parser.add_argument("-fake_submit", help="don't submit to the queue, just create job submission scripts", action="store_true", default=False)
    parser.add_argument("-verbosity", help="Verbosity of this script and the generated jobs", type=int, default=10)
    parser.add_argument("-discard_gemma_output", help="Redirect gemma console ouytput to the void", action="store_true", default=False)
    parser.add_argument("-white_list", help="Patterns to filter input files", type=str, nargs="+")
    parser.add_argument("-output_weights", help="don't submit to the queue, just create job submission scripts", action="store_true", default=False)
    parser.add_argument("-output_covariance", help="don't submit to the queue, just create job submission scripts", action="store_true", default=False)
    parser.add_argument("-output_stats", help="don't submit to the queue, just create job submission scripts", action="store_true", default=False)
    parser.add_argument("-output_hyperparameters", help="don't submit to the queue, just create job submission scripts", action="store_true", default=False)
    parser.add_argument("-email", help="email for the queue to notify")

    args = parser.parse_args()

    Submissions.configure_logging(args.verbosity)
    run(args)