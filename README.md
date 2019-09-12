# Introduction

This repository contains scripts to process GTEx data.
Since these scripts were run in UCHicago's HPC Gardner cluster (CRI), it contains paths in that filesystem.

Subfolders may contain in-detail Readmes. An overview of each of those will be progressively added here.

There is a wide variety of scripts, written in bash, python, R and a few more tools. There is a heavy dependency on 
[Badger](https://github.com/hakyimlab/badger) job submission (an overview is given below in this readme).
The actual scripts run in most jobs are here: [genomic tools](https://github.com/hakyimlab/summary-gwas-imputation)

*Hint*: executing jobs with inputs and outputs in CRI's `/scratch` folder has a significant I/O gain.
 The downside is scratch is not backed up, and old files get erased.

# Layout

The folder `src/badger_scripts` contains different processing schemes centered around badger scripts (but also contain other kinds of scripts).

The other folders may contain miscellaneous processing and verifications, most of them needed for one-shot analysis or data exploration.

# Environment

CRI Gardner offers different software environments via lmod. 
Sometimes, when a tool I needed wasn't installed yet, I would use miniconda to create my own working environment to move forward while CRI staff performs installation.
There might be a few scripts that depended on a cnda environment I built, and users will not have it. They would have to create their own via:
`src/emergency_conda.sh`.

## job management

After submitting jobs, I typically use `watch qstat` for a while to see if the jobs start running successfully. Then I would run `watch 'qstat | wc'` to see how many jobs are on the queue. 
You can pipe `grep` for specific jobs. 

### Log examination

After the jobs have run, there is a script that can process logs and expected outputs to verify a job finished successfully. 
`src/misc/check_log.py` can parse log files for particular text, and presence of files or folders. See the following example:
```bash
#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 $PATH_TO_REPO/src/misc/check_log.py \
-jobs_folder jobs \
-logs_folder logs_dap \
-finish_token "Ran DAP in" \
--name_subfield_regexp "(.*)_chr(\d+)_(\d+)_gtexv8_dapg_eqtl" \
--name_subfield tissue 1 \
--name_subfield chromosome 2 \
--name_subfield sub_job 3 \
--check_product output "results/dapg/{tissue}_chr{chromosome}_{sub_job}" \
-output check_eqtl.txt
```

* `-jobs_folder` specifies are folder where the jobs are.
* `-jobs_pattern` specifies a regular expression to filter files in the `jobs` folder
* `-logs_folder` specifies are folder where the logs are.
* `-logs_pattern` specifies a regular expression to filter files in the `lobs` folder
* `-finish_token` A string to be searched in the log files: if found, the job will be reported as completed
* `--name_subfield_regexp` A regular expression to parse the job names. Groups can be used to extract subfields (e.g.: tissues, traits, etc written in the job file name)
* `--name_subfield` specifies a field name and group position in the previous argument. Can be specified multiple times.
* `--check_product` specifies a path that should be checked for presence. Can be specified multiple times. 
* `-output` a file were to store a report. The report will contain job names, status, subfields, and presence of products
* `--resubmit` optional. Whenever a job is marked as incomplete, or a product is missing, it will be resubmitted.
* `--clean_target` you can specify a path to a file or folder that needs to be deleted when resubmitting a job (this can be incomplete results, logs, etc)

### Job resource statistics

CRI appends a table detailing execution resources, looking like this:
```bash
------------ Job WrapUp ------------

Job ID:            16648309.cri16sc001
User ID:           abarbeira3
Job Name:          Adipose_Subcutaneous_chr1_0_gtexv8_dapg_eqtl
Queue Name:        express
Working Directory: /scratch/abarbeira3/v8_process/dapg/eqtl
Resource List:     walltime=04:00:00,mem=4gb,nodes=1:ppn=1,neednodes=1:ppn=1
Resources Used:    cput=00:08:30,vmem=3581328kb,walltime=00:08:33,mem=1582216kb,energy_used=0
Exit Code:         0
Mother Superior:   cri16cn002

Execution Nodes: 
cri16cn002
```
The `src/misc` script to parse these statistics into a nice table for further study and optimization. Example:
```bash
#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 $PATH_TO_REPO/src/misc/parse_wrapup.py \
-logs_folder /scratch/abarbeira3/v8_process/enloc/eqtl/logs_enloc \
-output enloc_wrapup.txt \
-name_subfield_regexp "(.*)__PM__(.*)_enloc_eqtl_gtexv8\.o(\d+)\.cri(.*)" \
-name_subfield trait 1 \
-name_subfield tissue 2
```

The interface is very similar to the previous section.

* `-logs_folder` specifies a folder with logs
* `-output` where the report will be saved
* `-name_subfield_regexp`: a regular expression to parse log files
* `-name_subfield`: a mapping from regular expression group number to nfield name

And you get a report like this:
```bash
cat enloc_wrapup.txt  | head | cut -f2-7
memory          v_memory        walltime    cputime trait                                                       tissue 
5629.07421875   5699.375        12535       12178   SSGAC_Depressive_Symptoms                                   Adrenal_Gland
5629.04296875   5707.8984375    11370       11215   UKB_6152_5_diagnosed_by_doctor_Blood_clot_in_the_leg_DVT    Skin_Sun_Exposed_Lower_leg
3945.99609375   4045.5390625    11323       10806   UKB_6152_8_diagnosed_by_doctor_Asthma                       Skin_Not_Sun_Exposed_Suprapubic
4237.3671875    4307.5703125    10580       10351   MAGIC_FastingGlucose                                        Small_Intestine_Terminal_Ileum
```

This information can be used to optimize subsequent runs. 
You can look at `badger_scripts/enloc/build_enloc_eqtl_spec.py` for an example on how to create per-tissue run requirements. 

## Processing genotypes

GTEx genotypes are obtained in vcf format. A combination of samtools, awk and python is used to convert and process them.

`src/vcf_processing/filter_shapeit_vcf_disk_efficient.sh` is a script that preprocesses GTEx data, filtering for specific individuals.

`src/vcf_processing/vcf_to_pred_format.sh` converts the output from the previous script  into PredictDBPipeline genotype formats.

These can be taken as a starting point to extract GTEx data into convenient text files.

They can be converted to Parquet columnar databases for fast access using `src/v8/ModelTrainingToParquetV8CRI.sh`

## Geuvadis

`src/geuvadis` contains GEUVADIS data parsing. The outputs are mostly used for predicting expression in GEUVADIS data, and comparing said predictions with GEUVADIS measured expression.
`src/geuvadis/1000G_geuv_eur_conversion.sh` is another example of parsing a vcf file (1000G in hg38)


## Badger-based workflows

Most GTEx data processing involving job submission was handled via [Badger] (https://github.com/hakyimlab/badger). 
Badger aids the creation of families of jobs (executable programs meant to be run in an HPC cluster).
Badger scripts specify and define mappings from possible parameter configurations to actual job execution (i.e. instances of a program execution with a full complement of command-line parameters). It is a mapping of points in a parameter space to jobs that will be submitted to an HPC Queue.
Badger scripts consist at the bare minimum of a job template (`.jinja`) and a configuration master definition (`.yaml`); possibly additional yaml files with subconfigurations might be used. 
YAML is a format for specifying arbitraily complex structured data in a human readable format; you can specify lists of values, amppings, and we defined special arguments to handle common paarmeters such as lists of files in folders.
Most scripts were defined for runing in CRI and its PBS queue, but a few were meant for a SLURM queue on google cloud.

Even if a badger script is meant to generate a vast list of jobs, you can generate specidifc subsets using whitelists (i.e. run only for specific tissue-trat combinations, or only for one chromosome)

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
Each set of scripts were mostly meant to be copied over to an `execution folder`(i.e. copy badger scripts to a folder in scratch) so that each run can be managed separately. 

### Badger workflow Example

The following example shows a minimal badger workflow in CRI. 
It assumes:
* This gtex processing repository downloaded somewhere (`$PATH_TO_REPO` will represent the root of this repository).
* [Badger] (https://github.com/hakyimlab/badger) (`$PATH_TO_BADGER` will represent the root of this repository).
* [Genomic tools](git@github.com:hakyimlab/summary-gwas-imputation.git) accesible at `/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools`. 
If you downloaded it somewhere else, modify the `.yaml` files accordingly.

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
By running `python3 src/badger_scripts/example/build_spec.py`, you will get a subconfiguration file describing resource consumption per job.
In this case, it will give you a specification of memory and walltime per tissue (in this toy example, it is likely they will all have the actual same numbers sine they ar very small jobs) 

#### Example closing words

Some jobs will be executed many times in the life of a research project. For example, [S-PrediXcan](https://github.com/hakyimlab/MetaXcan)
was ran several times because many of its input were regenerated after issues or improvements were found.

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


## Some available badger workflows

**BigQuery**: There are several scripts to process and upload text files into google BigQuery. See `src/badger_scripts/bq` for details.

**torus** (`src/badger_scripts/torus`), **DAPG** (`src/badger_scripts/dapg`), **ENLOC** (`src/badger_scripts/enloc`): 
these are closely related (in order of dependency: torus is needed for DAPG, DAPG is needed for enloc). [DAP](https://github.com/xqwen/dap) and [enloc](https://github.com/xqwen/integrative)
must be built beforehand.

**coloc** (`src/badger_scripts/coloc`) contains scripts to run R's vanilla coloc method with different possible arguments.

**formatting** (`src/badger_scripts/formatting`) converts [PredictDBPipeline](https://github.com/hakyimlab/PredictDB_Pipeline_GTEx_v7) variables (expression, covariates, etc) into parquet files for fast access.

**gwas_parsing** (`src/badger_scripts/gwas_parsing`) containst two types of jobs: converting GWAS summary statistics into a homogeneous format in hg38 human genome release, or slicing GWAS by ld-region.
 **gwas_imputation** (`src/badger_scripts/gwas_parsing`) uses as inputs the parsed GWAS from **gwas_parsing** 

**model_training** (`src/badger_scripts/model_training`) contains badger scripts to train different expression prediction models (for PrediXcan and S-PrediXcan). 
There is also `regress_eqtl.yaml`, that will regress covariates out of expression traits. This precomputed correction was performed because the crude covariate correction was used in many analysis.
To build S-MultiXcan covariance, check `src/v8/misc/GTExV8ExpressionCovarianceBuilder.sh` and `src/v8/misc/GTExV8SplicingCovarianceBuilder.sh`.

**model_training_ctimp** (`src/badger_scripts/model_training_ctimp`) covers submission of CTIMP (utmost) models.

**syntethic_model**
 
**models_from_gene_snp** (`src/badger_scripts/models_from_gene_snp`) take lists of genes and snps and converts them to model training output. (i.e. top eqtl models)

**postprocess_model** (`src/badger_scripts/postprocess_model`) serves all `model_*` workflows: it takes their output and compiles dbs and covariances.

**synthetic_models** (`src/badger_scripts/synthetic_models`) This takes files deailing genes and variant effect sizes and converts them to preduiction models. This was used for MASHR models.

**twas_builder** takes the bayesian model average from DAPG and builds Predixcan-like prediction models.

**predixcan_family** (`src/badger_scripts/predixcan_family`) covers execution of S-PrediXcan and S-MultiXcan on different GWAS and transcriptomics prediction models.

**splicing** (`src/badger_scripts/splicing`) has miscellaneous parsing and conversion of Splicing summary stats. **split** (`src/badger_scripts/split`) splits large text files by gene.

**susier** (`src/badger_scripts/susier`) automates execution of susie-R finemapping. Its environment was built va conda. susier package got updated since this was run, so watch for issues.

Some of this workflows have specific Readmes with additional details (model training, torus/dapg/enloc, predixcan, gwas parsing)

## Miscellaneous scripts

`src/v8/misc` contains several miscellaneous scripts where you can fish useful commands. `upload_*` are concerned mostly with uploading files to google cloud.

`src/v8/misc/compute_ld_in_region.sh` creates covariances fpr Berisa-Pickrell LD-regions.