#  -*- sh -*-
#$ -S /bin/bash
##$ -q res.q
#$ -cwd
#$ -V
#$ -j y
#$ -l h_rt=7:50:00
#$ -N enloc.prior
set -x

## usage: qsub -t 1 -p -10 Run_enloc_get.priors.sh Whole_Blood # t runs 1-114

module load R/3.4.1

i=$SGE_TASK_ID

tissue=$1
ppath=/gpfs/commons/groups/lappalainen_lab/skim/gtex_eqtl/v8/gwas/WW_enlocresults/${tissue}
abbr=`cat /gpfs/commons/groups/lappalainen_lab/skim/coloc/gtex_v8/v8_114traits/gwas_114traits_summary.txt | cut -f 1 | tail -n +2 | sed -n ''$i'p'`
est=${ppath}/${abbr}_${tissue}_enloc/${abbr}_${tissue}.enrich.est
qtlpip=${ppath}/eqtl.avg.pip
trait=`cat /gpfs/commons/groups/lappalainen_lab/skim/coloc/gtex_v8/v8_114traits/gwas_114traits_summary.txt | cut -f 2 | tail -n +2 | sed -n ''$i'p'`

Rscript Run_enloc_get.priors.R ${ppath} ${abbr} ${tissue} ${est} ${qtlpip} ${trait}