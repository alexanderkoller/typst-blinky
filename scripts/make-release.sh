#! /bin/bash

VERSION=$1

if [ -z "$VERSION" ];
then
    echo "You need to specify a version number."
    exit 1
fi


RELEASE_DIR=release/preview/blinky/$VERSION
PLUGIN_DIR=plugin/blinky/plugin


### WASM no longer needed for blinky >= 0.2.0.
# # Check that WASM is up to date.

# pushd $PLUGIN_DIR
# cargo build --target wasm32-unknown-unknown --release
# popd


# Put together release

rm -rf $RELEASE_DIR
mkdir -p $RELEASE_DIR

cp blinky.typ $RELEASE_DIR/lib.typ
cp README.md $RELEASE_DIR/
cp LICENSE $RELEASE_DIR/
# cp $PLUGIN_DIR/target/wasm32-unknown-unknown/release/blinky.wasm $RELEASE_DIR/

# replace version in typst.toml
sed "s/VERSION/$VERSION/g" typst-template.toml > $RELEASE_DIR/typst.toml

echo "Package is ready for release in $RELEASE_DIR."

