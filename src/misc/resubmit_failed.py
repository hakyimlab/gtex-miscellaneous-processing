__author__ = "alvaro barbeira"
from helpers import helpers



if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser("Compare jobs to expected result")
    parser.add_argument("-cleanup", help="Folder to clean up[ (with addicitonal specifications", nargs="+")

    args = parser.parse_args()

    helpers.configure_logging(int(args.parsimony))

    run(args)