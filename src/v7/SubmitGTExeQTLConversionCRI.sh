#!/usr/bin/env bash

GF=/group/im-lab/nas40t2/abarbeira/software/genomic_tools/src
D=/group/im-lab/nas40t2/Data/GTEx/V7

$GF/scripts/SubmitGTExeQTLConversion.py \
-tool $GF/genomic_tools/gtex_association_conversion.py \
-eqtl_folder $D/eqtl/GTEx_Analysis_v7_eQTL_all_associations \
-eqtl_regex  "(.*).allpairs.txt.gz" \
-snp_annotation $D/GTEx_Analysis_2016-01-15_v7_WholeGenomeSeq_635Ind_PASS_AB02_GQ20_HETX_MISS15_PLINKQC.lookup_table.txt.gz \
-output_folder results \
-jobs_folder jobs \
-logs_folder logs \
-verbosity 7 \
-email "mundoconspam@gmail.com"

#--fake_submit = False