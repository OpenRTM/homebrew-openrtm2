#!/bin/bash

build=(
    "openrtm2-python-py39  omniorb-ssl-py39"
    "openrtm2-python-py310 omniorb-ssl-py310"
    "openrtm2-python-py311 omniorb-ssl-py311"
    "openrtm2-python-py312 omniorb-ssl-py312"
    "openrtm2-python-py313 omniorb-ssl-py313"
)

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

bottling()
{
    echo "Installing " $2
    brew install $2
    brew link $2
    echo "Bottling " $1
    bottle $1
    rename
    echo "unlinking " $1
    brew unlink $1
    echo "unlinking " $2
    brew unlink $2
}

cleanup()
{
    for ((i=0; ${#build[*]}>$i; i++)) ; do
        tmp=(${build[$i]})
        installed=`brew info ${tmp[0]} | grep Installed`
        if test "x" = "x$installed" ; then
             echo "Not installed: ${tmp[0]}. Do nothing."
             continue
        fi
        echo "Cleanup: ${tmp[0]}"
        brew unlink "${tmp[0]}"
        brew remove --ignore-dependencies "${tmp[0]}"
        brew cleanup -s "${tmp[0]}"
    done
}

build()
{
    for ((i=0; ${#build[*]}>$i; i++)) ; do
        tmp=(${build[$i]})
        echo "bottling( ${tmp[0]} ${tmp[1]})"
        bottling ${tmp[0]} ${tmp[1]}
    done
}
#-----------
# main
#-----------
echo "Cleanup related packages."
cleanup

echo ""
echo "Bottling openrtm2-aist"
echo ""
build


