#PBS -N collapse_dapg
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=4:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

module load gcc/6.2.0
module load python/3.5.3

cd $PBS_O_WORKDIR

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/genomic_tools/src/collapse_folder_files.py \
-rule "(.*)_chr*" \
-input_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/fix/dapg/dapg/results_eur \
-output_folder /gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/fix/dapg/dapg/collapsed_results_eur \
--reentrant \
-parsimony 8

#--exclude Muscle_Skeletal_chr6_9 \
#--move \
