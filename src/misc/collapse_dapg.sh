#PBS -N collapse_dapg
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/3.5.3

cd $PBS_O_WORKDIR

python3 /group/im-lab/nas40t2/abarbeira/software/genomic_tools/src/genomic_tools/collapse_folder_files.py \
-rule "(.*)_chr*" \
-input_folder /scratch/abarbeira3/v8_process/dapg/results/dapg_maf0.01_w1000000 \
-output_folder results/collapsed_dapg_maf0.01_w1000000 \
--reentrant \
--move \
-parsimony 8