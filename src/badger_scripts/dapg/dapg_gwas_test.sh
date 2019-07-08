#!/bin/bash
#PBS -N Whole_Blood_chr1_0_gtexv8_dapg_sqtl
#PBS -S /bin/bash
#PBS -l walltime=16:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_dap/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_dap/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load gsl/2.3
module load boost/1.61.0
module load bzip2/1.0.6
module load python/3.5.3

cd $PBS_O_WORKDIR 

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/dap_on_summary_stats.py \
-dap_command /gpfs/data/im-lab/nas40t2/abarbeira/software/dap/dap_src/dap-g \
-frequency_filter 0.01 \
-options ld_control 0.75 \
-sub_batches 40 \
-sub_batch 0 \
-parquet_genotype /scratch/abarbeira3/data/parquet/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.chr1.variants.parquet \
-parquet_genotype_metadata /scratch/abarbeira3/data/parquet/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.variants_metadata.parquet \
-summary_stats /scratch/abarbeira3/v8_process/slice/results_gtex_format/sliced_ADIPOGen_Adiponectin.txt.gz \
-intermediate_folder scratch_dapg/Whole_Blood_1_0 \
-parsimony 8  \
-output_folder results/dapg_maf0.01_w1000000/Whole_Blood_chr1_0
