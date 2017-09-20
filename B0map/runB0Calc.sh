#!/bin/bash

###################################################################################################
##########################         GRMPY - Distortion Correction         ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  08/03/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was originally created by Adon Rosen to ensure that the correct inputs will be 
given to Mark Elliot's script (dico_b0calc_v4_afgr.sh), which will then convert B0dicomes 
into B0 images. This process is needed to perform distortion correction on fMRI images.

This version of the script was made by Robert Jirsaraie to perform distortion correction
on the grmpy dataset.

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

#####################################################################
### Define paths to the Input/Output/ReferenceScripts/SubjectFile ###
#####################################################################

subjFile="/data/joy/BBL/projects/grmpyProcessing2017/B0map/n118_SubjFile.csv"
subjLength=`cat ${subjFile} | wc -l`
baseOutputPath="/data/joy/BBL/studies/grmpy/processedData/B0map"
baseRawDataPath="/data/joy/BBL/studies/grmpy/rawData/"
baseExtractedPath="/data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/"
scriptToCall="/data/joy/BBL/projects/grmpyProcessing2017/grmpyProcessing2017Scripts/B0map/dico_b0calc_v4_afgr.sh"
forceScript="/data/joy/BBL/applications/scripts/bin/force_RPI.sh" 
 
###################################################################
### Locates Subjects of Interest, B0dicoms files, & Output File ###
###################################################################

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
  
########################################################################
### *B0dicom sequences (M&P) Must be stored in Separate Directories* ###
########################################################################

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
  
############################################################################################
### Next Lines Run the dico_b0calc script and put the output into correct format .nii.gz ###
############################################################################################

    ${scriptToCall} ${subjOutputDir} ${subjB0Maps1}/ ${subjB0Maps2}/ ${rawT1} ${extractedT1} 
    
    for i in `ls ${subjOutputDir}` ; do
      mv ${subjOutputDir}${i} ${subjOutputDir}${bblid}_${scandate}x${scanid}${i} 
    done ; #Moves Output Images to the Outdirectory 
    for i in `ls ${subjOutputDir}*nii` ; do 
      /share/apps/fsl/5.0.8/bin/fslchfiletype NIFTI_GZ ${i} ; 
    done   #converts ouput into .nii.gz
  fi  
  rm ${rawT1} ;  
done

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
################################################################################################### 
<<COMMANDLINE

qsub /data/joy/BBL/projects/grmpyProcessing2017/grmpyProcessing2017Scripts/B0map/runB0Calc.sh

COMMANDLINE
