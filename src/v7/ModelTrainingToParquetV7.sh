#!/bin/bash
#PBS -N job_ModelTrainingToParquet_V7_EUR
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=64gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR
module load gcc/6.2.0
module load miniconda3
source activate numa_cri

IF=/group/im-lab/nas40t2/scott/gtex_v7_imputed_europeans/prepare_data
IFD="$IF/genotype"
IFA="$IFD/gtex_v7_hapmapceu_dbsnp150_snp_annot.txt"
IFP="$IF/expression"
IFPD="(.*)_donors.txt"
IFPE="(.*)_Analysis.expression.txt"
OF=results
OFP="$OF/gtex_v7_eur_hapmapceu"

python /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/model_training_to_parquet.py \
-input_genotype_folder $IFD \
-input_genotype_file_pattern "gtex_v7_eur_imputed_maf_0.01_R2_0.8_chr.*.txt.gz" \
-snp_annotation_file $IFA \
-input_phenotype_folder $IFP \
-input_phenotype_expression_pattern $IFPE \
-verbosity 9 \
-output_prefix $OFP
