#!/bin/bash
for TOOL in $@; do
	echo ""
    which $TOOL;
	$TOOL --version | head -n 1 | sed -e 's/^/\t/'
done
