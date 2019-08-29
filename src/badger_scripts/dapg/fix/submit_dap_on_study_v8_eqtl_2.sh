#!/usr/bin/env bash

module load gcc/6.2.0 python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/badger/src/badger.py \
-yaml_configuration_file dap_on_study_v8_eqtl_2.yaml \
-parsimony 9