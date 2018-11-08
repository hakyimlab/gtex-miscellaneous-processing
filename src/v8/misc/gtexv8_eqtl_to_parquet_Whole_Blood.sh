#!/bin/bash
#PBS -N gtexv8_eqtl_to_parquet_Whole_Blood
#PBS -S /bin/bash
#PBS -l walltime=8:00:00
#PBS -l mem=16gb
#PBS -l nodes=1:ppn=1

#PBS -o logs_eqtl/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_eqtl/${PBS_JOBNAME}.e${PBS_JOBID}.err

#module load gcc/6.2.0
#module load python/3.5.3
#
#cd $PBS_O_WORKDIR

python genomic_tools/gtex_association_conversion.py \
-snp_annotation /home/numa/Documents/Projects/data/GTEx/v8/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.lookup_table.txt.gz \
-gtex_eqtl_file /run/user/1000/gvfs/smb-share:server=bulkstorage.uchicago.edu,share=im-lab/nas40t2/Data/GTEx/V8/GTEx_Analysis_v8_eQTL_all_associations/Whole_Blood.allpairs.txt.gz \
-parquet_output results/eqtl/Whole_Blood.eqtl.parquet