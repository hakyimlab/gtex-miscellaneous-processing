# !/usr/bin/env bash

module laod gcc/6.2.0 miniconda2/4.4.10
#conda activate
#conda activate py3

conda create -n py3 python=3.7
source activate py3
conda install statsmodels
conda install -c anaconda ipython -y
conda install -c conda-forge bgen -y