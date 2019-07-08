#/usr/bin/env python
import sys
import gzip

I = sys.argv[1]
O = sys.argv[2]

print("starting")
with gzip.open(O, "w") as o:
    o.write("id\n".encode())
    found = set()
    with gzip.open(I) as i:
        i.readline()
        for l,line in enumerate(i):
            comps = line.decode().strip().split()
            id = comps[0]
            if not id in found:
                o.write("{}\n".format(id).encode())
            found.add(id)

print("done")
