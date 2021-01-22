#!/bin/bash

#set -x

FUZZ_FACTOR=${CONV_FUZZ:-10%}
PATTERN=${CONV_PATTERN:-*jpg}

if which convert >/dev/null; then
    find $1 -iname ${PATTERN} \
	-exec \
	convert {} \
	-fuzz ${FUZZ_FACTOR} \
	-layers Optimize {}.pdf \;
else
    echo convert does not exist
fi



if which pdfjoin >/dev/null; then
    pdfjoin ${1}*.pdf --outfile ${1}_out.pdf
else
    echo pdfjoin does not exist
fi
