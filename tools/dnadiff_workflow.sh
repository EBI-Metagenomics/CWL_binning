#!/bin/bash

if [ $# -eq 0 ]; then
    echo "ERROR! usage: dnadiff_workflow.sh bestMash_hits_db.tab out_suffix"
    exit 1
fi
echo $1
while read col1 col2 rem
do
    p=$(find . -name ${col1} | head -n 1)
    p=$(abspath ${p})
    echo ${p}
    echo "dnadiff ${col2} ${p} -p ${col1%%.fa*}_${2}"
    dnadiff ${col2} $p -p ${col1%%.fa*}_${2}
done < ${1}