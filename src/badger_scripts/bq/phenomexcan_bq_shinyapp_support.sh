#!/bin/bash
#PBS -N upload_fastenloc
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l mem=32gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_upload_ppfe/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_upload_ppfe/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0 python/2.7.13


########################################################################################################################
load_bq()
{
    # $1 table
    # $2 file
    # $3 schema
    bq --location=US load --source_format=CSV \
    --null_marker=NA  --skip_leading_rows=1 --field_delimiter "\t" \
    $1 \
    $2 \
    $3

}

load_bq_file()
{
echo "uploading"
gsutil -q -m cp  $1  $2
echo "bq"
load_bq $3 \
$2  \
$4
echo "cleaning up"
gsutil -q -m rm  $2
}

load_bq_f()
{
for f in $1/*
do
echo $f
load_bq \
$2 \
$f \
$3
done
}

load_bq_f_2()
{
echo "uploading"
gsutil -q -m cp -r $1  $2
echo "bq"
load_bq $3 \
"$2/*"  \
$4
echo "cleaning up"
gsutil -q -m rm -r $2
}

###############################################################################

echo "Loading smultixcan pairs"
load_bq_file \
/gpfs/data/im-lab/nas40t2/miltondp/phenomexcan/shiny/smultixcan_vs_clinvar-z2_avg-mashr.tsv.gz \
gs://tempo-imlab/upload-bigquery/tmp/phenomexcan/shiny/smultixcan_vs_clinvar-z2_avg-mashr.tsv.gz \
gtex-awg-im:GTEx_V8_UKB_PhenomeXcan.smultixcan_mashr_pairs_eqtl_v1 \
ukb_trait:STRING,clinvar_trait:STRING,z2_avg:FLOAT,sqrt_z2_avg:FLOAT,gene_ids:STRING,gene_names:STRING

#echo "Loading gene annot"
#load_bq_file \
#/gpfs/data/im-lab/nas40t2/miltondp/phenomexcan/shiny/genes_mappings.tsv.gz \
#gs://tempo-imlab/upload-bigquery/tmp/phenomexcan/shiny/genes_mappings.tsv.gz \
#gtex-awg-im:GTEx_V8_UKB_PhenomeXcan.genes_metadata \
#gene:STRING,genename:STRING,gene_id:STRING,band:STRING

#echo "Loading fast enloc"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/spredixcan/phenomexan/eqtl \
#gs://tempo-imlab/upload-bigquery/tmp/spredixcan/phenomexan/eqtl \
#gtex-awg-im:GTEx_V8_UKB_PhenomeXcan.spredixcan_eqtl \
#gene:STRING,gene_name:STRING,zscore:FLOAT,effect_size:FLOAT,pvalue:FLOAT,var_g:FLOAT,pred_perf_r2:FLOAT,pred_perf_pval:FLOAT,pred_perf_qval:FLOAT,n_snps_used:INTEGER,n_snps_in_cov:INTEGER,n_snps_in_model:INTEGER,best_gwas_p:FLOAT,largest_weight:FLOAT,trait:STRING,tissue:STRING

#echo "Loading sme"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/shiny/sme \
#gs://tempo-imlab/upload-bigquery/tmp/shiny/sme \
#gtex-awg-im:GTEx_V8_UKB_PhenomeXcan.sme_eqtl_v1 \
#gene:STRING,gene_name:STRING,pvalue:FLOAT,n:INTEGER,n_indep:INTEGER,p_i_best:FLOAT,t_i_best:STRING,p_i_worst:FLOAT,t_i_worst:STRING,status:INTEGER,phenotype:STRING,rcp:FLOAT,key:STRING

#echo "Loading smepg"
#load_bq_f_2 \
#/scratch/abarbeira3/v8_process/bq/shiny/smepg \
#gs://tempo-imlab/upload-bigquery/tmp/shiny/smepg \
#gtex-awg-im:GTEx_V8_UKB_PhenomeXcan.sme_eqtl_v1 \
#gene:STRING,gene_name:STRING,pvalue:FLOAT,n:INTEGER,n_indep:INTEGER,p_i_best:FLOAT,t_i_best:STRING,p_i_worst:FLOAT,t_i_worst:STRING,status:INTEGER,phenotype:STRING,rcp:FLOAT,key:STRING
