__author__ = "alvaro barbeira"
import logging
import os
import sys
import re

import subprocess
import time

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


def check_present(path, token):
    present = False
    with open(path) as f:
        for line in f:
            if token in line:
                present = True
                break
    return present

def resubmit(r):
    r = r[r.complete == False].drop_duplicates()
    for t in r.itertuples():
        if t.complete == False:
            logging.info("Resubmitting %s", t.job_name)
            subprocess.call(["qsub", t.job_path])
            time.sleep(0.1)


def parse_with_regexp(folder, regexp):
    files = sorted([x for x in os.listdir(folder) if regexp.search(x)])
    paths = [os.path.join(folder,x) for x in files]
    names = [regexp.search(x).group(1) for x in files]
    return names, paths


def identify_with_regexp(folder, regexp):
    files = os.listdir(folder)
    by_name = {}
    for f in files:
        r = regexp.search(f)
        if r:
            by_name[r.group(1)] = f
    return by_name

def ensure_requisite_folders(path):
    folder = os.path.split(path)[0]
    if len(folder) and not os.path.exists(folder):
        os.makedirs(folder)
