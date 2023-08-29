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

