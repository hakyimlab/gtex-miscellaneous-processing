import pandas
import subprocess
import re
import logging

from helpers import helpers

def run(args):
    p = subprocess.Popen(['qstat', '-f'], stdout=subprocess.PIPE, stderr = subprocess.PIPE)
    out, err = p.communicate()

    rjid = re.compile("Job Id: (.*)$")
    rhost = re.compile("\s+req_information.task_usage.0.task.1.host = (.*)$")
    rscript = re.compile("\s+submit_args = (.*)$")
    rsentinel = re.compile("=")
    sentinel_found = False
    d = []
    jid, host, path = None, None, None

    for line in out.decode().split("\n"):
        s = rjid.search(line)
        if s:
            jid = s.group(1)
            continue

        if not path:
            s = rscript.search(line)
            if s:
                path = s.group(1)
                continue
        else:
            if sentinel_found:
                pass
            else:
                _sentinel = rsentinel.search(line)
                if _sentinel:
                    sentinel_found = True
                    continue
                else:
                    path += line.strip()
                    continue

        s = rhost.search(line)
        if s:
            host = s.group(1)

        if jid and host and path:
            d.append((jid, host, path))
            jid, host, path = None, None, None
            sentinel_found = False

    d = pandas.DataFrame(d, columns =["id", "host", "path"])

    if args.output:
        d.to_csv(args.output, sep="\t", index=False, na_rep="NA")

    if args.cancel_stuck:
        for t in d.itertuples():
            logging.info("Cancelling %s:%s:%s", t.host, t.id, t.path)
            subprocess.call(["qdel", t.id])

    logging.info("Checked stuck.")

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser("Compare jobs to expected result")
    parser.add_argument("-output")
    parser.add_argument("--cancel_stuck", help="If stuck, cancel job", action="store_true")
    parser.add_argument("-parsimony",
                        help="Log verbosity level. 1 is everything being logged. 10 is only high level messages, above 10 will hardly log anything",
                        default=10, type=int)
    args = parser.parse_args()

    helpers.configure_logging(int(args.parsimony))

    run(args)