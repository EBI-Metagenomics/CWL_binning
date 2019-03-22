#!/usr/bin/env python3

import sys
import os
import argparse

"""
CHANGES
    1. Used python 3.6
    2. Used argparse module for simpler tracking of variables
    3. sys.exit must use a non-zero code (0 implies code ran correctly)
    4. Use boolean flags, not ints (clearer intent)
    5. Use break statements to avoid iterating lines from files after all information has been extracted
"""


def parse_args():
    parser = argparse.ArgumentParser(description='Parse DNAdiff.report output to retrieve summary data')
    parser.add_argument('--mash-table', help='mash table', required=True)
    parser.add_argument('report', help='dna_diff report file', nargs='+')
    parser.add_argument('--label')
    name_modifier = parser.add_mutually_exclusive_group()
    name_modifier.add_argument('--prefix', action='store_true')
    name_modifier.add_argument('--suffix', action='store_true')
    return parser.parse_args()


def main():
    args = parse_args()

    label = args.label or ""

    print('label\tref\tlenref\taliref\tlenquer\talique\tident\tdist')
    for f in args.report:
        if args.prefix:
            base = os.path.basename(f).split(".report")[0].split(label)[-1]
        elif args.suffix:
            base = os.path.basename(f).split(".report")[0].split(label)[0]
        else:
            base = os.path.basename(f).split(".report")[0]
    
        with open(f, "rU") as f:
            for line in f:
                if "TotalBases" in line:
                    cols = line.split()
                    lenref = int(cols[1])
                    lenquer = int(cols[2])
                if "AlignedBases" in line:
                    cols = line.split()
                    aliref = cols[1].split("(")[-1].split("%")[0]
                    alique = cols[2].split("(")[-1].split("%")[0]
                if "AvgIdentity" in line:
                    cols = line.split()
                    ident = cols[1].split("(")[-1].split("%")[0]
                    break

        with open(args.mash_table, "rU") as f:
            for line in f:
                cols = line.strip("\n").split("\t")
                query_file = os.path.basename(cols[0])
                query_name = os.path.splitext(query_file)[0]
                if query_name == base:
                    dist = cols[-1]
                    ref = os.path.basename(cols[1])
                    break

        out_fmt = "%s_%s\t%s\t%i\t%.2f\t%i\t%.2f\t%.2f\t%.2f"
        print(out_fmt % (label, base, ref, lenref, float(aliref), lenquer, float(alique), float(ident), float(dist)))


if __name__ == '__main__':
    main()
