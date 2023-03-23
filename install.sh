#!/bin/bash

brew_cellar=$(brew --cellar)
echo $brew_cellar

formulas="
    openrtm2-python-py38
    openrtm2-python-py39
    openrtm2-python-py310
    openrtm2-python-py311
"

brew_uninstall()
{
    for f in $formulas; do
        echo brew uninstall $f
        brew remove $f
        brew cleanup -s $f
    done 
}
brew_install()
{
    for f in $formulas; do
        echo brew install $f
        brew install $f
        brew unlink $f
    done
}

brew_uninstall
brew_install
