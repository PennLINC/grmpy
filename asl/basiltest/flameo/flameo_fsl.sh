

# read both bblid  to get the images into shape 
cbfbblid=$(cat /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/cbfbblid.txt)
basbblid=$(cat /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/basbblid.txt)

## read the four covariance
grcbfcov=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/grcbf_cov.mat
grbascov=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/grbas_cov.mat
pncbfcov=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/pncbf_cov.mat
pnbascov=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/pnbas_cov.mat 

## read contrast and group 
contrast=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/contrast.con
cbfgroup=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/cbfgroup.grp
basgroup=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/basgroup.grp

datadir=/data/jux/BBL/studies/grmpy/processedData/basil_asl
maskfile=/data/joy/BBL/studies/pnc/template/pnc_template_brain_2mm.nii.gz
for i in $cbfbblid; do 
   img1=$(ls -d $datadir/grmpy/cbf/${i}/*/norm/*_meanPerfusionStd.nii.gz)
   img2=$(ls -d $datadir/pnc/cbf/${i}/*/norm/*_meanPerfusionStd.nii.gz)  
    echo $img1 >> $datadir/grmpy/flameo/grcbflist.csv
    echo $img1 >> $datadir/pnc/flameo/pncbflist.csv
done 


for i in $basbblid; do 
   img1=$(ls -d $datadir/grmpy/basil/${i}/*/norm/*_cbf_pv_calibStd.nii.gz)
   img2=$(ls -d $datadir/pnc/basil/${i}/*/norm/*_cbf_pv_calibStd.nii.gz)  
    echo $img1 >> $datadir/grmpy/flameo/grbaslist.csv
    echo $img1 >> $datadir/pnc/flameo/pncbaslist.csv
done



## convert the list to line
cbgr=$(paste -s -d ' ' $datadir/grmpy/flameo/grcbflist.csv)
cbpn=$(paste -s -d ' ' $datadir/pnc/flameo/pncbflist.csv)
bsgr=$(paste -s -d ' ' $datadir/grmpy/flameo/grbaslist.csv)
bspn=$(paste -s -d ' ' $datadir/pnc/flameo/pncbaslist.csv)

#merge the volume 
fslmerge -t \
   $datadir/grmpy/flameo/grcbf.nii.gz \
   $cbgr

fslmerge -t \
   $datadir/grmpy/flameo/grbas.nii.gz \
   $bsgr

fslmerge -t \
   $datadir/pnc/flameo/pncbf.nii.gz \
   $cbpn

fslmerge -t \
   $datadir/pnc/flameo/pnbas.nii.gz \
   $bspn




## run the flameo 
flameo --copefile=$datadir/grmpy/flameo/grcbf.nii.gz  --mask=$maskfile  --dm=$grcbfcov --tc=$contrast --cs=$cbfgroup --runmode=flame1 --ld=$datadir/grmpy/flameo/cbfstats


flameo --copefile=$datadir/grmpy/flameo/grbas.nii.gz  --mask=$maskfile  --dm=$grbascov --tc=$contrast --cs=$basgroup --runmode=flame1 --ld=$datadir/grmpy/flameo/basilstats


flameo --copefile=$datadir/pnc/flameo/pncbf.nii.gz  --mask=$maskfile  --dm=$pncbfcov --tc=$contrast --cs=$cbfgroup --runmode=flame1 --ld=$datadir/pnc/flameo/cbfstats


flameo --copefile=$datadir/pnc/flameo/pnbas.nii.gz  --mask=$maskfile  --dm=$pnbascov --tc=$contrast --cs=$basgroup --runmode=flame1 --ld=$datadir/pnc/flameo/basilstats




