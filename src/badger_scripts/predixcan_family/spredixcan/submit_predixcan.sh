#!/usr/bin/env bash

echo "*******"
echo "Modules"
echo "*******"

module load gcc/6.2.0
module load python/3.5.3

SUBMIT(){
    python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/badger/badger.py -yaml_configuration_file $1 -parsimony 9
}

echo "**"
echo "EN"
echo "**"

SUBMIT metaxcan_imputed_gtexv8_en.yaml
SUBMIT metaxcan_imputed_gtexv7_en.yaml
SUBMIT metaxcan_imputed_gtexv6p_en.yaml

echo "***********"
echo "Conditional"
echo "***********"

SUBMIT metaxcan_imputed_gwas_conditional_gtex_primary.yaml
SUBMIT metaxcan_imputed_gwas_conditional_gtex_secondary.yaml
SUBMIT metaxcan_imputed_gwas_conditional_gtex_tertiary.yaml

echo "********"
echo "MARGINAL"
echo "********"

SUBMIT metaxcan_imputed_gwas_conditional_marginal_gtex_primary.yaml
SUBMIT metaxcan_imputed_gwas_conditional_marginal_gtex_secondary.yaml
SUBMIT metaxcan_imputed_gwas_conditional_marginal_gtex_tertiary.yaml

echo "****"
echo "DAPG"
echo "****"

SUBMIT metaxcan_imputed_gwas_dapg_gtex_primary.yaml
SUBMIT metaxcan_imputed_gwas_dapg_gtex_secondary.yaml
SUBMIT metaxcan_imputed_gwas_dapg_gtex_tertiary.yaml