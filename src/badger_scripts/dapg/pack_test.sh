#!/bin/bash

for filename in `ls results/collapsed_dapg_maf0.01_w1000000`; do
  #echo $filename
  tar -czvpf "$filename".tar.gz "results/collapsed_dapg_maf0.01_w1000000/$filename"
done