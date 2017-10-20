#!/bin/sh

###################################################################################################
##########################          GRMPY - NMF Mask Creation            ##########################
##########################              Robert Jirsaraie                 ##########################
##########################        rjirsara@pennmedicine.upenn.edu        ##########################
##########################                  10/19/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was originally created by Atonia Kaczkurkin and was modifed for the GRMPY dataset. This script
creates a mask that will remove images with too many 0 or <.1 values using Phil's method.

To run this script it is required to have a qlogin session with 50G of memory. Use the Command Below:

qlogin -l h_vmem=50.5G,s_vmem=50.0G -q qlogin.himem.q

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

##############################################################
### Defines the Subjects that Passed QA & Will be Analyzed ###
##############################################################

subjects=$(cat /data/joy/BBL/projects/grmpyProcessing2017/NMF/n115_Cohort_20171015.csv| cut -d ',' -f1)
outdir=/data/joy/BBL/studies/grmpy/processedData/NMF/ctMask
mkdir -p ${outdir}

##################################################
### Locates the Subjects Image To Be Processed ###
##################################################

i=0
for s in $subjects; do

imgList[i]=$(ls /data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/${s}/*/antsCT/*_CorticalThicknessNormalizedToTemplate.nii.gz)

(( i++ ))
done

#####################################################
### Calls the Script that Will Process The Images ###
#####################################################

for i in ${imgList[@]}; do 
                                                                                                                                                              
   fileName=$(echo $i | cut -d'/' -f13  | cut -d'.' -f1)
   echo "file name is $fileName"

	ThresholdImage 3 $i ${outdir}/${fileName}_mask.nii.gz 0.1 Inf
	
done

########################################################################
### Average the Masks Together and Binarize/Threshold the Final Mask ###
########################################################################

AverageImages 3 ${outdir}/coverageMask.nii.gz 0 ${outdir}/*mask.nii.gz

fslmaths ${outdir}/coverageMask.nii.gz -thr .9 -bin ${outdir}/n115_ctMask_thr9_2mm.nii.gz

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
