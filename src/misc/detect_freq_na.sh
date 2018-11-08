#!/bin/bash

DETECT() {

for F in $1/*; do
    echo $F > /dev/stderr
    echo $F
    zcat $F | cut -f 12 | grep NA | wc
done

}


DETECT /group/im-lab/nas40t2/Data/SummaryResults/Formatted_GWAS_hg38 > kk.txt