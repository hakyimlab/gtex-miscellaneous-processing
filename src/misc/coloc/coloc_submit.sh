#!/usr/bin/env bash

#
#qsub coloc_gz_ez.sh
#sleep 0.1
#qsub coloc_gz_ebse.sh
#sleep 0.1
#qsub coloc_gbse_ebse.sh
#sleep 0.1
#qsub coloc_gbse_ez.sh
#sleep 0.1
#qsub coloc_gp_ebse.sh
#sleep 0.1
for f in coloc_g*sh; do
  qsub $f
  sleep 0.1
done