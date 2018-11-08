#!/usr/bin/env bash
# This is for v8. Who knows what the future has in tow for us.

I=/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=gtex-group/v8/57603/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_support_files/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_899Indiv_QC_TABLE.tsv
O=/run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/GTEx_ethnicity.txt

genomic_tools/slice_delim_file.py \
-input_file $I \
-output_file $O \
-columns SAMPLE_ID InferredRace

gtex/_samples_by_ethnicity.R
