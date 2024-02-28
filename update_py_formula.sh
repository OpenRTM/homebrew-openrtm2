#!/bin/bash

OLD_VER=2.0.2
OLD_SHORT_VER=2.0
NEW_VER=2.1.0
NEW_SHORT_VER=2.1

OLD_SHA=3462bb01dacf69b058706e636cafd817e3abe97631b3056d0fa9d38f2e43fe6e
NEW_SHA=d07942eed317e96cd5a2da440464cd209bae4356a528d06dbcfbaa26473040c4

for f in openrtm2-python-py[0-9]*.rb
do
    sed -i.bak \
        -e "s|v${OLD_VER}\.tar\.gz|v${NEW_VER}.tar.gz|" \
        -e "s|${OLD_VER//./\\.}|${NEW_VER}|g" \
        -e "s|${OLD_SHORT_VER//./\\.}|${NEW_SHORT_VER}|g" \
        -e "s|releases/download/${OLD_VER}|releases/download/${NEW_VER}|" \
        -e '/^[[:space:]]*rebuild [0-9][0-9]*$/d' \
        -e '/^[[:space:]]*sha256 cellar:/d' \
        "$f"
done

