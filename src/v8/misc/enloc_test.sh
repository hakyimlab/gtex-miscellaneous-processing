#!/bin/bash
#PBS -N {{job_name}}
#PBS -S /bin/bash
#PBS -l walltime={{job_walltime}}
#PBS -l mem={{job_memory}}
#PBS -l nodes=1:ppn=1

#PBS -o {{logs_folder}}/{% raw %}${PBS_JOBNAME}.o${PBS_JOBID}.log{% endraw %}
#PBS -e {{logs_folder}}/{% raw %}${PBS_JOBNAME}.e${PBS_JOBID}.err{% endraw %}

#cd $PBS_O_WORKDIR

module load gcc/6.2.0
module load gsl/2.3
module load boost/1.61.0
module load bzip2/1.0.6
module load python/3.5.3
module load perl/5.24.0

## executable options

create_config()
{
printf "bin_dir\tbin/\n" > $1
printf "gwas_data\t/scratch/abarbeira3/v8_process/slice/results/sliced_CARDIoGRAM_C4D_CAD_ADDITIVE.txt.gz\n" >> $1
printf "qtl_fm_dir\t/scratch/abarbeira3/v8_process/dapg/results/collapsed_dapg_maf0.01_w1000000/Brain_Cortex/\n" >> $1
printf "out_dir\tCARDIoGRAM_C4D_CAD_ADDITIVE__PM__Brain_Cortex\n" >> $1
printf "trait\tCARDIoGRAM_C4D_CAD_ADDITIVE\n" >> $1
# bypass_enrichment_analysis 1
printf "use_openmp\t0\n" >> $1
}

create_config kk.enloc.params
#bin_dir       bin/
#
### input data directories
#gwas_data    /scratch/abarbeira3/v8_process/slice/results/sliced_CARDIoGRAM_C4D_CAD_ADDITIVE.txt.gz
#qtl_fm_dir   /scratch/abarbeira3/v8_process/dapg/results/collapsed_dapg_maf0.01_w1000000/Brain_Cortex/
#
#
### output and working directory
#out_dir       CARDIoGRAM_C4D_CAD_ADDITIVE__PM__Brain_Cortex
#
#
### Analysis characterization
#trait         CARDIoGRAM_C4D_CAD_ADDITIVE
#
### Optional parameters
#
## bypass_enrichment_analysis 1
#use_openmp    0