#! /usr/bin/env python

module load gcc/6.2.0 miniconda2/4.4.10
source activate py3


python /gpfs/data/im-lab/nas40t2/abarbeira/software/MetaXcan/software/MulTiXcan.py \
--expression_folder /scratch/abarbeira3/v8_process/predixcan/results/en \
--expression_pattern "predicted_(.*).txt" \
--input_phenos_file /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/random_pheno.txt \
--input_phenos_column pheno \
--pc_condition_number 30 \
--verbosity 9 \
--MAX_M 20 \
--output kk/en.txt