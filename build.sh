#!/bin/sh

echo Removing previous puppet.zip...
rm zip/puppet.zip

echo Zipping the puppet directory into zip/puppet.zip...
zip -r -9 zip/puppet.zip puppet/

for f in zip/*-base.zip; do
  exdir=`basename $f .zip`

  if [ ! -f "zip/output-$exdir" ]; then
  echo "zip/output-$exdir"
    echo Extracting base image $f ...
    unzip "$f" -d "zip"
  fi
done