#!/bin/sh

######                  Created By Robert Jirsaraie September 2017                   ######

###  This script can be used to move and rename downloaded dicoms to a standard format  ###
###  Dicoms Downloaded from xnat must first be uploaded into your home directory (scp)  ###
###  Example: imac:~ rjirsaraie$ scp ~/Desktop/010110.zip rjirsaraie@chead:~            ###


subjects='10134 10136 10142 10145 10156 10158 10280 10333 10357 10577'

directorys=
'/data/joy/BBL/studies/grmpy/rawData/106071/*x10333/
/data/joy/BBL/studies/grmpy/rawData/110828/*x10134/
/data/joy/BBL/studies/grmpy/rawData/118990/*x10156/
/data/joy/BBL/studies/grmpy/rawData/121476/*x10280/
/data/joy/BBL/studies/grmpy/rawData/121670/*x10158/
/data/joy/BBL/studies/grmpy/rawData/129354/*x10357/
/data/joy/BBL/studies/grmpy/rawData/129405/*x10136/
/data/joy/BBL/studies/grmpy/rawData/85083/*x10577/
/data/joy/BBL/studies/grmpy/rawData/90683/*x10142/
/data/joy/BBL/studies/grmpy/rawData/93292/*x10145/'

#First Manually unzip the commpressed file with command (unzip) and remove 0 in front of directory

#Makes standard directories for subjects that were missing dicoms

for d in $directorys; do mkdir ${d}/B0_dicomsM ${d}/B0_dicomsP; done

#Moves the M and P dicoms into their respective directories

for s in $subjects; do mv ~/*${s}/SCANS/*/DICOM/B0map_P*.dcm /data/joy/BBL/studies/grmpy/rawData/*/*x${s}/B0_dicomsP/; done
for s in $subjects; do mv ~/*${s}/SCANS/*/DICOM/B0map_M*.dcm /data/joy/BBL/studies/grmpy/rawData/*/*x${s}/B0_dicomsM/; done

#Cleans up some extra files in your home directory

rm ~/*__MACOSX* ~/*.zip

#If some subjects did not transfer it is likely because they had different names on Xnat and need to be manually adjusted
#The commands below can be used to adjust names, but you must troublehshoot why they were named differently 

#dicoms=$(ls *um0008*.dcm); for d in $dicoms; do d_new=${d//001_um0008_/B0map_M_S008_I}; mv ${d} ${d_new}; done
#dicoms=$(ls *um009*.dcm); for d in $dicoms; do d_new=${d//001_um0009_/B0map_P_S009_I}; mv ${d} ${d_new}; done
#dicoms=$(ls *000009*.dcm); for d in $dicoms; do d_new=${d//001_000009_/B0map_M_S009_I}; mv ${d} ${d_new}; done
#dicoms=$(ls *000010*.dcm); for d in $dicoms; do d_new=${d//001_000010_/B0map_P_S010_I}; mv ${d} ${d_new}; done
