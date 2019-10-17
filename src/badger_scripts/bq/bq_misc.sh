#!/usr/bin/env bash

module load gcc/6.2.0 python/2.7.13



########################################################################################################################
load_bq()
{
    # $1 table
    # $2 file
    # $3 tmp storage
    # $4 schema
    echo "uploading"
    gsutil -q -m cp -r $2  $3
    echo "bqc"
    bq --location=US load --source_format=CSV \
    --null_marker=NA  --skip_leading_rows=1 --field_delimiter "\t" \
    $1 \
    $3 \
    $4

    echo "cleaning up"
    gsutil -q -m rm -r $3

}

load_bq \
gtex-awg-im:annotations.intron_gene_map \
/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/intron_gene_map.txt.gz \
gs://tempo-imlab/upload-bigquery/data/intron_gene_map.txt.gz \
intron_id:STRING,gene_id:STRING,chr:INTEGER,start_location:INTEGER,end_location:INTEGER