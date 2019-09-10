#!/usr/bin/env bash


module load gcc/6.2.0
module load miniconda3/4.4.10

#conda create --name py2r python=2.7 r-essentials r-base
#source activate py2r
#conda install -c r r
#conda install -c r rpy2


conda create --name pyr python=3.5 r-essentials r-base -y
source activate pyr
conda install scipy numpy pandas -y
conda install -c r r rpy2 r-rcurl -y
conda install -c conda-forge pyarrow r-bigrquery r-workflowr r-cowplot -y
conda install -c bioconda pyliftover -y
conda install -c bioconda r-argparse -y
conda install -c bioconda bioconductor-biomart -y


#R
#install.packages("coloc")
#install.packages("dplyr")
#install.packages("ggplot2")