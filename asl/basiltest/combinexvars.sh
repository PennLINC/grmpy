
out=/data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/basil
qout=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest
${XCPEDIR}/utils/combineOutput \
   -p  ${out} \
   -f "*quality.csv" \
   -o GRMPYBASIL_QAVARS1.csv
mv -f ${out}/GRMPYBASIL_QAVARS1.csv ${qout}/GRMPYBASIL_QAVARS1.csv
xcpVars=$(cat ${qout}/GRMPYBASIL_QAVARS1.csv|sed s@'subject\[0\]'@'bblid'@g|sed s@'subject\[1\]'@'datexscanid'@g)
for s in $xcpVars
   do
   s=$(echo $s|cut -d',' -f1),$(echo $s|cut -d'x' -f2-)
   echo $s >> ${qout}/GRMPYBASIL_QAVARS.csv
done
