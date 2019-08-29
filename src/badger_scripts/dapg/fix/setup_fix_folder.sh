#!/usr/bin/env bash

F=/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/fix/dapg
DAPG=/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/badger_scripts/dapg

folder()
{
mkdir -p $F/$1
chmod g+rwx $F/$1
}

get_dapg_run()
{
ln -s $DAPG/dap_job_spec_eqtl.yaml $F/dapg_$1/
ln -s $DAPG/dap_on_study.jinja $F/dapg_$1/
ln -s $DAPG/fix/dap_on_study_v8_eqtl_$1.yaml $F/dapg_$1/
ln -s $DAPG/fix/submit_dap_on_study_v8_eqtl_$1.sh $F/dapg_$1/
ln -s $DAPG/fix/check_log_dap_eqtl_$1.sh $F/dapg_$1/
}

setup()
{
folder dapg_$1
get_dapg_run $1
}

folder dapg
setup 1
setup 2
setup 3
setup 4
setup 5


