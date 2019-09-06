#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder jobs \
-logs_folder logs \
-finish_token "Finished in" \
--name_subfield_regexp "model_training_(.*)_to_parquet_(.*)" \
--name_subfield type 1 \
--name_subfield tissue 2 \
--clean_target "logs/model_training_{type}_to_parquet_{tissue}*" \
--clean_target "results/{type}/{tissue}.{type}.parquet" \
--resubmit \
-output check_eqtl.txt


#--resubmit \
#--resubmit \