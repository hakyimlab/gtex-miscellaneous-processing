#!/usr/bin/env bash
#PBS -N predixcan_vcfhg38_mashr
#PBS -S /bin/bash
#PBS -l walltime=32:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_new_predixcan/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_new_predixcan/${PBS_JOBNAME}.e${PBS_JOBID}.err

#Change the following  paths to the ones on your computing environment (i.e. where you downloaded code and data)
#export METAXCAN=/gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software
#export DATA=data
#export RESULTS=results
#mkdir $RESULTS

#cd $PBS_O_WORKDIR
#module load gcc/6.2.0 python/3.5.3


#printf "Predict expression\n\n"
python3 $METAXCAN/Predict.py \
--model_db_path $DATA/models/gtex_v8_mashr/mashr_Whole_Blood.db \
--model_db_snp_key varID \
--vcf_genotypes $DATA/1000G_hg38/ALL.chr22.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz \
--vcf_mode genotyped \
--on_the_fly_mapping METADATA "chr{}_{}_{}_{}_b38" \
--prediction_output $RESULTS/vcf_1000G_hg38_mashr/Whole_Blood__predict.txt \
--prediction_summary_output $RESULTS/vcf_1000G_hg38_mashr/Whole_Blood__summary.txt \
--verbosity 9 \
--throw

printf "association\n\n"
python3 $METAXCAN/PrediXcanAssociation.py \
--expression_file $RESULTS/vcf_1000G_hg38_mashr/Whole_Blood__predict.txt \
--input_phenos_file $DATA/1000G_hg38/random_pheno_1000G_hg38.txt \
--input_phenos_column pheno \
--output $RESULTS/vcf_1000G_hg38_mashr/Whole_Blood__association.txt \
--verbosity 9 \
--throw