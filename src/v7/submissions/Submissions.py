__author__ = "alvaro barbeira"
import logging
import sys
import os
import time
from subprocess import Popen, PIPE

def configure_logging(level=5, target=sys.stderr, log_file=None):
    logger = logging.getLogger()
    logger.setLevel(level)

    # create console handler and set level to info
    handler = logging.StreamHandler(target)
    handler.setLevel(level)
    formatter = logging.Formatter("%(levelname)s - %(message)s")
    handler.setFormatter(formatter)
    logger.addHandler(handler)

    if log_file:
        fileHandler = logging.FileHandler("log_file")
        fileHandler.setFormatter(formatter)
        logger.addHandler(fileHandler)

def build_header(job_name, mem="4gb", walltime="1:00:00", module_clause="", email="a@a.com"):
    header = \
"""#!/bin/bash
#PBS -N {}
#PBS -M {}
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime={}
#PBS -l nodes=1:ppn=1
#PBS -l mem={}
#PBS -o logs/${{PBS_JOBNAME}}.o${{PBS_JOBID}}.log
#PBS -e logs/${{PBS_JOBNAME}}.e${{PBS_JOBID}}.err
    
cd $PBS_O_WORKDIR
    
{}
    
""".format(job_name, email, walltime, mem, module_clause)
    return header

def _submit(path, job_name):
    command = ["qsub",path]
    def submit():
        logging.log(8,"Submitting Command: %s", " ".join(command))
        proc = Popen(command,stdout=PIPE, stderr=PIPE)
        out, err = proc.communicate()
        exitcode = proc.returncode
        return exitcode, out, err

    exitcode, out, err = submit()
    retry=0
    while exitcode != 0 and retry < 10:
        logging.info("retry %s %i-th attempt", job_name, retry)
        exitcode, out, err = submit()
        retry += 1
        time.sleep(0.1)
    time.sleep(0.1)
    return out.strip() if exitcode==0 else None

def submit(args, name, command):
    job_name = name + ".sh"
    path = os.path.join(args.jobs_folder, job_name)
    if os.path.exists(path):
        logging.info("%s already exists, skipping", path)
        return name

    with open(path, "w") as out:
        out.write(command)

    if args.fake_submit:
        return name
    id = _submit(path, name)
    return id