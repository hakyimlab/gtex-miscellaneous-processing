__author__ = "alvaro barbeira"
import logging
import os
import sys
import re
import glob
import shutil
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

def clean_target(target):
    paths = glob.glob(target)
    if not paths:
        logging.info("Found nothing applicable to clean")
    for path in paths:
        try:
            if os.path.isdir(path):
                logging.info("Cleaning folder: %s", path)
                shutil.rmtree(path)
            else:
                logging.info("Cleaning file: %s", path)
                os.remove(path)
        except Exception as e:
            logging.exception("Error with " + path)

def post_check(r, resubmit=False, resubmit_log_only=False, clean_targets=None, subfield_names=None, subfield_positions=None, check_product=None):
    if r.job_name.shape[0] != r.job_name.drop_duplicates().shape[0]:
        raise RuntimeError("Won't take duplicate job names")

    redone=[]
    for t in r.itertuples():
        if resubmit_log_only and not (type(t.log_path) == str and len(t.log_path) > 1):
            continue

        redo = False
        if not t.complete:
            logging.info("Logs mark this for redo")
            redo=True
        elif check_product:
            for product, pattern in check_product:
                if not getattr(t,product):
                    logging.info("Missing product [%s] marks this for redo", product)
                    redo=True
                    break

        if redo:
            redone.append(t.job_name)
            logging.info("Cleaning %s", t.job_name)
            values = tuple(t)[5:]
            arguments = argumentize(subfield_names, subfield_positions, values)
            for target_ in clean_targets:
                target = target_.format(**arguments)
                logging.info("Cleaning target: %s", target)
                clean_target(target)

            for product, pattern in check_product:
                target = pattern.format(**arguments)
                logging.info("Cleaning product: %s", target)
                clean_target(target)

            if resubmit:
                logging.info("Resubmitting %s", t.job_name)
                subprocess.call(["qsub", t.job_path])
                time.sleep(0.1)
    logging.info("Redid %i", len(redone))


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

def name_parse_prepare(name_subfield_regexp, name_subfield):
    if name_subfield and name_subfield_regexp:
        r = re.compile(name_subfield_regexp)
        subfield_names = [x[0] for x in name_subfield]
        subfield_positions = [int(x[1]) for x in name_subfield]
        subfield_regexp = re.compile(name_subfield_regexp)
    else:
        r = None
        subfield_names = None
        subfield_positions = None
        subfield_regexp = None
    return r, subfield_names, subfield_positions, subfield_regexp

def name_parse(file, subfield_regexp, subfield_positions):
    if subfield_positions:
        values = []
        s_ = subfield_regexp.search(file)
        for position in subfield_positions:
            values.append(s_.group(position))
        values = tuple(values)
    else:
        values = None
    return values


def argumentize(subfield_names, subfield_positions, values):
    return {subfield_names[i-1]:values[i-1] for i in subfield_positions}