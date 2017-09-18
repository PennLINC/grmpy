#!/bin/sh

subjects=/data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/*/*/

rm SubjFile.csv

for s in $subjects; do 
bblIDs=$(echo ${s}|cut -d'/' -f10|sed s@'/'@' '@g)
SubjectxDate=$(echo ${s}|cut -d'/' -f11|sed s@'/'@' '@g|sed s@'x'@','@g)
scanID=$(echo ${SubjectxDate}|cut -d',' -f2)
Date=$(echo ${SubjectxDate}|cut -d',' -f1)

echo ${bblIDs},${scanID},${Date},${Date}x${scanID}>>SubjFile.csv

done 
