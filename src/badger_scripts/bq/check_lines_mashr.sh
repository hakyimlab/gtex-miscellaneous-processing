#!/usr/bin/env bash

find models/expression/mashr/extra  -name "*.txt" | xargs wc -l > count_mashr_models_eqtl_extra.txt
find models/expression/mashr/weights  -name "*.txt" | xargs wc -l > count_mashr_models_eqtl_weights.txt

find models/splicing/mashr/extra  -name "*.txt" | xargs wc -l > count_mashr_models_sqtl_extra.txt
find models/splicing/mashr/weights -name "*.txt" | xargs wc -l > count_mashr_models_sqtl_mashr_weights.txt

find predixcan/eqtl/mashr  -name "*.csv" | xargs wc -l > count_mashr_spredixcan_eqtl_mashr.txt
find predixcan/sqtl/mashr  -name "*.csv" | xargs wc -l > count_mashr_spredixcan_sqtl_mashr.txt

find smultixcan/eqtl/mashr  -name "*.txt" | xargs wc -l > count_mashr_smultixcan_eqtl_mashr.txt
find smultixcan/sqtl/mashr  -name "*.txt" | xargs wc -l > count_mashr_smultixcan_sqtl_mashr.txt
