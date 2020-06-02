# GRMPY: Study Documentation (This Page Is In Development)

Written By: Diego G. Dávila

1. TOC
{:toc}

# ASL Source Documentation

The ASL sequences in GRMPY were acquired in distinct ways throughout data collection. Resultantly, the ASL acquisitions in GRMPY can roughly be divided into 3 groups based on their origin, and method of acquisition.

## Group 1

While the majority of ASL sequences in GRMPY were acquired as dicoms and converted to niftis, some were collected as unreconstructed .dat files and subsequently converted to niftis.
Those subjects who had their ASL sequences collected as .dat files and converted to niftis had their M0 attached as the last two slices.
These M0 slices were cut into their own nifti file, and were uploaded to Flywheel along with the ASL nifti, to an acquisition called 'ASL'. The asl nifti was named 'asl_reconstructed', and the m0 nifti was named "m0_reconstructed".

The original .dat files could not be uploaded to Flywheel, but they can be found in the following CUBIC directory: ```/cbica/projects/diego_networks/ASL_recon_backup/DAT```

[This list](https://github.com/PennLINC/grmpy/blob/gh-pages/referenceFiles/grmpy_asl_reconlist.csv) of subjects had their ASL and M0 derived from .dat files:

## Group 2

[This list](https://github.com/PennLINC/grmpy/blob/gh-pages/referenceFiles/grmpy_asl_group2.csv) of subjects' ASL sequences have associated dicoms, and the following naming convention:

ASL Sequence: ASL_3DSPIRAL_V20_GE_ASL

M0 Sequence: ASL_3DSPIRAL_V20_GE_M0

Mean CBF: ASL_3DSPIRAL_V20_GE_MeanPerf

## Group 3 (PROBLEMATIC)

[This list](https://github.com/PennLINC/grmpy/blob/gh-pages/referenceFiles/grmpy_asl_group3.csv) of subjects' ASL sequences have associated dicoms. This group has several names within each acquisiton that do not distinguish between images. 

In order to differentiate between ASL, M0, and Mean Perfusion, refer to BIDS view in the GUI, or BIDS Info via the SDK. 
This group also has two M0 images per acquisiton. However, one M0 is nominal, and another is low quality. As of 6/2/20, the only way of determining which M0 to use is by sight. Some M0s do not have proper associated metadata. 

Solution as of 6/2/2020, as per meeting with Ted, Diego, and Azeez: 
1. Refer users to BIDS info or BIDS view to differentiate between ASL, M0, and Mean Perfusion images. 
2. Determine the "bad" M0 images and delete them manually. 
3. Copy over proper associated metadata onto the correct M0s, from the ASL metadata. 



# Image Processing Workflow
This is documentation of how GRMPY_822831 was processed on Flywheel. 

## Steps Overview
Each step is a flywheel gear that has been launched on each subject in the project.
1. Heudiconv
2. fMRIPREP
3. XCP - Task Functional
4. XCP - CBF
5. XCP - Resting State Functional

## Step 1: Heudiconv


**Gear Name:** Flywheel HeuDiConv (fw-heudiconv)


**Version:** 0.2.10_0.2.4


**Inputs:**

Heuristic: [grmpy_heuristic_v4.py](https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/grmpy_heuristic_v4.py)


[**Gear Configuration**](https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/heudiconvConfiguration.json)


**Output:** None. This curates the project in BIDS.


**Note:** When Processing GRMPY_822831, heudiconv was run on each subject individually. This is why do_whole_project was set to false.


## Step 2: fMRIPREP


**Gear Name:** fMRIPREP: A Robust Preprocessing Pipeline for fMRI Data [fw-heudiconv]


**Version:** 0.3.2_20.0.7


**Inputs:** license.txt (This is a [freesurfer](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki) license)


[**Gear Configuration**](https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/fmriprepConfiguration.json)


**Output:**

An html report: filename.html.zip

Processed Output: fmriprep_filename.zip

Source Code: fmriprep_run.sh

## Step 3: N-Back Task

### N-Back Logfile Scoring

The n-back task logfiles were scored using [this notebook](https://github.com/PennLINC/grmpy/blob/gh-pages/grmpy_nback_scoreALL.ipynb), with [this template file](https://github.com/PennLINC/grmpy/blob/gh-pages/grympytemplate.xml). The output csv was uploaded to Flywheel using the [Custom Info Uploader](https://pennlinc.github.io/docs/flywheel/usingCustomInfoUploader/). 

### XCP - Task Functional

**Gear Name:** XCPENGINE: pipeline for processing of structural and functional data.


**Version:** 0.0.2_1.2.1


**Inputs:**

fMRIPREP Output: fmriprep_filename.zip (This is unique to each subject)

[Design File](https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/task2.dsn)

Zip of necessary files: [taskfile.zip](https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/taskfile2.zip)


[**Gear Configuration**](https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/xcp_task_config.json)


**Output:**

Processed Output: xcpEngineouput_xcp.zip

Cohort File: cohortfile.csv



## Step 4: XCP - CBF


**Gear Name:** XCPENGINE: pipeline for processing of structural and functional data.


**Version:** 0.0.2_1.2.1


**Inputs:**

fMRIPREP Output: fmriprep_filename.zip (This is unique to each subject)

[Design File](https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/cbf_new2.dsn)

ASL Nifti: asl_image.nii.gz (This is unique to each subject)


[**Gear Configuration**](https://github.com/PennLINC/grmpy/blob/gh-pages/inputFiles/xcp_cbf_config.json)


**Output:**

Processed Output: xcpEngineouput_cbf.zip

Cohort File: cohortfile.csv


## Step 5: XCP - Resting State Functional


**Gear Name:** XCPENGINE: pipeline for processing of structural and functional data.


**Version:** 0.0.1_1.00


**Inputs:**

fMRIPREP Output: fmriprep_filename.zip

Design File: fc-36p_despike.dsn


**Gear Configuration:**

analysis type:	func

analysis type:	xcp


**Output:**

Processed Output: xcpEngineouput_xcp.zip

Cohort File: cohortfile.csv


# GRMPY Self-Report Scoring


The GRMPY Self-Report Scales were scored and uploaded using the Custom-Info Upload Tool detailed in the [Self-Report Score and Upload Gear](https://pennlinc.github.io/docs/flywheel/uploadingDocs/). The scoring code is an R script that can be found [here](https://github.com/PennLINC/grmpy/blob/gh-pages/summaryScoring/GRMPY_selfReportScoringCode_v4.R).

