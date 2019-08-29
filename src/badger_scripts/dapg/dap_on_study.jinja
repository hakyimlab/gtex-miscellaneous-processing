#!/bin/bash
#PBS -N {{job_name}}
#PBS -S /bin/bash
#PBS -l walltime={{job_walltime}}
#PBS -l mem={{job_memory}}
#PBS -l nodes=1:ppn=1

#PBS -o {{logs_folder}}/{% raw %}${PBS_JOBNAME}.o${PBS_JOBID}.log{% endraw %}
#PBS -e {{logs_folder}}/{% raw %}${PBS_JOBNAME}.e${PBS_JOBID}.err{% endraw %}

module load gcc/6.2.0
module load gsl/2.3
module load boost/1.61.0
module load bzip2/1.0.6
module load python/3.5.3

umask 007

{% raw %}cd $PBS_O_WORKDIR {% endraw %}

{{ command }} \
{{ dap_command }} \
{{ frequency_filter }} \
{{ options }} \
{{ chromosome }} \
{{ sub_batches }} \
{{ sub_batch }} \
{{ grid }} \
{{ gene_annotation}} \
{{ genotype }} \
{{ genotype_metadata }} \
{{ phenotype }} \
{{ covariate }} \
{{ priors_folder }} \
{{ intermediate_folder }} \
{{ window }} \
{{ stats_name }} \
{% if parsimony %}{{ parsimony }} {% endif%} \
{{ output }}

