#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

#python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/concat_results.py \
#-input_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/spredixcan/results/sp_imputed_gwas_gtexv8_en_splicing \
#-output_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/spredixcan/results/sp_imputed_gwas_gtexv8_en_splicing.csv.gz \
#-sep , \
#-pattern "spredixcan_igwas_gtexenv8_splicing_(.*)__PM__(.*).csv" trait tissue

#python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/concat_results.py \
#-input_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/smultixcan/results/smp_v8_splicing/ \
#-output_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/smultixcan/results/smp_v8_splicing.txt.gz \
#-pattern "smultixcan_imputed_gwas_gtexelv8_splicing_(.*)_ccn30.txt" trait

module unload python/3.5.3
module load python/2.7.13

echo "predixcan"



gsutil cp -a public-read \
/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/smultixcan/results/smp_v8_splicing.txt.gz  \
gs://predixcan/smp_v8_splicing.txt.gz

bq --location=US load --source_format=CSV \
--null_marker=NA  --skip_leading_rows=1 --field_delimiter "\t" \
gtex-awg-im:GTEX_V8_ElasticNet_EUR_Splicing_2018_11_19.multixcan_results \
gs://predixcan/smp_v8_splicing.txt \
gene:STRING,gene_name:STRING,pvalue:FLOAT,n:INTEGER,n_indep:INTEGER,p_i_best:FLOAT,t_i_best:STRING,p_i_worst:FLOAT,t_i_worst:STRING,eigen_max:FLOAT,eigen_min:FLOAT,eigen_min_kept:FLOAT,z_min:FLOAT,z_max:FLOAT,z_mean:FLOAT,z_sd:FLOAT,tmi:FLOAT,status:STRING,trait:STRING
