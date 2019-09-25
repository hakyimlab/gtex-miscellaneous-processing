import os
import argparse
import re
import subprocess
import time





def create_resubmission(file, file_re, args):
    """
    :param file_re: regular expression match object created by applying an RE pattern to filenames in the input_dir
    :param args: parsed command line args
    :return: job submission string
    """
    job_name = file_re.group(1) + '_' + file_re.group(2)
    job_file_name = job_name + '_parse_spredixcan.sh'
    job_file_path = os.path.join(args.jobs_dir, job_file_name)
    print("Need a new submission for " + job_file_name)
    if not os.path.isfile(job_file_path):
        print("Writing new job file at " + job_file_name)
        with open(job_file_path, 'w') as job_file:
            job_file.write(job_resub_template)
            job_file.write("#PBS -N {}_resub \n".format(job_name))
            job_file.write(column_add_path)
            job_file.write("-sep , \\\n")
            job_file.write("-fields phenotype tissue \\\n")
            job_file.write("-values {} {} \\\n".format(file_re.group(1), file_re.group(2)))
            job_file.write("-input_file {} \\\n".format(os.path.join(os.getcwd(), args.input_dir, file)))
            job_file.write("-output_file {}".format(os.path.join(os.getcwd(), args.converted_dir, file)))
    sub_command = "qsub {}".format(os.path.join(args.jobs_dir, job_file_name))

    return sub_command




def find_only_csv_files(args, csv_re):
    """
    :param args: parsed command line args
    :param csv_re: regular expression object which has a stored pattern to match with file names with .csv extensions
    :return: a list of strings
    """
    csv_file_lst = []
    for file in os.listdir(args.input_dir):
        if csv_re.search(file):
            csv_file_lst.append(file)
    return csv_file_lst


def run(args):
    """
    This was thrown together to resubmit jobs when parsing the logs with Badger was impossible because of missing logs
    with completed jobs and job submission names which were not amenable to parsing. This function parses file names in
    input and converted directories, and it resubmits jobs attached to those files which are missing.
    :param args: parsed command line arguments
    :return:
    """
    csv_re = re.compile("(.*)\.csv")
    file_name_re = re.compile("(.*)-gtex_v8-(.*)-2018_10\.csv")
    unconverted_csv_files = find_only_csv_files(args, csv_re)
    for file in unconverted_csv_files:
        if not os.path.isfile(os.path.join(args.converted_dir, file)):
            file_re = file_name_re.search(file)
            resub_command = create_resubmission(file, file_re, args)
            subprocess.call(resub_command.split())
            time.sleep(0.1)



if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-input_dir')
    parser.add_argument('-converted_dir')
    parser.add_argument('-jobs_dir')
    parser.add_argument('-logs_dir')
    args = parser.parse_args()

    job_resub_template = """#!/bin/bash
#PBS -S /bin/bash
#PBS -l walltime=0:10:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=1gb
#PBS - q express
#PBS -o {}/$PBS_JOBNAME.o$PBS_JOBID.log
#PBS -e {}/$PBS_JOBNAME.e$PBS_JOBID.err
""".format(args.logs_dir, args.logs_dir)
    column_add_path = """module load gcc/6.2.0
module load python/3.5.3
cd $PBS_O_WORKDIR
python3 /gpfs/data/im-lab/nas40t2/owen/gtex-miscellaneous-processing/src/badger_scripts/bq/column_add.py \\\n"""
    run(args)