#!/bin/sh

echo Removing previous puppet.zip...
rm zip/puppet.zip

echo Zipping the puppet directory into zip/puppet.zip...
zip -r -9 zip/puppet.zip puppet/ -x "*.DS_Store"

for f in zip/*-base.zip; do
  exdir=`basename $f .zip`

  if [ ! -d "zip/output-$exdir" ]; then
    echo Extracting base image $f ...
    unzip "$f" -d "zip"
  fi
done