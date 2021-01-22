#!/bin/bash

# Usage
# ./bulk_unzip.sh /tmp/aaa

#set -x
export EXTR_PATH=${EXTRACT_PATH:-/tmp/extract}

mkdir -p ${EXTR_PATH}

find $1 -iname *zip -exec sh -c 'mkdir -p $(basename {} .zip) && unzip -d ${EXTR_PATH}/$(basename {} .zip) {}' \;
