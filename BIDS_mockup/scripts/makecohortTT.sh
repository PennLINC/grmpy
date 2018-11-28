
bblid=$(cat /data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/BIDS_mockup/scripts/bblidTT.txt)
rm cohortfile.csv

echo "id0,id1,img" >> cohortfile.csv

for b in $bblid; do 

img1=$(ls -d /data/jux/BBL/studies/grmpy/BIDS/*$b/ses-02/anat/*${b}_ses-02_T1w.nii.gz)


echo "$b,ses-02,$img1" >> cohortfile.csv

done 

