#!/bin/bash

org=("3\\.9" "39")
pyver=(
    "3\\.10 310"
    "3\\.11 311"
    "3\\.12 312"
    "3\\.13 313"
)

#-----------
# main
#-----------
echo "Generate formulas by python versions"

for ((i=0; ${#pyver[*]}>$i; i++)) ; do
    tmp=(${pyver[$i]})
    fname=`echo $1 | sed "s/${org[1]}/${tmp[1]}/g"`
    echo $fname " generated."
    echo "s/${org[0]}/${tmp[0]}/g; s/${org[1]}/${tmp[1]}/g;" 
    sed  "s/\([^0-9]\)${org[0]}/\1${tmp[0]}/g; s/\([^0-9]\)${org[1]}/\1${tmp[1]}/g;" $1 > $fname
done


