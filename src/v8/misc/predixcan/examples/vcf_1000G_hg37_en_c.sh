#!/usr/bin/env bash
#PBS -N predixcan_vcfhg37_en
#PBS -S /bin/bash
#PBS -l walltime=32:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_new_predixcan/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_new_predixcan/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0 python/3.5.3

#Change the following  paths to the ones on your computing environment (i.e. where you downloaded code and data)
#export METAXCAN=/gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software
#export DATA=data
#export RESULTS=results
#mkdir $RESULTS

#cd $PBS_O_WORKDIR


printf "Predict expression\n\n"
python3 $METAXCAN/Predict.py \
--model_db_path $DATA/models/gtex_v8_en/en_Whole_Blood.db \
--vcf_genotypes $DATA/1000G_hg37/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--vcf_mode genotyped \
--prediction_output $RESULTS/vcf_1000G_hg37_en_c/Whole_Blood__predict.h5 HDF5 \
--prediction_summary_output $RESULTS/vcf_1000G_hg37_en_c/Whole_Blood__summary.txt \
--verbosity 9 \
--throw

printf "association\n\n"
python3 $METAXCAN/PrediXcanAssociation.py \
--hdf5_expression_file $RESULTS/vcf_1000G_hg37_en_c/Whole_Blood__predict.h5 \
--input_phenos_file $DATA/1000G_hg37/random_pheno_1000G_hg37.txt \
--input_phenos_column pheno \
--output $RESULTS/vcf_1000G_hg37_en_c/Whole_Blood__association.txt \
--verbosity 9 \
--throw