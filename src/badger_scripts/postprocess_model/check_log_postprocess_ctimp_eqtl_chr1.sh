#!/usr/bin/env bash

module load gcc/6.2.0
module load python/3.5.3

python3 /gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/misc/check_log.py \
-jobs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/utmost/jobs_pp \
-logs_folder /scratch/abarbeira3/v8_process/model_training/eqtl/utmost/logs_pp \
-finish_token "Done" \
--name_subfield_regexp "(.*)_postprocess_ctimp_chr1as*" \
--name_subfield tissue 1 \
-output check_pp_ctimp.txt

#--clean_target "models_chr1_as/{tissue}_*" \
#--clean_target "logs_pp/{tissue}_postprocess_ctimp_chr1as*" \
#--resubmit \

