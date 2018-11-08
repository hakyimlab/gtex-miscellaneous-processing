#PBS -N store_dapg
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

cd $PBS_O_WORKDIR

for f in *; do
    if [ -d $f ]; then
        tar -czvpf $f.tar.gz $f
    fi
done

O=/group/im-lab/nas40t2/abarbeira/projects/gtex_v8/dapg_eur_maf0.01_w1e6
[[ -d $O ]] || [[ mkdir -p $O ]]

mv *.tar.gz $O