#!/bin/bash

build=(
    "openrtm2-py38  omniorb-ssl-py38"
    "openrtm2-py39  omniorb-ssl-py39"
    "openrtm2-py310 omniorb-ssl-py310"
    "openrtm2-py311 omniorb-ssl-py311"
    "openrtm2-python-py38  omniorb-ssl-py38"
    "openrtm2-python-py39  omniorb-ssl-py39"
    "openrtm2-python-py310 omniorb-ssl-py310"
    "openrtm2-python-py311 omniorb-ssl-py311"
)

cleanup()
{
    for ((i=0; ${#build[*]}>$i; i++)) ; do
        tmp=(${build[$i]})
        echo "Cleanup: ${tmp[0]}"
        brew unlink "${tmp[0]}"
        brew remove --ignore-dependencies "${tmp[0]}"
        brew cleanup -s "${tmp[0]}"
    done
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

