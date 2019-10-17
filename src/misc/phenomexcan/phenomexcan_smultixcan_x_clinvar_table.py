__author__ = "alvaro barbeira"

#module load gcc/6.2.0
#module load miniconda2/4.4.10
#source activate pyr

import pandas
import yaml
import gzip

I="/gpfs/data/im-lab/nas40t2/miltondp/phenomexcan/shiny/smultixcan_vs_clinvar-z2_avg-mashr.tsv.gz"
NAME_MAPPING="/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/badger_scripts/bq/ukb_filename_map.yaml"


O="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/smultixcan_vs_clinvar.txt.gz"

print("Reading name mapping")
with open(NAME_MAPPING) as y:
    mapping=yaml.load(y, Loader=yaml.FullLoader)["ukb_name"]
print("Read.")

def l_(e):
    return "{}\n".format("\t".join(e)).encode()

def map_ukb_name(name, mapping):
    for k in mapping.keys():
        if k in name:
            return mapping[k]
    raise RuntimeError("Key {} not found".format(name))

print("Processing pairs")
with gzip.open(I) as pairs:
    header = pairs.readline()
    with gzip.open(O, "w") as o:
        o.write(header)
        for line in pairs:
            comps = line.decode().strip().split()
            name = map_ukb_name(comps[0], mapping)
            l = l_([name]+ comps[1:])
            o.write(l)
print("Processed pairs")
