#!/bin/bash
#PBS -N gwas_parsing_ukb_sample
#PBS -S /bin/bash
#PBS -l walltime=1:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_kk/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_kk/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/3.5.3

cd $PBS_O_WORKDIR 

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/gwas_parsing.py \
-gwas_file /gpfs/data/im-lab/for_meri/20111_5.gwas.imputed_v3.male.v2.tsv.gz \
-split_column variant ':' chromosome position non_effect_allele effect_allele  rsid variant_id -output_column_map EA effect_allele -output_column_map NEA non_effect_allele -output_column_map beta effect_size -output_column_map se standard_error -output_column_map nCompleteSamples sample_size -output_column_map chr chromosome --chromosome_format -output_column_map position position \
-output_order variant_id panel_variant_id chromosome position effect_allele non_effect_allele frequency pvalue zscore effect_size standard_error sample_size n_cases \
-liftover /gpfs/data/im-lab/nas40t2/abarbeira/data/liftover/hg19ToHg38.over.chain.gz \
-snp_reference_metadata /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/vcf_process/gtex_v8_eur_filtered_maf0.01_monoallelic_variants.txt.gz METADATA \
-output results_gwas_ukbn/sample.txt.gz


d <- d %>% mutate(chr = gsub("(.*):(.*):(.*):(.*)", "\\1", variant)) %>%
    mutate(pos = gsub("(.*):(.*):(.*):(.*)", "\\2", variant)) %>%
    mutate(ea = gsub("(.*):(.*):(.*):(.*)", "\\3", variant)) %>%
    mutate(nea = gsub("(.*):(.*):(.*):(.*)", "\\4", variant))