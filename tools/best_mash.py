#!/usr/bin/env python2
import sys
import json
import os

if len(sys.argv) < 2:
    print "ERROR! usage: python script.py dist.tab"
    sys.exit()


def write_output_file_json(filepath):
    abspath = os.path.abspath(filepath)
    nameroot, nameext = os.path.splitext(filepath)
    return {
        'class': 'File',
        'location': 'file://' + abspath,
        'size': os.path.getsize(abspath),
        'basename': os.path.basename(abspath),
        'nameroot': nameroot,
        'nameext': nameext,
        'path': abspath,
        'dirname': os.path.dirname(abspath)
    }


hits = {}

with open(sys.argv[1], "r") as f:
    for line in f:
        cols = line.strip("\n").split("\t")
        if len(cols) == 5:
            ref = cols[0]
            mag = cols[1]
            dist = float(cols[2])
            pvalue = float(cols[3])
            if mag not in hits.keys():
                hits[mag] = (ref, dist, pvalue)
            else:
                if hits[mag][1] > dist or (hits[mag][1] == dist and hits[mag][2] > pvalue):
                    hits[mag] = (ref, dist, pvalue)

json_out = {'mags': [], 'refs': []}

best_mash_tbl = []
for mag, (ref, dist, pvalue) in hits.items():
    # Write list of files and output table
    best_mash_tbl.append("%s\t%s\t%.4f\t%.4f\n" % (mag, ref, dist, pvalue))
    json_out['mags'].append(mag)
    json_out['refs'].append(ref)

with open('best_mash.tab', 'w') as f:
    f.writelines(best_mash_tbl)

# Mock CWL file handling in json output
json_out['table'] = write_output_file_json('best_mash.tab')

with open('cwl.output.json', 'w') as f:
    json.dump(json_out, f)
