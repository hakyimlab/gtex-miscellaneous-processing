import pandas as pd
import json
import yaml

wrapup = pd.read_csv('enloc_spec.txt', sep='\t')
wrapup = wrapup.groupby('tissue').agg(max)

with open('enloc_tissue_spec.yaml', 'w') as f:
    yaml.dump({'enloc_sqtl_tissue_info': json.loads(wrapup.to_json(orient='index'))}, f, default_flow_style=False)