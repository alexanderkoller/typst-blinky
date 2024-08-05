#! /bin/bash

VERSION=$1

if [ -z "$VERSION" ];
then
    echo "You need to specify a version number."
    exit 1
fi

SRC_DIR=preview/bib-url-linker/$VERSION
TGT_DIR=typst-packages/packages/preview/bib-url-linker/$VERSION

cd release

# make sure that we have a clone of our fork
if [ ! -d typst-packages ]; then
    git clone https://github.com/alexanderkoller/typst-packages.git
fi

pushd typst-packages
git pull # synchronize with our own changes
git pull https://github.com/typst/packages # synchronize with global changes
popd

# make room
rm -rf $TGT_DIR
mkdir -p $TGT_DIR

# copy
cp -r $SRC_DIR/* $TGT_DIR/

# commit
git add $TGT_DIR/*
git commit -am "added bib-url-linker $VERSION"


