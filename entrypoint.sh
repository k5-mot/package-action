#!/usr/bin/env bash 

## -e : Stop if failed
## -u : Error if exists not initialized variables 
set -eu

## Create directory for release
mkdir -p release

## Setup variables
RELEASE=$1
EXCLUSIONS=($2 'release')

## Compress release.tar.gz
ARGS_TARGZ='tar'
for S in "${EXCLUSIONS[@]}"
do
  ARGS_TARGZ="${ARGS_TARGZ} --exclude $S"
done
ARGS_TARGZ="${ARGS_TARGZ} -zcf release/${RELEASE}.tar.gz ."
eval ${ARGS_TARGZ}

## Compress release.zip
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
