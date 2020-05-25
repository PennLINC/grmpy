# GRMPY: Study Documentation (This Page Is In Development)


Written By: Diego G. Dávila




# Image Processing Workflow
This is documentation of how GRMPY_822831 was processed on Flywheel. 

## Steps Overview:
Each step is a flywheel gear that has been launched on each subject in the project.
1. Heudiconv
2. fMRIPREP
3. XCP - CBF
4. XCP - Resting State Functional
5. XCP - Task Functional

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


## Step 3: XCP - CBF


**Gear Name:** XCPENGINE: pipeline for processing of structural and functional data.


**Version:** 0.0.1_1.00


**Inputs:**

fMRIPREP Output: fmriprep_filename.zip

Design File: cbf_scorescrub_basil_v3.dsn

ASL Nifti: asl_image.nii.gz


**Gear Configuration:**

analysis_type:	cbf


**Output:**

Processed Output: xcpEngineouput_cbf.zip

Cohort File: cohortfile.csv


## Step 4: XCP - Resting State Functional


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


## Step 5: N-Back Task

The n-back task logfiles were scored using [this notebook](https://github.com/PennLINC/grmpy/blob/gh-pages/grmpy_nback_scoreALL.ipynb), with [this template file](https://github.com/PennLINC/grmpy/blob/gh-pages/grympytemplate.xml). The output csv was uploaded to Flywheel using the [Custom Info Uploader](https://pennlinc.github.io/docs/flywheel/usingCustomInfoUploader/). 

### XCP - Task Functional

**Gear Name:** XCPENGINE: pipeline for processing of structural and functional data.


**Version:** 0.0.1_1.00


**Inputs:**

fMRIPREP Output: fmriprep_filename.zip

Design File:

Zip of necessary files: taskfile.zip

*Note:* files within the .zip are:

0back.txt

1back.txt

2back.txt

inst.txt

task.json


**Gear Configuration:**

analysis type:	task

analysis type:	xcp


**Output:**

Processed Output: xcpEngineouput_xcp.zip

Cohort File: cohortfile.csv


# ASL Source Documentation

While the majority of ASL sequences in GRMPY were acquired as dicoms and converted to niftis, some were collected as unreconstructed .dat files and subsequently converted to niftis.
Those subjects who had their ASL sequences collected as .dat files and converted to niftis had their M0 attached as the last two slices.
These M0 slices were cut into their own nifti file, and were uploaded to Flywheel along with the ASL nifti, to an acquisition called 'ASL'. The asl nifti was named 'asl_reconstructed', and the m0 nifti was named "m0_reconstructed".

The original .dat files are currently backed up in the GRMPY drive, as well as CUBIC.

The following subjects had their ASL and M0 derived from .dat files:

| bblid | scanid |
|-------|--------|
| 103679 | 10110 |
| 105979 | 10067 |
| 110168 | 10095 |
| 110828 | 10134 |
| 112061 | 10056 |
| 112126 | 9968 |
| 113111 | 9958 |
| 114713 | 10107 |
| 114990 | 10096 |
| 116019 | 10078 |
| 116051 | 10098 |
| 116210 | 10102 |
| 116360 | 10097 |
| 117226 | 10074 |
| 118393 | 10094 |
| 118864 | 10127 |
| 118990 | 10156 |
| 119302 | 10122 |
| 119791 | 10082 |
| 121085 | 10015 |
| 121670 | 10158 |
| 122916 | 10114 |
| 125535 | 10150 |
| 125554 | 10058 |
| 126903 | 10112 |
| 127305 | 10152 |
| 127542 | 10115 |
| 128061 | 10153 |
| 129405 | 10136 |
| 129926 | 10111 |
| 130211 | 10106 |
| 130759 | 10137 |
| 130896 | 9956 |
| 132224 | 10151 |
| 139272 | 10109 |
| 81760 | 10132 |
| 82051 | 9947 |
| 82492 | 10046 |
| 82790 | 10059 |
| 83010 | 10101 |
| 83454 | 10161 |
| 83999 | 10099 |
| 84103 | 9970 |
| 84973 | 10075 |
| 85173 | 10069 |
| 85853 | 10103 |
| 86287 | 10083 |
| 86350 | 9955 |
| 86444 | 10076 |
| 86924 | 10035 |
| 87135 | 9969 |
| 87457 | 10081 |
| 87538 | 9942 |
| 87804 | 10026 |
| 87990 | 9995 |
| 88209 | 10057 |
| 88608 | 10165 |
| 90060 | 10180 |
| 90262 | 10131 |
| 90281 | 10147 |
| 90683 | 10142 |
| 91919 | 10117 |
| 92554 | 10133 |
| 93051 | 10149 |
| 93169 | 10113 |
| 93278 | 10148 |
| 93292 | 10145 |
| 93406 | 10138 |
| 93734 | 10092 |
| 93787 | 10163 |
| 94848 | 10121 |
| 98314 | 10120 |
| 98394 | 10025 |
| 98831 | 10084 |
| 99352 | 10126 |
| 99964 | 10105 |


# GRMPY Self-Report and N-Back Task Scoring


The GRMPY Self-Report Scales were scored and uploaded using the Custom-Info Upload Tool detailed in the [Self-Report Score and Upload Gear](https://pennlinc.github.io/docs/flywheel/uploadingDocs/). The scoring code is an R script that can be found [here](https://github.com/PennLINC/grmpy/blob/gh-pages/summaryScoring/GRMPY_selfReportScoringCode_v4.R).

