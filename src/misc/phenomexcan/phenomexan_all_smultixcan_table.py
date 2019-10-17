__author__ = "alvaro barbeira"

#module load gcc/6.2.0
#module load miniconda2/4.4.10
#source activate pyr

import pandas
import yaml
import json
import gzip
I="/gpfs/data/im-lab/nas40t2/miltondp/phenomexcan/smultixcan_gtex_v8_on_neale2018/smultixcan-genes_associations-pvalue.pkl.xz"
NAME_MAPPING="/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/badger_scripts/bq/ukb_filename_map.yaml"
G="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_all.txt"

O="smultixcan_pheno_associations_by_gene.txt.gz"
OS="smultixcan_pheno_associations_by_gene_schema.json"


print("Reading name mapping")
with open(NAME_MAPPING) as y:
    mapping=yaml.load(y, Loader=yaml.FullLoader)["ukb_name"]
print("Read.")

def l_(e):
    return "{}\n".format("\t".join(e)).encode()

def map_ukb_name(name, mapping):
    for k in mapping.keys():
        if k in name:
            return k[name]
    raise RuntimeError("Key not found")

print("processing table")
with gzip.open(I) as table:
    header = table.readline().decode().strip()
    header_comps = header.split()

    with gzip.open(O, "w") as o:
        o.write(l_(["ukb", "clinvar", "score"]))
        for l in table:
            comps = l.decode().strip().split()
            name = map_ukb_name(comps[0], mapping)
            for pos, clinvar in enumerate(header_comps[1:]):
                o.write(l_([name, clinvar, comps[pos+1]]))
print("written")



print("schema")
schema = [ {"name": "ukb", "type":"STRING"},
           {"name": "clinvar", "type":"STRING"},
           {"name": "score", "type": "FLOAT"}]
with open(OS, "w") as j:
    json.dump(schema, j, indent=2)
print("schema'd")