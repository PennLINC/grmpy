#############################################################
#### This script calls the GRMPY data processing scripts ####
#### and combines the results into one csv.              ####
#############################################################

## Create the data-frame to add all summary scores to ##
psycha1_allDataSummaryScores <- read.csv("/data/jux/BBL/studies/grmpy/rawPsycha1/.R")
psycha1_allDataSummaryScores <-psycha1_allDataSummaryScores[ which(grumpy$bbl_protocol %in% "GRMPY") , ] #removes subjects not listed as GRMPY protcol

##Will need to automate the name using Azeez formatting ##
source("/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/summaryScoring/SelfReportScoring.R")
psycha1_allDataSummaryScores <- merge(scored_StateTrait, psycha1_allDataSummaryScores, "bblid", all.x = TRUE, all.y = TRUE)

source("/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/summaryScoring/demographics.R")
psycha1_allDataSummaryScores <- merge(Demo, psycha1_allDataSummaryScores, "bblid", all.x = TRUE, all.y = TRUE)



## Create the final CSV ##
write.csv(psycha1_allDataSummaryScores, paste('/data/jux/BBL/studies/grmpy/rawPsycha1/scored_SelfReport_', currentDate, '.csv', sep = '')
