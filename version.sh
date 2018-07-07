#!/bin/bash
TOOLS=($@)
for TOOL in ${TOOLS[@]};do
	echo ""
    which $TOOL;
	$TOOL --version | head -n 1 | sed -e 's/^/\t/'
done
