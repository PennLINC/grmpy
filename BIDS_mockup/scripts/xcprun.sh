#!/bin/bash
SNGL=/share/apps/singularity/2.5.1/bin/singularity
XCP=/data/joy/BBL/applications/bids_apps/xcpEngine.simg
SNGL_BIND=/home/aadebimpe



cohort_file=${SNGL_BIND}/data/jux/BBL/studies/grmpy/BIDSOUTPUT/scripts/cohortfile.csv
design_file=${SNGL_BIND}/data/jux/BBL/studies/grmpy/BIDSOUTPUT/scripts/anat-antsct.dsn 
temp_dir=/tmp/2477491.1.qlogin.himem.q
output_dir=${SNGL_BIND}/data/jux/BBL/studies/grmpy/BIDSOUTPUT/structural  
   
$SNGL exec -B /data:/home/aadebimpe/data $XCP /xcpEngine-master/xcpEngine -d ${design_file} -c ${cohort_file} -o ${output_dir} -i ${temp_dir} -r /home/aadebimpe
