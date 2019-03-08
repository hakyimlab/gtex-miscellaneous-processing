__author__ = "alvaro barbeira"
import os
import sqlite3
import shutil
import pandas
import re

I="/gpfs/data/im-lab/nas40t2/abarbeira/data/xqwen/twas_builder/dbs/BTWAS_DB_EGENE"
O="/gpfs/data/im-lab/nas40t2/abarbeira/data/xqwen/twas_builder/dbs/BTWAS_DB_EGENE_FILTERED"

if not os.path.exists(O):
    os.makedirs(O)


print("Reading gencode")
gencode = pandas.read_table("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/gencode_v26_stranded_all.txt")
_r = re.compile("chr(\d+)")
_x = {t.gene_id for t in gencode.itertuples() if not _r.search(t.chromosome)}


for x in sorted(os.listdir(I)):
    print(x)
    shutil.copy(os.path.join(I,x), os.path.join(O,x))
    with sqlite3.connect(os.path.join(I,x)) as _i:
        e = pandas.read_sql("select * from extra order by gene", _i)
        e = e[~e.gene.isin(_x)]
        with sqlite3.connect(os.path.join(O,x)) as _o:
            e.to_sql("extra", _o, if_exists="replace")