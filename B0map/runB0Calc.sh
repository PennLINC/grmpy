#!/bin/bash

#########################################################################################
    ################       GRMPY 118 Distortion Correction         ###############
    ################              Robert Jirsaraie                 ###############
    ################             rjirsara@upenn.edu                ###############
    ################                 09/10/2017                    ###############
#########################################################################################
<<Use


This script was written to create all of the B0 maps which can be found in 
/data/joy/BBL/studies/pnc/processedData/b0map
It is just a rough for loop which runs Mark Elliot's dico_b0calc_v4_afgr.sh script
AFGR edited Mark Elliots script to make sure it took the correct inputs
created by Robert Jirsaraie in sept 2017


Use
#########################################################################################
###  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ###
#########################################################################################

# Run through each subject and calcualte a b0 rps map for them
subjFile="/data/joy/BBL/projects/grmpyProcessing2017/B0map/n118_SubjFile.csv"
subjLength=`cat ${subjFile} | wc -l`
baseOutputPath="/data/joy/BBL/studies/grmpy/processedData/B0map"
baseRawDataPath="/data/joy/BBL/studies/grmpy/rawData/"
baseExtractedPath="/data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/"
scriptToCall="/data/joy/BBL/projects/grmpyProcessing2017/B0map/dico_b0calc_v4_afgr.sh"
forceScript="/data/joy/BBL/applications/scripts/bin/force_RPI.sh"  

for subj in `seq 1 ${subjLength}` ; do
  rndDig=${RANDOM}
  bblid=`sed -n "${subj}p" ${subjFile} | cut -f 1 -d ","`
  scanid=`sed -n "${subj}p" ${subjFile} | cut -f 2 -d ","`
  scandate=`sed -n "${subj}p" ${subjFile} | cut -f 3 -d ","`
  subjRawData="${baseRawDataPath}${bblid}/${scandate}x${scanid}"
  subjB0Maps=`find ${subjRawData} -name "B0_dicoms*" -type d`
  subjB0Maps1=`echo ${subjB0Maps} | cut -f 1 -d ' '`
  subjB0Maps2=`echo ${subjB0Maps} | cut -f 2 -d ' '`
  subjOutputDir="${baseOutputPath}/${bblid}/${scandate}x${scanid}/"
  mkdir -p ${subjOutputDir}
  rawT1=`find ${subjRawData}/*MPRAGE* -name "*nii.gz" -type f`
  ${forceScript} ${rawT1} ./tmp${rndDig}.nii.gz
  rawT1="./tmp${rndDig}.nii.gz"
  extractedT1=`find ${baseExtractedPath}${bblid}/${scandate}x${scanid} -name "*Extracted*nii.gz"`
  if [ -f ${subjOutputDir}${bblid}_${scandate}x${scanid}_rpsmap.nii ] ; then
    echo "output already exists"
    echo "Skipping BBLID:${bblid}"
    echo "	   SCANID:${scanid}"
    echo "         DATE:${scandate}"
    echo "*************************" ; 
  else
    ${scriptToCall} ${subjOutputDir} ${subjB0Maps1}/ ${subjB0Maps2}/ ${rawT1} ${extractedT1}  
    for i in `ls ${subjOutputDir}` ; do
      mv ${subjOutputDir}${i} ${subjOutputDir}${bblid}_${scandate}x${scanid}${i} 
    done ;
    for i in `ls ${subjOutputDir}*nii` ; do 
      /share/apps/fsl/5.0.8/bin/fslchfiletype NIFTI_GZ ${i} ; 
    done   
  fi  
  rm ${rawT1} ;  
done
  
  
<<COMMANDLINE

qsub /data/joy/BBL/projects/grmpyProcessing2017/B0map/runB0Calc.sh

COMMANDLINE
