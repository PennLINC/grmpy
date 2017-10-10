#!/bin/sh

###################################################################################################
##########################     GRMPY - Create Pipeline Subject Files     ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  10/10/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
<<Use

This script was created to identify the subjects of interest and list their information into correct format. 
In particular, this cohort file was specifically used to initiate the restbold pipeline.

Use
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

subjects=/data/joy/BBL/studies/grmpy/processedData/restbold1_124mb/dico/*/*/*dico.nii.gz
outdirect=/data/joy/BBL/projects/grmpyProcessing2017/restbold1_124mb

echo 'id0,id1,img,antsct'>>${outdirect}/n101_PipelineCohort_20171010.csv

for s in $subjects; do 

bblIDs=$(echo ${s}|cut -d'/' -f10|sed s@'/'@' '@g)
SubjectxDate=$(echo ${s}|cut -d'/' -f11|sed s@'/'@' '@g)
img=$(echo ${s})
antsct=$(echo /data/joy/BBL/studies/grmpy/processedData/structural/struct_pipeline_20170716/)


echo ${bblIDs},${SubjectxDate},${img},${antsct}>>${outdirect}/n101_PipelineCohort_20171010.csv

done

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
