__author__ = "alvaro barbeira"
import pyarrow as pa
from pyarrow import parquet as pq

d = pq.read_table("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/gtex_v8_eur_itm.variants_metadata.parquet").to_pandas()
d.to_csv("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/model_training_to_parquet/results/parquet_eur_maf0.01_biallelic/varians.txt.gz", sep="\t", index=False, na_rep="NA", compression="gzip")
