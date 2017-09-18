#!/bin/sh


<<COMMANDLINE

for i in `find /data/joy/BBL/studies/grmpy/rawData/ -iname '*B0map*um*'`; do T=`echo $i | sed 's/_um[0-9][0-9][0-9]/_M/g'`; echo "mv -i $i $T"; done

COMMANDLINE
