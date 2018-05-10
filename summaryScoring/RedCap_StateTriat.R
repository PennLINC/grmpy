#In order to run properly, must change all three csv paths to most current csv -- download these csv's from the projects on RedCap. GRMPY Summary scores only uses data from banshee, and not from selkie.
#The csv for this scoring code is downloaded from the "State/Trait Scales #collection" project. Download the "GRMPY (All)" report.
#^^This is the csv you will use for this scoring code.
#Caluclates summary scores for the State and Trait Self-Report scales. 

#### STATE-TRAIT SCALES ####
currentDate<-Sys.Date()

grumpy<-read.csv("/import/monstrum/grmpy/n103DataFreeze/rawData/n103grmpyStateTraitScales20170131.csv")

grumpy<-grumpy[ which(grumpy$bbl_protocol %in% "GRMPY") , ] #removes subjects not listed as GRMPY protcol
grumpy<-grumpy[ which(grumpy$statetrait_vcode %in% "V" | grumpy$statetrait_vcode %in% "U") , ] #removes data not listed as "U" unproctored valid or "V" valid data
grumpy[grumpy ==-9999] <- NA #replaces -9999 with NAs
grumpy<-grumpy[order(grumpy$bblid),]

#ALS-18#
ALS_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
als<-grumpy[,c(grep('als_[0-9]', names(grumpy), value=T))]
als<-als[,c(1:18)]
ALS_SummaryScores$als_avg<-rowMeans(als)
ALS_SummaryScores$als_naflag<-ifelse(complete.cases(als),0,1)
write.csv(ALS_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyALSSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#MAP-SR#
MAPSR_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
mapsr<-grumpy[,c(grep('mapssr_[0-9]', names(grumpy), value=T))]
MAPSR_SummaryScores$mapsr_rawtot_sum<-rowSums(mapsr)
MAPSR_SummaryScores$mapsr_social_sum<-rowSums(mapsr[,c("mapssr_1","mapssr_2","mapssr_3")])
MAPSR_SummaryScores$mapsr_recvoc_sum<-rowSums(mapsr[,c("mapssr_4","mapssr_5","mapssr_6")])
MAPSR_SummaryScores$mapsr_motrelation_sum<-rowSums(mapsr[,c("mapssr_7","mapssr_8","mapssr_9")])
MAPSR_SummaryScores$mapsr_engage_sum<-rowSums(mapsr[,c("mapssr_10","mapssr_11","mapssr_12", "mapssr_13", "mapssr_14", "mapssr_15")])
write.csv(MAPSR_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyMAPSRSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#SWAN-child#
SWAN_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
swan<-grumpy[,c(grep('swan_[0-9]', names(grumpy), value=T))]
swan<-swan[,c(1:18)]
swan$swan_total1<-rowSums(swan[,c('swan_1','swan_2','swan_3','swan_4','swan_5','swan_6','swan_7','swan_8','swan_9')])
swan$swan_total2<-rowSums(swan[,c('swan_10','swan_11','swan_12','swan_13','swan_14','swan_15','swan_16','swan_17','swan_18')])
SWAN_SummaryScores$swan_naflag<-ifelse(complete.cases(swan),0,1) #flags subjects that have NAs
SWAN_SummaryScores$ADHD_Combined<-ifelse((swan$swan_total1 >= 6 & swan$swan_total2 >=6), 1,0)
SWAN_SummaryScores$ADHD_Inattentive<-ifelse((swan$swan_total1 >= 6 & swan$swan_total2 <6), 1,0)
SWAN_SummaryScores$ADHD_Hyperactive<-ifelse((swan$swan_total1 < 6 & swan$swan_total2 >=6), 1,0)
SWAN_SummaryScores$NoADHD<-ifelse((swan$swan_total1 < 6 & swan$swan_total2 < 6), 1,0)
write.csv(SWAN_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpySWANSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#SWAN-collateral#
SWANcoll_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
swancoll<-grumpy[,c(grep('swan_(.*)_c$', names(grumpy), value=T))]
swancoll<-swancoll[,c(1:18)]
swancoll$swan_total1<-rowSums(swancoll[,c('swan_1_c','swan_2_c','swan_3_c','swan_4_c','swan_5_c','swan_6_c','swan_7_c','swan_8_c','swan_9_c')])
swancoll$swan_total2<-rowSums(swancoll[,c('swan_10_c','swan_11_c','swan_12_c','swan_13_c','swan_14_c','swan_15_c','swan_16_c','swan_17_c','swan_18_c')])
SWANcoll_SummaryScores$swan_naflag<-ifelse(complete.cases(swancoll),0,1) #flags subjects that have NAs
SWANcoll_SummaryScores$ADHD_Combined<-ifelse((swancoll$swan_total1 >= 6 & swancoll$swan_total2 >=6), 1,0)
SWANcoll_SummaryScores$ADHD_Inattentive<-ifelse((swancoll$swan_total1 >= 6 & swancoll$swan_total2 <6), 1,0)
SWANcoll_SummaryScores$ADHD_Hyperactive<-ifelse((swancoll$swan_total1 < 6 & swancoll$swan_total2 >=6), 1,0)
SWANcoll_SummaryScores$NoADHD<-ifelse((swancoll$swan_total1 < 6 & swancoll$swan_total2 < 6), 1,0)
write.csv(SWANcoll_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpySWANcollSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#ACES#
ACES_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
aces<-grumpy[,c(grep('aces_[0-9]', names(grumpy), value=T))]
ACES_SummaryScores$aces_total<-rowSums(aces[,c('aces_1','aces_2','aces_3','aces_4','aces_5','aces_6','aces_7','aces_8','aces_9','aces_10')])
ACES_SummaryScores$aces_naflag<-ifelse(complete.cases(aces),0,1) #flags subjects that have NAs
write.csv(ACES_SummaryScores, paste("/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyACESSummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#SCARED#
SCARED_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
scared<-grumpy[,c(grep('scared_[0-9]', names(grumpy), value=T))]
scared<-scared[,c('scared_1','scared_2','scared_3','scared_4','scared_5','scared_6','scared_7','scared_8','scared_9',
                  'scared_10','scared_11','scared_12','scared_13','scared_14','scared_15','scared_16','scared_17','scared_18',
                  'scared_19','scared_20','scared_21','scared_22','scared_23','scared_24','scared_25','scared_26','scared_27',
                  'scared_28','scared_29','scared_30','scared_31','scared_32','scared_33','scared_34','scared_35','scared_36',
                  'scared_37','scared_38','scared_39','scared_40','scared_41')]
SCARED_SummaryScores$scared_total<-rowSums(scared)
SCARED_SummaryScores$AnxietyDisorder<-ifelse(SCARED_SummaryScores$scared_total >=25, 1,0)
SCARED_SummaryScores$scared_naflag<-ifelse(complete.cases(scared),0,1) #flags subjects that have NAs
write.csv(SCARED_SummaryScores, paste("/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpySCAREDSummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#SCARED-collateral#
SCAREDcoll_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
scaredcoll<-grumpy[,c(grep('scared_(.*)_c$', names(grumpy), value=T))]
scaredcoll<-scaredcoll[,c('scared_1_c','scared_2_c','scared_3_c','scared_4_c','scared_5_c','scared_6_c','scared_7_c','scared_8_c','scared_9_c',
                          'scared_10_c','scared_11_c','scared_12_c','scared_13_c','scared_14_c','scared_15_c','scared_16_c','scared_17_c','scared_18_c',
                          'scared_19_c','scared_20_c','scared_21_c','scared_22_c','scared_23_c','scared_24_c','scared_25_c','scared_26_c','scared_27_c',
                          'scared_28_c','scared_29_c','scared_30_c','scared_31_c','scared_32_c','scared_33_c','scared_34_c','scared_35_c','scared_36_c',
                          'scared_37_c','scared_38_c','scared_39_c','scared_40_c','scared_41_c')]
SCAREDcoll_SummaryScores$scaredcoll_total<-rowSums(scaredcoll)
SCAREDcoll_SummaryScores$AnxietyDisorder<-ifelse(SCAREDcoll_SummaryScores$scaredcoll_total >=25, 1,0)
SCAREDcoll_SummaryScores$scaredcoll_naflag<-ifelse(complete.cases(scaredcoll),0,1) #flags subjects that have NAs
write.csv(SCAREDcoll_SummaryScores, paste("/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpySCAREDcollSummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#RPAQ#
RPAQ_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
rpaq<-grumpy[,c(grep('rpaq_[0-9]', names(grumpy), value=T))]
RPAQ_SummaryScores$rpaq_proactivetotal<-rowSums(rpaq[,c('rpaq_2','rpaq_4','rpaq_6','rpaq_9','rpaq_10','rpaq_12','rpaq_15','rpaq_17','rpaq_18', 'rpaq_20','rpaq_21','rpaq_23')])
RPAQ_SummaryScores$rpaq_reactivetotal<-rowSums(rpaq[,c('rpaq_1','rpaq_3','rpaq_5','rpaq_7','rpaq_8','rpaq_11','rpaq_13','rpaq_14','rpaq_16','rpaq_19','rpaq_22')])
RPAQ_SummaryScores$rpaq_naflag<-ifelse(complete.cases(rpaq),0,1) #flags subjects that have NAs
write.csv(RPAQ_SummaryScores, paste("/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyRPAQSummaryScores_", currentDate, ".csv", sep=""), row.names=F)

#ARI#
ARI_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
ari<-grumpy[,c(grep('ari_[0-9]', colnames(grumpy)))]
ari<-ari[,c('ari_1','ari_2','ari_3','ari_4','ari_5','ari_6')]
ARI_SummaryScores$ari_avg<-rowMeans(ari)
ARI_SummaryScores$ari_total<-rowSums(ari)
ARI_SummaryScores$ari_naflag<-ifelse(complete.cases(ari),0,1) #flags subjects that have NAs
write.csv(ARI_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyARISummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#ARI-collateral#
ARIcoll_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
aricoll<-grumpy[,c(grep('ari_(.*)_c$', colnames(grumpy)))]
aricoll<-aricoll[,c('ari_1_c','ari_2_c','ari_3_c','ari_4_c','ari_5_c','ari_6_c')]
ARIcoll_SummaryScores$ari_total<-rowSums(aricoll)
ARIcoll_SummaryScores$ari_avg<-rowMeans(aricoll)
ARIcoll_SummaryScores$ari_naflag<-ifelse(complete.cases(aricoll),0,1) #flags subjects that have NAs 
write.csv(ARIcoll_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyARIcollSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#BDI#
BDI_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
bdi<-grumpy[,c(grep('bdi_[0-9]', colnames(grumpy)))]
bdi<-bdi[, !colnames(bdi) %in% c('bdi_19a')] #removes question 19a from BDI scoring
BDI_SummaryScores$bdi_NAflag<-ifelse(complete.cases(bdi),0,1)
BDI_SummaryScores$bdi_total<-rowSums(bdi)
write.csv(BDI_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyBDISummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#BISBAS#
BISBAS_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
bisbas<-grumpy[,c(grep('bisbas_[0-9]', colnames(grumpy)))]
bis1<-bisbas[,c('bisbas_8','bisbas_13','bisbas_16','bisbas_19','bisbas_24')]
bis2<-bisbas[,c('bisbas_2','bisbas_22')]
bis1<-(4-bis1)+1 #reverse code scores in bis1 (not bis2) so that 4=1, 3=2, 2=3, 1=4
bis3<-cbind(bis1,bis2)
BISBAS_SummaryScores$bistotal<-rowSums(bis3) #sum scores after reverse coding
bas_drive<-bisbas[,c('bisbas_3','bisbas_9','bisbas_12','bisbas_21')]
bas_drive<-(4-bas_drive)+1 #reverse code scores in bas_drive
BISBAS_SummaryScores$basdrive_total<-rowSums(bas_drive) 
bas_fun<-bisbas[,c('bisbas_5','bisbas_10','bisbas_15','bisbas_20')]
bas_fun<-(4-bas_fun)+1 #reverse code scores in bas_fun
bas_fun_sum<-(bas_fun)
BISBAS_SummaryScores$basfun_total<-rowSums(bas_fun_sum)
bas_reward<-bisbas[,c('bisbas_4','bisbas_7','bisbas_14','bisbas_18','bisbas_23')]
bas_reward<-(4-bas_reward)+1 #reverse code scores in bas_reward
BISBAS_SummaryScores$basreward_total<-rowSums(bas_reward)
write.csv(BISBAS_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyBISBASSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#GRIT#
GRIT_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
grit<-grumpy[,c(grep('grit_[0-9]', colnames(grumpy)))]
grittiness<-grit[,c('grit_2','grit_4','grit_5','grit_7','grit_8','grit_10')]
openness<-grit[,c('grit_1','grit_3','grit_6','grit_9','grit_11','grit_12')]
GRIT_SummaryScores$grit_grittiness<-rowMeans(grittiness)
GRIT_SummaryScores$grit_openness<-rowMeans(openness)
grit$NAflag<-ifelse(complete.cases(grit),0,1) #flags subjects that have NAs 
GRIT_SummaryScores$grit_naflag<-grit[,c('NAflag')]
write.csv(GRIT_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyGRITSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#HCL#
HCL_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
hcl<-grumpy[,c(grep('hcl16_3_[0-9]', names(grumpy), value=T))]
HCL_SummaryScores$hcl_total<-rowSums(hcl)
write.csv(HCL_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyHCLSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#BSS#
BSS_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
bss<-grumpy[,c(grep('bss_[0-9]', colnames(grumpy)))]
BSS_SummaryScores$bss_mean<-rowMeans(bss)
bss$NAflag<-ifelse(complete.cases(bss),0,1) #flags subjects that have NAs
bss_exp<-bss[,c('bss_1','bss_5')]
bss_experience<-rowMeans(bss_exp)
BSS_SummaryScores$bss_experience<-bss_experience
bss_bore<-bss[,c('bss_2','bss_6')]
bss_boredom<-rowMeans(bss_bore)
BSS_SummaryScores$bss_boredom<-bss_boredom
bss_thrl<-bss[,c('bss_3','bss_7')]
bss_thrill<-rowMeans(bss_thrl)
BSS_SummaryScores$bss_thrill<-bss_thrill
bss_disinhib<-bss[,c('bss_4','bss_8')]
bss_disinhibition<-rowMeans(bss_disinhib)
BSS_SummaryScores$bss_disinhibition<-bss_disinhibition
BSS_SummaryScores$bss_naflag<-bss[,c('NAflag')]
write.csv(BSS_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyBSSSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#RPASshort#
RPASSHORT_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
rpasshort<-grumpy[,c(grep('phys_anhed_[0-9]', colnames(grumpy)))]
rpasshort1<-rpasshort[,c('phys_anhed_5','phys_anhed_6','phys_anhed_8','phys_anhed_10')]
rpasshort2<-rpasshort[,c('phys_anhed_1','phys_anhed_2','phys_anhed_3','phys_anhed_4','phys_anhed_7','phys_anhed_9', "phys_anhed_11", "phys_anhed_12", "phys_anhed_13", "phys_anhed_14", "phys_anhed_15")]
rpasshort2<-(1-rpasshort2) #reverse code items in rpasshort2
rpasshort3<-cbind(rpasshort1,rpasshort2)
rpasshort3$NAflag<-ifelse(complete.cases(rpasshort3),0,1) #flags subjects that have NAs and have estimated or missing totals
RPASSHORT_SummaryScores$rpasshort_total<-rowSums(rpasshort3[,c(1:15)])
RPASSHORT_SummaryScores$rpasshort_naflag<-rpasshort3[,c('NAflag')]
write.csv(RPASSHORT_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyRPASshortSummaryScores_', currentDate, '.csv', sep=''), row.names=F)

#RSASshort#
RSASSHORT_SummaryScores<-grumpy[,c('bblid'), drop=FALSE]
rsasshort<-grumpy[,c(grep('soc_anhed_[0-9]', colnames(grumpy)))]
rsasshort1<-rsasshort[,c('soc_anhed_1','soc_anhed_2','soc_anhed_3','soc_anhed_5','soc_anhed_6','soc_anhed_7','soc_anhed_8','soc_anhed_10','soc_anhed_15')]
rsasshort2<-rsasshort[,c('soc_anhed_4','soc_anhed_9','soc_anhed_11','soc_anhed_12','soc_anhed_13','soc_anhed_14')]
rsasshort2<-(1-rsasshort2) #reverse code items in rsasshort2
rsasshort3<-cbind(rsasshort1,rsasshort2)
rsasshort3$NAflag<-ifelse(complete.cases(rsasshort3),0,1) #flags subjects that have NAs and have estimated or missing totals
RSASSHORT_SummaryScores$rsasshort_total<-rowSums(rsasshort3[,c(1:15)])
RSASSHORT_SummaryScores$rsasshort_naflag<-rsasshort3[,c('NAflag')]
write.csv(RSASSHORT_SummaryScores, paste('/import/monstrum/grmpy/n103DataFreeze/summaryScores/n103grmpyRSASshortSummaryScores_', currentDate, '.csv', sep=''), row.names=F)