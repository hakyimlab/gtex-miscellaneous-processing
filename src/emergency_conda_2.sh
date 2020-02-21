#!/usr/bin/env bash


module load gcc/6.2.0
module load miniconda3/4.4.10

conda create --name py2 python=2.7 -y
source activate py2
conda install scipy numpy pandas ipython -y
conda install patsy statsmodels h5py -y
conda install -c moble h5py_cache -y
conda install -c conda-forge pandas-plink


