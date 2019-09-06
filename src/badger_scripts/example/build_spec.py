import pandas as pd
import json
import yaml
import numpy

wrapup = pd.read_csv('wrapup.txt', sep='\t')
spec = wrapup[["tissue", "walltime", "memory"]]

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

with open('model_training_expression_spec.yaml', 'w') as f:
    spec = spec.set_index("tissue")
    yaml.dump({'spec': json.loads(spec.to_json(orient='index'))}, f, default_flow_style=False)