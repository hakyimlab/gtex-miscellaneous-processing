#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

SUBMIT() {
python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/badger/badger.py -parsimony 9 -yaml_configuration_file $1
}


SUBMIT coloc_default.yaml
SUBMIT coloc_default_bse.yaml
#SUBMIT coloc_default_zbse.yaml

SUBMIT coloc_enloc_prior.yaml
SUBMIT coloc_enloc_prior_bse.yaml
#SUBMIT coloc_enloc_prior_zbse.yaml

