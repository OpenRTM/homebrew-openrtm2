#!/bin/bash

build=(
    "openrtm2-py39  omniorb-ssl-py39"
    "openrtm2-py310 omniorb-ssl-py310"
    "openrtm2-py311 omniorb-ssl-py311"
    "openrtm2-py312 omniorb-ssl-py312"
    "openrtm2-py313 omniorb-ssl-py313"

    "openrtm2-python-py39  omniorb-ssl-py39"
    "openrtm2-python-py310 omniorb-ssl-py310"
    "openrtm2-python-py311 omniorb-ssl-py311"
    "openrtm2-python-py312 omniorb-ssl-py312"
    "openrtm2-python-py313 omniorb-ssl-py313"
)

cleanup()
{
    openrtm=`brew list | grep openrtm`
    if [ "x" = "x$openrtm" ] ; then
        echo "No OpenRTM installed"
    else
        echo "Cleanup: " $openrtm
        brew unlink $openrtm
        brew uninstall --ignore-dependencies $openrtm
        brew cleanup $openrtm
    fi
    omniorb=`brew list | grep omniorb`
    if [ "x" = "x$omniorb" ] ; then
        echo "No omniORB installed"
    else
        echo "Cleanup: " $omniorb
        brew unlink $omniorb
        brew uninstall --ignore-dependencies $omniorb
        brew cleanup $omniorb
    fi
}

install()
{
    for ((i=0; ${#build[*]}>$i; i++)) ; do
        tmp=(${build[$i]})
        echo "Installing: ${tmp[0]}"
        brew install "${tmp[0]}"
        brew unlink  "${tmp[0]}"
    done

}

#-----------
# main
#-----------
cleanup
install
