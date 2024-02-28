#!/bin/bash

OLD_VER=2.0.2
NEW_VER=2.1.0

OLD_SHA=ebb15105f4400dd70e603c471feb207eef6cf3396f1f30a70601c96329cb1ecf
NEW_SHA=3462bb01dacf69b058706e636cafd817e3abe97631b3056d0fa9d38f2e43fe6e

for f in openrtm2-py[0-9]*.rb
do
    sed -i.bak \
        -e "s|v${OLD_VER}\.tar\.gz|v${NEW_VER}.tar.gz|" \
        -e "s|${OLD_SHA}|${NEW_SHA}|" \
        -e "s|releases/download/${OLD_VER}|releases/download/${NEW_VER}|" \
        -e '/^[[:space:]]*rebuild [0-9][0-9]*$/d' \
        -e '/^[[:space:]]*sha256 cellar:/d' \
        "$f"
done

