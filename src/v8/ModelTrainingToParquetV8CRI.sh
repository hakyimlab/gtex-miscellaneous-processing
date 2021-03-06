#!/bin/bash
#PBS -N job_ModelTrainingToParquet_V8_EUR
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=96:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=512gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR
module load gcc/6.2.0
module load python/3.5.3
#module load miniconda3
#source activate numa_cri

#IGF=/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gtex_vcf_processing/gtex_v8_eur_filtered.txt.gz
#IAF=/group/im-lab/nas40t2/abarbeira/data/GTEx/v8/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz
IGF=/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered.txt.gz
IAF=/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered_maf0.01_monoallelic_variants.txt.gz
OF=results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/model_training_genotype_to_parquet.py \
-input_genotype_file $IGF \
-snp_annotation_file $IAF METADATA \
-parsimony 9 \
--impute_to_mean \
--split_by_chromosome \
--only_in_key \
-output_prefix $OF

#--biallelic_only \
#--filter_maf 0.01 \