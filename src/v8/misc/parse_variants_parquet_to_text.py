import pyarrow as pa
from pyarrow import parquet as pq
import pandas
__author__ = "alvaro barbeira"

d = pq.read_table("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.variants_metadata.parquet").to_pandas()
d.to_csv("variants.txt.gz", compression="gzip", sep="\t", index=False)