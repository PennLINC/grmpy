####################################################
##### This script is meant to be used with the #####
##### psycha1 demographics file found in       #####
##### /data/jux/BBL/studies/grmpy/rawPsycha1/  #####
##### demographics_currentDate.csv             #####
####################################################

currentDate <- format(Sys.Date(), "%Y%m%d")

############################################
##### Read in the Raw Demographic File #####
############################################

Demo<-read.csv("/data/jux/BBL/studies/grmpy/rawPsycha1/demographics_20180803.csv")

###################################
##### Remove Unneeded Columns #####
###################################

Demo <- subset(Demo, select = -c(entry,istatus,cstatus,staff,location,phasenum, intake_study,common_enroll,study_coordinator,study_category,study_siteid,study_famid,study_subid,study_entry,deg_rel_proband,study_endreason,study_notes))

#################################################
##### Recode Variables that Need Processing #####
#################################################

Demo$visitageyears<-Demo$visitagemonths/12
Demo$parent_educ_avg <- (Demo$mom_educ + Demo$dad_educ)/2

#######################
##### Save Output #####
#######################

write.csv(Demo, "/data/jux/BBL/studies/grmpy/processedPsycha1/demographics_",currentDate, ".csv", sep = "")
