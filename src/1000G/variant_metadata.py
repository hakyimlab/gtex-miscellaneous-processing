import gzip
import os
import pandas

F="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/1000G_hg38_EUR_maf0.01_parquet"

import pyarrow as pa
import pyarrow.parquet as pq

########################################################################################################################
# Cannibalized text

class DataSink:
    def sink(self, d):
        raise Exceptions.ReportableException("Not implemented")

    def initialize(self):
        raise Exceptions.ReportableException("Not implemented")

    def finalize(self):
        raise Exceptions.ReportableException("Not implemented")

    def __enter__(self):
        raise Exceptions.ReportableException("Not implemented")

    def __exit__(self, exc_type, exc_val, exc_tb):
        raise Exceptions.ReportableException("Not implemented")

class DataFrameSink(DataSink):
    pass

class ParquetDataFrameSink(DataFrameSink):
    def __init__(self, path, schema, compression=None):
        self.path = path
        self.schema = schema
        self.writer = None
        self.compression = compression

    def __enter__(self):
        self.initialize()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.finalize()

    def sink(self, d):
        d = _to_record_batch(d)
        d = pa.Table.from_batches([d])
        self.writer.write_table(d)

    def initialize(self):
        print("Initializing parquet sink", flush=True)
        self.writer = pq.ParquetWriter(self.path, self.schema, flavor="spark", compression=self.compression)

    def finalize(self):
        print("Finalizing parquet sink", flush=True)
        self.writer.close()

def _to_record_batch(df):
    data =[]
    names = list(df.columns.values)
    for c in names:
        data.append(pa.array(df[c]))
    return  pa.RecordBatch.from_arrays(data, names)

def _save_metadata(path, metadata):
    table = _to_record_batch(metadata.iloc[0:2,:])
    with ParquetDataFrameSink(path, table.schema) as sink:
        for c_ in range(1, 23):
            print("Saving metadata for chromosome {}".format(c_), flush=True)
            p_ = metadata.loc[metadata.chromosome == c_]
            sink.sink(p_)

########################################################################################################################

d = []
for i in range(1, 23):
    print(i, flush=True)
    f = "chr{}.variants_metadata.parquet".format(i)
    p = os.path.join(F, f)
    d_ = pq.read_table(p).to_pandas()
    d.append(d_)

print("setting data up", flush=True)
d = pandas.concat(d)

print("saving text", flush=True)
d.to_csv(os.path.join(F, "variant_metadata.txt.gz"), compression="gzip", sep="\t", index=False, na_rep="NA")

print("saving parquet", flush=True)
_save_metadata(os.path.join(F, "variant_metadata.parquet"), d)

print("done", flush=True)