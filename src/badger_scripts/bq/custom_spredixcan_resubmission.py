import os
import argparse
import re
import subprocess






def create_resubmission(file, file_re, args):
    """

    :param file_re:
    :param args:
    :return: job submission string
    """
    job_name = file_re.group(1) + '_' + file_re.group(2)
    job_file_name = job_name + '_parse_predixcan_resub.sh'
    print("Creating resubmission with job name " + job_file_name)
    with open(os.path.join(args.jobs_dir, job_file_name), 'w') as job_file:
        job_file.write(job_resub_template)
        job_file.write("#PBS -N {}_resub \n".format(job_name))
        job_file.write(column_add_path)
        job_file.write("-sep , \\\n")
        job_file.write("-fields phenotype tissue \\\n")
        job_file.write("-values {} {} \\\n".format(file_re.group(1), file_re.group(2)))
        job_file.write("-input_file {} \\\n".format(os.path.join(os.getcwd(), args.input_dir, file)))
        job_file.write("-output_file {}".format(os.path.join(os.getcwd(), args.converted_dir, file)))
    sub_command = "qsub {} \n sleep 0.1 \n".format(os.path.join(args.jobs_dir, job_file_name))

    return sub_command




def find_only_csv_files(args, csv_re):
    csv_file_lst = []
    for file in os.listdir(args.input_dir):
        if csv_re.search(file):
            csv_file_lst.append(file)
    return csv_file_lst


def run(args):
    csv_re = re.compile("(.*)\.csv")
    file_name_re = re.compile("(.*)-gtex_v8-(.*)-2018_10\.csv")
    unconverted_csv_files = find_only_csv_files(args, csv_re)
    with open('all_resub_jobs.sh', 'w') as job_resub_file:
        job_resub_file.write("#!/bin/bash\n")
        for file in unconverted_csv_files:
            if not os.path.isfile(os.path.join(args.converted_dir, file)):
                file_re = file_name_re.search(file)
                resub_command = create_resubmission(file, file_re, args)
                job_resub_file.write(resub_command)


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
#PBS -o {}/$PBS_JOBNAME.$PBS_JOBID.log
#PBS -e {}/$PBS_JOBNAME.$PBS_JOBID.err
""".format(args.logs_dir, args.logs_dir)
    column_add_path = """module load gcc/6.2.0
module load python/3.5.3
cd $PBS_O_WORKDIR
python3 /gpfs/data/im-lab/nas40t2/owen/gtex-miscellaneous-processing/src/badger_scripts/bq/column_add.py \\\n"""
    run(args)