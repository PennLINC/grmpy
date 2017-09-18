#!/bin/sh

subjects=/data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/*     



for s in $subjects; do 

imgCheck=$(ls ${s}/*/jlf/maskedJLFParcel.nii.gz 2>/dev/null) 

if [[ -n ${imgCheck} ]] ; then 

   echo "Intersection Image Exists For This Subject"

else

echo ${s}>>temp.txt

fi

done
