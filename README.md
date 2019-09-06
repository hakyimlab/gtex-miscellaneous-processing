# Introduction

This repository contains scripts to process GTEx data.
Since these scripts were run in UCHicago's HPC Gardner cluster (CRI), it contains paths in that filesystem.

Subfolders may contain in-detail Readmes. An overview of each of those will be progressively added here.

There is a wide variety of scripts, written in bash, python, R and a few more tools. There is a heavy dependency on 
[Badger](https://github.com/hakyimlab/badger) job submission (an overview is given below in this readme).

# Layout

The folder `src/badger_scripts` contains different processing schemes centered around badger scripts (but also contain other kinds of scripts).

The other folders may contain miscellaneous processing and verifications, most of them needed for one-shot analysis or data exploration.

## job management


## Processing genotypes

GTEx genotypes are obtained in vcf format. A combination of samtools, awk and python is used to convert and process them.

`src/vcf_processing/filter_shapeit_vcf_disk_efficient.sh` is a script that preprocesses GTEx data, filtering for specific individuals.

`src/vcf_processing/vcf_to_pred_format.sh` converts the output from the previous script  into PredictDBPipeline genotype formats.

These can be taken as a starting point to extract GTEx data into convenient text files.

## Geuvadis

`src/geuvadis` contains GEUVADIS data parsing. The outputs are mostly used for predicting expression in GEUVADIS data, and comparing said predictions with GEUVADIS measured expression.
`src/geuvadis/1000G_geuv_eur_conversion.sh` is another example of parsing a vcf file (1000G in hg38)


## Badger-based workflows

Most GTEx data processing involving job submission was handled via [Badger] (https://github.com/hakyimlab/badger). 
Badger aids the creation of families of jobs (executable programs meant to be run in an HPC cluster).
Badger scripts specify and define mappings from possible parameter configurations to actual job execution (i.e. instances of a program execution with a full complement of command-line parameters).
Most scripts were defined for runing in CRI and its PBS queue, but a few were meant for a SLURM queue on google cloud.

These scripts share a common behavior and consequences in CRI Gardner cluster:

* Create a series of submission jobs, parametrized by different inputs (which can be fixed scalar variables such as a numeric threshold, or lists of files, etc).
* Submits them one at a time as they are generated. If any error occurs, submission stops.
* Executed jobs will be saved in a common folder. 
* Jobs are bash files with queue-specific parameters declaring resource consumption (i.e. memory consumed by each job), logging and output paths, etc. Each job is a particular instance with specific parameters from a possibly complex list of parameter configurations.

Many of these jobs were first run on a specific subset of job configurations, declaring overestimated resources (i.e. all jobs were sent with large declarations of memory and execution time).

After this first test run was completed, log output was parsed to extract actual memory consumption and time (CRI infrastructure appends resource consumption statistics to each job's output). 
These statistics where used to build a mapping of job configurations to specific resource consumption. Within a family of jobs, resources might vary enourmosly. 
Some jobs might fit in under a gigabyte, while others take up to 32 gb (in many GTEx-related processes, for example, Adipose tissue take more processing time than Ovary due to sample size, number of genes present, etc).

Frequently, the CRI cluster is under heavy pressure, or some nodes might malfunction. Scripts to check expected outputs and logs are provided, allowing an automated resubmission if needs be.

Badger supports two special submission modes: `fake_submission` that will generate all related jobs (bash files) but not submit them, and `crude_submission` that merely executes each job as a subprocess (one a ta a time)

Please make sure to understand the Badger example below before moving into any specific workflow. 

### Badger workflow Example

The following example shows a minimal badger workflow in CRI. 
It assumes:
* This gtex processing repository downloaded somewhere (`$PATH_TO_REPO` will represent the root of this repository).
* [Badger] (https://github.com/hakyimlab/badger) (`$PATH_TO_BADGER` will represent the root of this repository).
* [Genomic tools](git@github.com:hakyimlab/summary-gwas-imputation.git)

*Note:* Genomic tools is called `summary-gwas-imputation` for marketing reasons.

These jobs ae simple format conversions, taking in text files and compiling a Parquet file that allows fast and simple data loading.

1) Submit jobs:

```bash
#in my specific case, these were the paths to each repository
#export PATH_TO_BADGER=/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/badger 
#export PATH_TO_REPO=/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex 

mkdir test
cd test/
cp $PATH_TO_REPO/gtex/src/badger_scripts/example/model_training_v* .

module load gcc/6.2.0 python/3.5.3

python3 $PATH_TO_BADGER/src/badger.py \
-yaml_configuration_file model_training_v8_expression_to_parquet.yaml \
-parsimony 9

```
After submission finishes, you can watch the job execution with `watch qstat`.
These jobs will output logs in `logs` subfolder, and results in `results/expression` subfolder. Expected outputs are files named like `Whole_Blood.expression.parquet`
I simulated an error in one job (Uterus) by cancelling it manually. 

2) Check for errors and resubmit

There is a script that checks the logs and output, and resubmits failed jobs.
**DO NOT run the following command until your jobs finished!**

```bash
bash $PATH_TO_REPO/src/badger_scripts/example/check_log.sh
#output:
#INFO - Logs mark this for redo
#INFO - Cleaning model_training_expression_to_parquet_Uterus
#INFO - Cleaning target: logs/model_training_expression_to_parquet_Uterus*
#INFO - Cleaning file: logs/model_training_expression_to_parquet_Uterus.e16741824.cri16sc001.err
#INFO - Cleaning file: logs/model_training_expression_to_parquet_Uterus.o16741824.cri16sc001.log
#INFO - Cleaning target: results/expression/Uterus.expression.parquet
#INFO - Found nothing applicable to clean
#INFO - Resubmitting model_training_expression_to_parquet_Uterus
#16741825.cri16sc001
#INFO - Redid 1
```

What this means is that failed logs (and any partial output) will be deleted, and the job resubmitted. After waiting for it to complete,
we ran it again to see if anything else failed:

```bash
bash /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/badger_scripts/example/check_log.sh 
#INFO - Redid 0
```

*Option:* resubmitting is an optional parameter in  `check_log.sh`, as is cleaning leftovers from failed jobs.

3) Check execution statistcs

The following checks the logs to see memory and walltime consumption

```bash
bash $PATH_TO_REPO/src/badger_scripts/example/parse_wrapup.sh
```

This produces a file called `wrapup.txt` listing resources used by each job.

4) Refining resource consumption declaration

For the sake of this example, assume these jobs have to be executed more than once.

#### Closing words

Some jobs will be executed many times in the life of a research project. For example, [S-PrediXcan](https://github.com/hakyimlab/MetaXcan)
was ran several times because many of its input were regenerated aftyer issues or improvements were found.

Depending on the family of jobs and consumption patterns, you might want to adopt different strategies to make follow-up executions more efficient.
A pattern of resource consumption must be identified from the logs
 
For example, `DAP-G expression` execution divided processing by tissue, chromosome, and each chromosome split into 80 sub batches. 
I decided to group jobs by chromosome and sub batch, and take the largest memories and times across tissues. 
Then I created a spec with these numbers, following a simple rule of thumb:

* if the job is observed to run below 3.5gb, I declare it will consume 4gb
* if the job is observed below 7gb, I declare it will consume 8gb
* if the job is observed below 14gb, i declare it will consume 16gb
* otherwise, declare 32gb
* if the job declares 4gb and takes under 3:30:00 hours to complete, I declare 4:00:00
* otherwise, declare "72:00:00"

This stategy is motivated by CRI express queue (reserved for jobs under 4gb and under 4:00:00 hours). MOst jobs will fall in the expess queue,
allowing a faster overall execution, and the rest will consume conservative limits.



### BigQuery

There are several scripts to process and upload text files into google BigQuery.

See `src/badger_scripts/bq` for details.

For GWAS preprocessing, first convert to plain text files with phenotype column (`column_add_gwas.yaml`),
then convert mixed data columns (`n_samples`, `sample_size` that might have integers and floats depending on pandas whims),
then upload to big query

