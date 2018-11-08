#!/usr/bin/env python
__author__ = "alvaro barbeira"

import logging
import sys
import pandas


import pyarrow as pa
from pyarrow import parquet as pq

########################################################################################################################
def configure_logging(level=5, target=sys.stderr, log_file=None):
    logger = logging.getLogger()
    logger.setLevel(level)

    # create console handler and set level to info
    handler = logging.StreamHandler(target)
    handler.setLevel(level)
    formatter = logging.Formatter("%(levelname)s - %(message)s")
    handler.setFormatter(formatter)
    logger.addHandler(handler)

    if log_file:
        fileHandler = logging.FileHandler("log_file")
        fileHandler.setFormatter(formatter)
        logger.addHandler(fileHandler)

########################################################################################################################

def get_cleared(vmfile, frequency, row_group):
    logging.info("reading metadata group %d", row_group)
    m = vmfile.read_row_group(row_group).to_pandas()
    return m[(m.allele_1_frequency > frequency) & (m.allele_1_frequency < (1-frequency))]

def get_cleared_columns(vmfile, frequency, row_group):
    m = get_cleared(vmfile, frequency, row_group)
    return ["individual"] + [x for x in m.id]

def concatenate_files(files, output_path, variant_metadata_path, frequency):
    vmf = pq.ParquetFile(variant_metadata_path) if variant_metadata_path else None

    columns = []
    for i,file_path in enumerate(files):
        logging.info(file_path)
        p = pq.ParquetFile(file_path)

        if vmf is not None and frequency is not None:
            cleared = get_cleared_columns(vmf, frequency, i)
            logging.info("%d cleared snps", len(cleared))
            t = p.read(columns=cleared)
        else:
            t = p.read()

        from_ = 0 if i==0 else 1
        for c_ in range(from_, t.num_columns):
            columns.append(t.column(c_))

    logging.info("Creating table")
    table = pa.Table.from_arrays(columns)
    logging.info("saving...")
    o = pq.ParquetWriter(output_path, table.schema, flavor="spark")
    o.write_table(table)
    o.close()
    logging.info("finished.")

def save_pandas(df, path):
    data =[]
    names = list(df.columns.values)
    for c in names:
        data.append(pa.array(df[c]))
    record_batch = pa.RecordBatch.from_arrays(data, names)
    writer = pq.ParquetWriter(path, record_batch.schema, flavor="spark")
    table = pa.Table.from_batches([record_batch])
    writer.write_table(table)

def filtered_metadata(variant_metadata_path, output_path, frequency):
    logging.info("Processing metadata...")
    vmf = pq.ParquetFile(variant_metadata_path)
    v = []
    for i in range(0,22):
        v_ = get_cleared(vmf, frequency, i)
        v.append(v_)
    v = pandas.concat(v)
    logging.info("saving...")
    save_pandas(v, output_path)
    logging.info("finished.")

########################################################################################################################

configure_logging()

logging.info("beggining conversion")
VM="gtex_v8_eur_itm.variants_metadata.parquet"
F=0.01
FILES = ["gtex_v8_eur_itm.chr{}.variants.parquet".format(x) for x in range(1,23)]
OUTPUT = "gtex_v8_eur_itm.variants.maf0_01.parquet"
METADATA_OUTPUT = "gtex_v8_eur_itm.variants_metadata.maf0_01.parquet"
concatenate_files(FILES, OUTPUT, VM, F)
filtered_metadata(VM, METADATA_OUTPUT, F)
