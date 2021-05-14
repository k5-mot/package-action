#!/usr/bin/env bash 

set -eu

mkdir -p release
RELEASE=$1
EXCLUSIONS=($2)

## Compress .tar.gz
ARGS_TARGZ='tar'
for S in "${EXCLUSIONS[@]}"
do
  ARGS_TARGZ="${ARGS_TARGZ} --exclude $S"
done
ARGS_TARGZ="${ARGS_TARGZ} -zcf release/${RELEASE}.tar.gz ."
eval ${ARGS_TARGZ}

## Compress .zip
ARGS_ZIP=''
ARGS_ZIP="zip --quiet --recurse-paths release/${RELEASE}.zip ."
for S in "${EXCLUSIONS[@]}"
do
  ARGS_ZIP="${ARGS_ZIP} --exclude \"$S/*\""
done
eval "${ARGS_ZIP}"

## Check compressed files.
set -x
tar -ztvf release/${RELEASE}.tar.gz
unzip -Z release/${RELEASE}.zip
set +x
