__author__ = "alvaro barbeira"
import pandas
import sqlite3
import gzip

print("Open db")
with sqlite3.connect("/gpfs/data/im-lab/nas40t2/abarbeira/data/xqwen/twas_builder/dbs/BTWAS_DB_EGENE_FILTERED/Whole_Blood.btwas.db") as con:
    e = pandas.read_sql("SELECT * from extra order by gene", con)

print("Checking file")
genes=[]
with gzip.open("/scratch/abarbeira3/v8_process/twas_builder/results/covariances/Whole_Blood.txt.gz") as f:
    f.readline()
    last_gene = None
    for l in f:
        gene = l.decode().split()[0]
        if gene != last_gene:
            print("Checking {}".format(gene))
            genes.append(gene)
            last_gene = gene
            i = len(genes) -1
            if e.gene.values[i] != gene:
                print("Mismatch {} - {}".format(gene, e.gene.values[i]))
