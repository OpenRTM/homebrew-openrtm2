#!/bin/bash

build=(
    "openrtm2-py38   python@3.8"
    "openrtm2-py39   python@3.9"
    "openrtm2-py310  python@3.10"
    "openrtm2-py311  python@3.11"
)

bottle()
{
    brew update
    brew uninstall $1
    brew install --build-bottle $1
    brew bottle $1 | tee bottle.txt
}

rename()
{
    org_name=`grep Bottling bottle.txt| awk '{sub("gz\.\.\.","gz",$3);print $3;}'`
    new_name=`grep Bottling bottle.txt| awk '{sub("--","-",$3);sub("gz\.\.\.","gz",$3);print $3;}'`
    sha_name=`echo $new_name | awk '{sub("tar.gz","sha256");print $1;}'`
    mv $org_name $new_name
    mv bottle.txt $sha_name
}

bottling()
{
    brew install $2
    brew link $2
    bottle $1
    rename
    brew unlink $1
    brew unlink $2
}

#-----------
# main
#-----------
echo "Bottling the forllowing packages"

for ((i=0; ${#build[*]}>$i; i++)) ; do
    tmp=(${build[$i]})
    echo "${tmp[0]}"
    brew unlink "${tmp[0]}"
done

echo ""
echo "Installing openssl@1.1"
echo ""
brew install openssl@1.1
brew link openssl@1.1

echo ""
echo "Bottling openrtm2-aist"
echo ""
for ((i=0; ${#build[*]}>$i; i++)) ; do
    tmp=(${build[$i]})
    echo "bottling( ${tmp[0]} ${tmp[1]} )"
    bottling ${tmp[0]} ${tmp[1]}
done


