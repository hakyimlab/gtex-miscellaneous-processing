__author__ = "alvaro barbeira"
import gzip
import sqlite3
import pandas
import re
import os
GEUVADIS_ANNOTATION="/gpfs/data/im-lab/nas40t2/scott/PredictDBPipeline/data/intermediate/annotations/gene_annotation/gencode.v12.genes.parsed.txt"
GE="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/expression.txt.gz"

EN="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/elastic_net_models"
EN_P=re.compile("en_(.*).db")

EN_NP="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/elastic_net_np_models"
EN_NP_P=re.compile("en_(.*).db")

EN_DAPGW="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/elastic_net_models_dapgw"
EN_DAPGW_P=re.compile("dapgw_(.*).db")

MASHR="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/mashr"
MASHR_P=re.compile("mashr_(.*).db")

CTIMP="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/ctimp"
CTIMP_P=re.compile("ctimp_(.*).db")

CTIMP_NP ="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/ctimp_np"
CTIMP_NP_P=re.compile("ctimp_(.*).db")

OM="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/predixcan_geuvadis_hg38_v1/available_models.txt.gz"
OK="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/predixcan_geuvadis_hg38_v1/expression_prediction_key.txt.gz"

def read_expression_genes(path):
    r=[]
    with gzip.open(path) as i:
        i.readline()
        for line in i:
            g = line.decode().strip().split()[0]
            r.append(g)
    return r

def _read_genes(path):
    gene=[]
    genename=[]
    with sqlite3.connect(path) as connection:
        cursor = connection.cursor()
        for row in cursor.execute("SELECT gene, genename from EXTRA where `n.snps.in.model` > 0"):
            gene.append(row[0])
            genename.append(row[1])
    return pandas.DataFrame({"gene_id":gene, "gene_name":genename})

def read_genes(folder, pattern, method):
    r=[]
    for f in [x for x in sorted(os.listdir(folder)) if pattern.search(x)]:
        p = os.path.join(folder,f)
        t = pattern.search(f).group(1)
        r.append(_read_genes(p).assign(tissue =t, method=method))
    return r

print("process geuvadis")
expression_genes = read_expression_genes(GE)
expression_annotation = pandas.read_table(GEUVADIS_ANNOTATION)
expression_keys = expression_annotation[["gene_id", "gene_name"]].rename({"gene_id":"expression_id", "gene_name":"expression_name"}, axis=1)
expression_keys = expression_keys[expression_keys.expression_id.isin(expression_genes)]
expression_keys["key"] = expression_keys.expression_id.str.replace("\.(.*)", "")

print("process models")
model_genes = []
print("en")
model_genes.extend(read_genes(EN, EN_P, "v8_en"))
print("en_np")
model_genes.extend(read_genes(EN_NP, EN_NP_P, "v8_en_np"))
print("en_dapgw")
model_genes.extend(read_genes(EN_DAPGW, EN_DAPGW_P, "v8_en_dapgw"))
print("mashr")
model_genes.extend(read_genes(MASHR, MASHR_P, "v8_mashr"))
print("ctimp")
model_genes.extend(read_genes(CTIMP, CTIMP_P, "v8_ctimp"))
print("ctimp_np")
model_genes.extend(read_genes(CTIMP_NP, CTIMP_NP_P, "v8_ctimp_np"))
print("all togetehr now")
model_genes = pandas.concat(model_genes)
model_genes["key"] = model_genes.gene_id.str.replace("\.(.*)", "")
print("saving available models")
model_genes.to_csv(OM, sep="\t", compression="gzip", index=False)

print("building mapping")
m = model_genes.merge(expression_keys, on="key")
m.to_csv(OK,sep="\t", compression="gzip", index=False)

