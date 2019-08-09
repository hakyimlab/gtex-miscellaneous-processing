import pandas as pd
import json
import yaml
import numpy

wrapup = pd.read_csv('dap_eqtl_wrapup.txt', sep='\t')
wrapup["key"] =  wrapup.chromosome.astype(str) + "_" + wrapup.sub_job.astype(str)
spec = wrapup.groupby('key').agg(max)
spec = spec[["memory", 'walltime']]

me_conditions = [
    (spec.memory < 3500),
    (spec.memory >= 3500) & (spec.memory < 7000),
    (spec.memory >= 7000) & (spec.memory < 14000)]
me_values = ['4gb', '8gb', '16gb']
spec.memory  = numpy.select(me_conditions, me_values, default='32gb')

wt_conditions = [
    (spec.memory == "4gb") & (spec.walltime < 10800)
]
wt_values = ["4:00:00"]
spec.walltime= numpy.select(wt_conditions, wt_values, default="72:00:00")

with open('/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/badger_scripts/dapg/dap_job_spec_eqtl.yaml', 'w') as f:
    yaml.dump({'spec': json.loads(spec.to_json(orient='index'))}, f, default_flow_style=False)