import os
import pandas
import json
import yaml

d = pandas.read_table("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/gwas_metadata.txt")
l = d.Tag.values

with open('/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/badger_scripts/bq/all_114_trait_map.yaml', 'w') as f:
    f.write('"name":\n')
    for l_ in l:
        f.write('  "{}": "{}"\n'.format(l_, l_))