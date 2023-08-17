#!/bin/bash

brew list | grep omniorb-ssl | awk '{printf("brew remove --ignore-dependencies %s\n",$1);}' | sh
brew list | grep openrtm2 | awk '{printf("brew remove --ignore-dependencies %s\n",$1);}' | sh

bottle()
{
    brew update
    installed=`brew info $1 | grep Installed`
    if test "x" != "x$installed" ; then
        brew uninstall $1
    fi
    brew install --build-bottle $1
    brew bottle $1 | tee bottle.txt
}

rename()
{
    org_name=`grep Bottling bottle.txt| sed -n 's/.*\(openrtm.*\.gz\).*/\1/p'`
    new_name=`echo $org_name | sed 's/--/-/'`
    sha_name=`echo $new_name | sed 's/tar.gz/sha256/'`
    mv $org_name $new_name
    mv bottle.txt $sha_name
}
bottle $1
rename