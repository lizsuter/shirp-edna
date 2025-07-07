---
title: "Analysis Pipeline for MiFish/ Elas02/ mlCO1-generated amplicons, 2020-2024, SHiRP Project"
output: html_notebook
editor_options: 
  chunk_output_type: inline
---

### 10/18/2024

Earlier this year I started using [REVAMP](https://github.com/McAllister-NOAA/REVAMP) for analysis of the Elas02 libraries. Now start implementing for the MiFish libraries, which are generally larger, more diverse, and there are more years of data.

Already made my local MiFIsh reference library using [rCRUX](https://github.com/CalCOFI/rCRUX). See my [eDNA databases repo](https://github.com/lizsuter/eDNA-databases) for notes on that.

I also have installed REVAMP and its dependencies in the REVAMPenv environment on my local computer. For notes on how I did this, see [Elas02-notebook](ElasO2-nbotebook.md) in this repo.

### Check software
```
conda activate REVAMPenv
cutadapt --version
taxonkit version

```
cutadapt 3.7  
taxonkit v0.5.0


[Install/update Krona](https://github.com/marbl/Krona/wiki/Installing)

```
cd ~/software
curl -LOk https://github.com/marbl/Krona/releases/download/v2.7/KronaTools-2.7.tar
tar xvf KronaTools-2.7.tar
cd KronaTools-2.7
./install.pl
./updateTaxonomy.sh
```

### Run REVAMP on 2020 MiFish data
#### 10/23/24

- Set up config files 
	- Had to make sure sample names had `L001` and everything else before the R1/R2.fastq.gz
	- REVAMP puts `MP_` infront of all fastq file names. If need to rerun this doesn't know what to do bc now file names have been modified. To rename them:

	```
	for file in * ; do
		echo mv -v "$file" "${file#*_}"
	done

	for file in * ; do
    	mv -v "$file" "${file#*_}"
	done
	```
- Set up results directory
- Copy configuration files into results directory and rename
- cd into `shirp-edna`, activate virtual env `conda activate REVAMPenv` and run:


```
revamp.sh -p 01_config_file_MIFish-2020txt.txt -f 02_figure_config_file_MiFish-2020.txt -s 03_sample_metadata_MiFIsh-2020.txt -r raw_data/2020-MiFish-U -o results-revamp-2020-MiFish
```

cutadapt output:

```
Sample	Passing Reads	Passing bp
MP_T1PosCon_S11_L001	89.4%	80.4%
MP_T1S1_S1_L001	98.0%	83.2%
MP_T1S2_S2_L001	96.2%	71.0%
MP_T1S3_S3_L001	85.6%	79.0%
MP_T1S5_S4_L001	91.6%	81.1%
MP_T1S6_S5_L001	98.5%	79.4%
MP_T1S7_S6_L001	83.4%	78.0%
MP_T1S8_S7_L001	98.4%	83.1%
MP_T1S9_S8_L001	94.6%	82.3%
MP_T1S10_S9_L001	98.9%	78.1%
MP_T1S11_S10_L001	97.7%	83.1%
MP_T2PosCon_S21_L001	99.4%	83.5%
MP_T2S1_S12_L001	98.3%	73.3%
MP_T2S2_S13_L001	97.8%	83.1%
MP_T2S3_S14_L001	98.1%	83.2%
MP_T2S4_S15_L001	87.4%	79.8%
MP_T2S5_S16_L001	98.8%	76.9%
MP_T2S6_S17_L001	92.6%	81.3%
MP_T2S9_S18_L001	99.0%	83.5%
MP_T2S10_S19_L001	98.2%	73.0%
MP_T2S11_S20_L001	90.5%	80.7%
MP_T3PosCon_S33_L001	86.9%	69.2%
MP_T3S1_S22_L001	70.2%	72.8%
MP_T3S2_S23_L001	97.7%	82.4%
MP_T3S3_S24_L001	96.2%	53.2%
MP_T3S4_S25_L001	82.6%	77.7%
MP_T3S5_S26_L001	74.6%	74.4%
MP_T3S6_S27_L001	94.1%	82.0%
MP_T3S7_S28_L001	93.7%	80.1%
MP_T3S8_S29_L001	97.1%	82.7%
MP_T3S9_S30_L001	95.9%	82.6%
MP_T3S10_S31_L001	90.9%	80.8%
MP_T3S11_S32_L001	64.9%	69.7%
MP_T4S1_S34_L001	97.4%	83.0%
MP_T4S2_S35_L001	77.9%	76.2%
MP_T4S3_S36_L001	97.3%	82.7%
MP_T4S4_S37_L001	96.0%	77.5%
MP_T4S5_S38_L001	93.6%	79.5%
MP_T4S6_S39_L001	93.4%	80.4%
MP_T4S7_S40_L001	93.2%	81.6%
MP_T4S8_S41_L001	91.2%	81.0%
MP_T4S9_S42_L001	77.7%	76.2%
MP_T4S10_S43_L001	89.3%	80.2%
MP_T4S11_S44_L001	98.3%	80.6%
MP_T5S1_S45_L001	95.3%	82.1%
MP_T5S2_S46_L001	96.3%	82.2%
MP_T5S3_S47_L001	97.8%	83.0%
MP_T5S4_S48_L001	96.4%	82.4%
MP_T5S5_S49_L001	83.8%	78.2%
MP_T5S6_S50_L001	89.2%	79.8%
MP_T5S7_S51_L001	97.9%	77.0%
MP_T5S8_S52_L001	96.4%	82.3%
MP_T5S9_S53_L001	96.0%	82.3%
MP_T5S10_S54_L001	92.8%	81.3%
MP_T5S11_S55_L001	84.5%	78.3%
```


dada2 filtering output:

```
DADA2 Filtering results:
Sample	% Reads Passing
MP_T1PosCon_S11_L001_R1_trimmed.fq.gz 97.131
MP_T1S1_S1_L001_R1_trimmed.fq.gz 96.093
MP_T1S2_S2_L001_R1_trimmed.fq.gz 66.2141
MP_T1S3_S3_L001_R1_trimmed.fq.gz 96.3623
MP_T1S5_S4_L001_R1_trimmed.fq.gz 96.1853
MP_T1S6_S5_L001_R1_trimmed.fq.gz 84.3081
MP_T1S7_S6_L001_R1_trimmed.fq.gz 95.3686
MP_T1S8_S7_L001_R1_trimmed.fq.gz 94.4446
MP_T1S9_S8_L001_R1_trimmed.fq.gz 97.1403
MP_T1S10_S9_L001_R1_trimmed.fq.gz 79.495
MP_T1S11_S10_L001_R1_trimmed.fq.gz 96.5
MP_T2PosCon_S21_L001_R1_trimmed.fq.gz 95.9237
MP_T2S1_S12_L001_R1_trimmed.fq.gz 67.2795
MP_T2S2_S13_L001_R1_trimmed.fq.gz 96.2759
MP_T2S3_S14_L001_R1_trimmed.fq.gz 96.1139
MP_T2S4_S15_L001_R1_trimmed.fq.gz 96.4248
MP_T2S5_S16_L001_R1_trimmed.fq.gz 77.6568
MP_T2S6_S17_L001_R1_trimmed.fq.gz 96.3
MP_T2S9_S18_L001_R1_trimmed.fq.gz 96.6934
MP_T2S10_S19_L001_R1_trimmed.fq.gz 68.3317
MP_T2S11_S20_L001_R1_trimmed.fq.gz 95.0047
MP_T3PosCon_S33_L001_R1_trimmed.fq.gz 67.7082
MP_T3S1_S22_L001_R1_trimmed.fq.gz 95.9243
MP_T3S2_S23_L001_R1_trimmed.fq.gz 94.4852
MP_T3S3_S24_L001_R1_trimmed.fq.gz 32.0306
MP_T3S4_S25_L001_R1_trimmed.fq.gz 95.4921
MP_T3S5_S26_L001_R1_trimmed.fq.gz 95.4432
MP_T3S6_S27_L001_R1_trimmed.fq.gz 96.7432
MP_T3S7_S28_L001_R1_trimmed.fq.gz 90.7506
MP_T3S8_S29_L001_R1_trimmed.fq.gz 95.2668
MP_T3S9_S30_L001_R1_trimmed.fq.gz 95.749
MP_T3S10_S31_L001_R1_trimmed.fq.gz 95.3298
MP_T3S11_S32_L001_R1_trimmed.fq.gz 93.9806
MP_T4S1_S34_L001_R1_trimmed.fq.gz 94.91
MP_T4S2_S35_L001_R1_trimmed.fq.gz 95.3852
MP_T4S3_S36_L001_R1_trimmed.fq.gz 94.6224
MP_T4S4_S37_L001_R1_trimmed.fq.gz 78.4188
MP_T4S5_S38_L001_R1_trimmed.fq.gz 91.8904
MP_T4S6_S39_L001_R1_trimmed.fq.gz 90.3387
MP_T4S7_S40_L001_R1_trimmed.fq.gz 95.3682
MP_T4S8_S41_L001_R1_trimmed.fq.gz 96.6974
MP_T4S9_S42_L001_R1_trimmed.fq.gz 96.4841
MP_T4S10_S43_L001_R1_trimmed.fq.gz 96.7352
MP_T4S11_S44_L001_R1_trimmed.fq.gz 88.8388
MP_T5S1_S45_L001_R1_trimmed.fq.gz 96.8663
MP_T5S2_S46_L001_R1_trimmed.fq.gz 94.0056
MP_T5S3_S47_L001_R1_trimmed.fq.gz 96.3444
MP_T5S4_S48_L001_R1_trimmed.fq.gz 95.5674
MP_T5S5_S49_L001_R1_trimmed.fq.gz 96.1867
MP_T5S6_S50_L001_R1_trimmed.fq.gz 94.4973
MP_T5S7_S51_L001_R1_trimmed.fq.gz 77.6405
MP_T5S8_S52_L001_R1_trimmed.fq.gz 95.8601
MP_T5S9_S53_L001_R1_trimmed.fq.gz 95.872
MP_T5S10_S54_L001_R1_trimmed.fq.gz 96.1737
MP_T5S11_S55_L001_R1_trimmed.fq.gz 94.9083
```

Merging stats:

```
FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_T1PosCon_S11_L001 95.2
MP_T1S1_S1_L001 88.8
MP_T1S2_S2_L001 62.9
MP_T1S3_S3_L001 93.9
MP_T1S5_S4_L001 86.7
MP_T1S6_S5_L001 83
MP_T1S7_S6_L001 0
MP_T1S8_S7_L001 0.1
MP_T1S9_S8_L001 87.6
MP_T1S10_S9_L001 76.2
MP_T1S11_S10_L001 86.9
MP_T2PosCon_S21_L001 94.7
MP_T2S1_S12_L001 62
MP_T2S2_S13_L001 82.7
MP_T2S3_S14_L001 90.3
MP_T2S4_S15_L001 86.1
MP_T2S5_S16_L001 69.8
MP_T2S6_S17_L001 82.6
MP_T2S9_S18_L001 81.3
MP_T2S10_S19_L001 61.8
MP_T2S11_S20_L001 55.7
MP_T3PosCon_S33_L001 67.1
MP_T3S1_S22_L001 81.8
MP_T3S2_S23_L001 80.5
MP_T3S3_S24_L001 23.8
MP_T3S4_S25_L001 70
MP_T3S5_S26_L001 47.8
MP_T3S6_S27_L001 85
MP_T3S7_S28_L001 83.3
MP_T3S8_S29_L001 78.9
MP_T3S9_S30_L001 77.3
MP_T3S10_S31_L001 80.8
MP_T3S11_S32_L001 1.2
MP_T4S1_S34_L001 79
MP_T4S2_S35_L001 91
MP_T4S3_S36_L001 87
MP_T4S4_S37_L001 63.6
MP_T4S5_S38_L001 69.1
MP_T4S6_S39_L001 84.4
MP_T4S7_S40_L001 88.6
MP_T4S8_S41_L001 85.3
MP_T4S9_S42_L001 91.4
MP_T4S10_S43_L001 81.6
MP_T4S11_S44_L001 83.2
MP_T5S1_S45_L001 87.7
MP_T5S2_S46_L001 80.1
MP_T5S3_S47_L001 91.9
MP_T5S4_S48_L001 84.2
MP_T5S5_S49_L001 88.3
MP_T5S6_S50_L001 90
MP_T5S7_S51_L001 67.1
MP_T5S8_S52_L001 90
MP_T5S9_S53_L001 84.7
MP_T5S10_S54_L001 76.3
MP_T5S11_S55_L001 88.4
```

Note- one sample failed to merge (`MP_T1S7_S6_L001`) and 2 others did very poorly (`MP_T1S8_S7_L001`- 0.1%, `MP_T3S11_S32_L001` - 1.2%), otherwise numbers are good. Decided to proceed. 

NAs are getting in the way of some of the plots (heatmaps, ordinations, etc) but it successfully generated the tables I need. I think because one of the samples failed to merge.

Move on to following years. I will do ordinations on my own with entire 5 year dataset. - *YAY!*


### Run REVAMP on 2023 MiFish data
While I'm waiting on 2021, 2022, 2024 metadata from ShiRP crew I can work on 2023

#### 10/29/24

Remove suffix from fastq files

```
for file in *; do mv "${file}" "${file/_001/}"; done
```

Remove prefix from file name s(if re-running after mistake)
```
for file in * ; do
    mv -v "$file" "${file#*_}"
done
```

```
conda activate REVAMPenv

revamp.sh -p 01_config_file_MIFish-2023.txt -f 02_figure_config_file_MiFish-2023.txt -s 03_sample_metadata_MiFIsh-2023.txt -r raw_data/2023-MiFish-U -o results-revamp-2023-MiFish


```


```
Running Cutadapt: Tue Oct 29 10:57:09 EDT 2024
Finished Cutadapt: Tue Oct 29 11:09:45 EDT 2024
Sample	Passing Reads	Passing bp
MP_T2Blank_S1_L002	99.4%	87.3%
MP_T2Positive_S1_L002	99.2%	76.6%
MP_T2S1_S1_L002	99.4%	76.6%
MP_T2S2_S1_L002	99.4%	76.6%
MP_T2S3_S1_L002	99.3%	76.5%
MP_T2S4_S1_L002	99.2%	76.4%
MP_T2S5_S1_L002	99.4%	76.7%
MP_T2S6_S1_L002	99.3%	76.5%
MP_T2S7_S1_L002	99.3%	76.5%
MP_T2S8_S1_L002	99.2%	76.6%
MP_T2S9_S1_L002	99.2%	79.5%
MP_T2S10_S1_L002	99.4%	76.6%
MP_T2S11_S1_L002	99.4%	77.3%
MP_T2WC_S1_L002	99.2%	76.5%
MP_T2Tiana_S1_L002	99.3%	76.9%
MP_T3Blank_S1_L002	99.3%	82.8%
MP_T3Positive_S1_L002	99.1%	76.4%
MP_T3S1_S1_L002	99.4%	79.1%
MP_T3S2_S1_L002	99.3%	76.9%
MP_T3S3_S1_L002	99.4%	76.6%
MP_T3S4_S1_L002	99.0%	76.5%
MP_T3S5_S1_L002	99.3%	79.1%
MP_T3S6_S1_L002	99.1%	78.8%
MP_T3S7_S1_L002	99.1%	76.9%
MP_T3S8_S1_L002	99.3%	76.9%
MP_T3S9_S1_L002	99.3%	76.6%
MP_T3S10_S1_L002	99.3%	76.6%
MP_T3S11_S1_L002	99.3%	77.1%
MP_T3WC_S1_L002	99.1%	77.1%
MP_T3Tiana_S1_L002	99.3%	76.7%
MP_T5Blank_S2_L002	99.4%	76.2%
MP_T5Positive_S2_L002	99.5%	76.7%
MP_T5S1_S1_L002	99.2%	76.7%
MP_T5S2_S1_L002	99.4%	77.0%
MP_T5S3_S2_L002	99.3%	76.4%
MP_T5S4_S2_L002	99.3%	77.2%
MP_T5S5_S2_L002	99.2%	76.4%
MP_T5S6_S2_L002	99.4%	76.6%
MP_T5S7_S2_L002	99.2%	77.6%
MP_T5S8_S2_L002	99.4%	76.6%
MP_T5S9_S2_L002	99.2%	76.6%
MP_T5S10_S2_L002	99.5%	76.6%
MP_T5S11_S2_L002	99.5%	76.7%
MP_T5WC_S2_L002	99.4%	76.6%
MP_T5Tiana_S2_L002	99.3%	76.7%
MP_A_Blank_S2_L002	99.3%	76.1%
MP_A_Positive_S2_L002	99.3%	76.4%
MP_AC4_S2_L002	99.2%	79.4%
MP_AC5_S2_L002	99.3%	76.5%
MP_AS1_S2_L002	99.2%	78.2%
MP_AS3_S2_L002	99.3%	76.5%
MP_AS6_S2_L002	99.3%	76.5%
MP_AS9_S2_L002	99.3%	76.4%
MP_J_Blank_S2_L002	99.3%	76.4%
MP_J_Positive_S2_L002	99.4%	83.8%
MP_JC4_S2_L002	99.4%	76.4%
MP_JC5_S2_L002	99.4%	76.7%
MP_JS1_S2_L002	99.4%	76.7%
MP_JS3_S2_L002	99.2%	76.9%
MP_JS6_S2_L002	99.4%	76.7%
MP_JS9_S2_L002	99.4%	76.7%
MP_S_Blank_S2_L002	99.4%	76.4%
MP_S_Positive_S2_L002	99.3%	76.7%
MP_SC4_S2_L002	99.3%	76.7%
MP_SC5_S2_L002	99.3%	78.6%
MP_SS1_S2_L002	99.4%	76.7%
MP_SS3_S2_L002	99.2%	78.4%
MP_SS6_S2_L002	99.1%	76.6%
MP_SS9_S2_L002	99.2%	80.5%

```


```
Running DADA2: Tue Oct 29 11:15:25 EDT 2024
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_T2Blank_S1_L002_R1_trimmed.fq.gz 92.4469
MP_T2Positive_S1_L002_R1_trimmed.fq.gz 95.21
MP_T2S1_S1_L002_R1_trimmed.fq.gz 95.4417
MP_T2S2_S1_L002_R1_trimmed.fq.gz 95.3077
MP_T2S3_S1_L002_R1_trimmed.fq.gz 94.7364
MP_T2S4_S1_L002_R1_trimmed.fq.gz 95.1942
MP_T2S5_S1_L002_R1_trimmed.fq.gz 95.4441
MP_T2S6_S1_L002_R1_trimmed.fq.gz 95.1949
MP_T2S7_S1_L002_R1_trimmed.fq.gz 95.1291
MP_T2S8_S1_L002_R1_trimmed.fq.gz 94.8208
MP_T2S9_S1_L002_R1_trimmed.fq.gz 94.1261
MP_T2S10_S1_L002_R1_trimmed.fq.gz 95.5251
MP_T2S11_S1_L002_R1_trimmed.fq.gz 94.191
MP_T2WC_S1_L002_R1_trimmed.fq.gz 94.7228
MP_T2Tiana_S1_L002_R1_trimmed.fq.gz 95.1331
MP_T3Blank_S1_L002_R1_trimmed.fq.gz 94.0437
MP_T3Positive_S1_L002_R1_trimmed.fq.gz 95.0543
MP_T3S1_S1_L002_R1_trimmed.fq.gz 95.0789
MP_T3S2_S1_L002_R1_trimmed.fq.gz 95.3113
MP_T3S3_S1_L002_R1_trimmed.fq.gz 95.3291
MP_T3S4_S1_L002_R1_trimmed.fq.gz 94.7416
MP_T3S5_S1_L002_R1_trimmed.fq.gz 94.927
MP_T3S6_S1_L002_R1_trimmed.fq.gz 94.1324
MP_T3S7_S1_L002_R1_trimmed.fq.gz 90.032
MP_T3S8_S1_L002_R1_trimmed.fq.gz 95.5369
MP_T3S9_S1_L002_R1_trimmed.fq.gz 95.3988
MP_T3S10_S1_L002_R1_trimmed.fq.gz 95.8446
MP_T3S11_S1_L002_R1_trimmed.fq.gz 95.4776
MP_T3WC_S1_L002_R1_trimmed.fq.gz 95.0282
MP_T3Tiana_S1_L002_R1_trimmed.fq.gz 95.4183
MP_T5Blank_S2_L002_R1_trimmed.fq.gz 95.163
MP_T5Positive_S2_L002_R1_trimmed.fq.gz 96.7406
MP_T5S1_S1_L002_R1_trimmed.fq.gz 95.438
MP_T5S2_S1_L002_R1_trimmed.fq.gz 95.3987
MP_T5S3_S2_L002_R1_trimmed.fq.gz 95.1781
MP_T5S4_S2_L002_R1_trimmed.fq.gz 95.1945
MP_T5S5_S2_L002_R1_trimmed.fq.gz 94.8823
MP_T5S6_S2_L002_R1_trimmed.fq.gz 96.1073
MP_T5S7_S2_L002_R1_trimmed.fq.gz 94.2207
MP_T5S8_S2_L002_R1_trimmed.fq.gz 95.856
MP_T5S9_S2_L002_R1_trimmed.fq.gz 92.7389
MP_T5S10_S2_L002_R1_trimmed.fq.gz 96.5608
MP_T5S11_S2_L002_R1_trimmed.fq.gz 96.1858
MP_T5WC_S2_L002_R1_trimmed.fq.gz 95.3362
MP_T5Tiana_S2_L002_R1_trimmed.fq.gz 95.7906
MP_A_Blank_S2_L002_R1_trimmed.fq.gz 95.4754
MP_A_Positive_S2_L002_R1_trimmed.fq.gz 95.6989
MP_AC4_S2_L002_R1_trimmed.fq.gz 94.4051
MP_AC5_S2_L002_R1_trimmed.fq.gz 94.9906
MP_AS1_S2_L002_R1_trimmed.fq.gz 94.3647
MP_AS3_S2_L002_R1_trimmed.fq.gz 94.9798
MP_AS6_S2_L002_R1_trimmed.fq.gz 95.1438
MP_AS9_S2_L002_R1_trimmed.fq.gz 95.0553
MP_J_Blank_S2_L002_R1_trimmed.fq.gz 95.0885
MP_J_Positive_S2_L002_R1_trimmed.fq.gz 92.6523
MP_JC4_S2_L002_R1_trimmed.fq.gz 95.4461
MP_JC5_S2_L002_R1_trimmed.fq.gz 95.1633
MP_JS1_S2_L002_R1_trimmed.fq.gz 92.9069
MP_JS3_S2_L002_R1_trimmed.fq.gz 94.6598
MP_JS6_S2_L002_R1_trimmed.fq.gz 95.2962
MP_JS9_S2_L002_R1_trimmed.fq.gz 95.034
MP_S_Blank_S2_L002_R1_trimmed.fq.gz 95.2126
MP_S_Positive_S2_L002_R1_trimmed.fq.gz 95.048
MP_SC4_S2_L002_R1_trimmed.fq.gz 95.2288
MP_SC5_S2_L002_R1_trimmed.fq.gz 95.2152
MP_SS1_S2_L002_R1_trimmed.fq.gz 94.7179
MP_SS3_S2_L002_R1_trimmed.fq.gz 94.287
MP_SS6_S2_L002_R1_trimmed.fq.gz 94.5756
MP_SS9_S2_L002_R1_trimmed.fq.gz 93.9098

```


```
FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_T2Blank_S1_L002 81.2
MP_T2Positive_S1_L002 83
MP_T2S1_S1_L002 74.7
MP_T2S2_S1_L002 82.1
MP_T2S3_S1_L002 81.4
MP_T2S4_S1_L002 81.8
MP_T2S5_S1_L002 81.7
MP_T2S6_S1_L002 83.4
MP_T2S7_S1_L002 81.7
MP_T2S8_S1_L002 81.9
MP_T2S9_S1_L002 79
MP_T2S10_S1_L002 82.1
MP_T2S11_S1_L002 76.3
MP_T2WC_S1_L002 76.6
MP_T2Tiana_S1_L002 83.3
MP_T3Blank_S1_L002 88.7
MP_T3Positive_S1_L002 83.8
MP_T3S1_S1_L002 84.7
MP_T3S2_S1_L002 78.7
MP_T3S3_S1_L002 83.1
MP_T3S4_S1_L002 83.3
MP_T3S5_S1_L002 84.7
MP_T3S6_S1_L002 80.8
MP_T3S7_S1_L002 78.4
MP_T3S8_S1_L002 80.4
MP_T3S9_S1_L002 84.6
MP_T3S10_S1_L002 84.5
MP_T3S11_S1_L002 84.6
MP_T3WC_S1_L002 82.5
MP_T3Tiana_S1_L002 82.5
MP_T5Blank_S2_L002 84
MP_T5Positive_S2_L002 85.5
MP_T5S1_S1_L002 83.1
MP_T5S2_S1_L002 83.3
MP_T5S3_S2_L002 78.6
MP_T5S4_S2_L002 75.8
MP_T5S5_S2_L002 84
MP_T5S6_S2_L002 82.1
MP_T5S7_S2_L002 81.6
MP_T5S8_S2_L002 84.7
MP_T5S9_S2_L002 79.1
MP_T5S10_S2_L002 82.4
MP_T5S11_S2_L002 83.2
MP_T5WC_S2_L002 83.2
MP_T5Tiana_S2_L002 80.8
MP_A_Blank_S2_L002 85.8
MP_A_Positive_S2_L002 86.5
MP_AC4_S2_L002 81.8
MP_AC5_S2_L002 85.3
MP_AS1_S2_L002 84.1
MP_AS3_S2_L002 84.9
MP_AS6_S2_L002 82.8
MP_AS9_S2_L002 77.6
MP_J_Blank_S2_L002 85.6
MP_J_Positive_S2_L002 79.7
MP_JC4_S2_L002 85.5
MP_JC5_S2_L002 77.4
MP_JS1_S2_L002 74.3
MP_JS3_S2_L002 72.4
MP_JS6_S2_L002 80.9
MP_JS9_S2_L002 83.2
MP_S_Blank_S2_L002 85.5
MP_S_Positive_S2_L002 85.7
MP_SC4_S2_L002 83.2
MP_SC5_S2_L002 76
MP_SS1_S2_L002 82.5
MP_SS3_S2_L002 85
MP_SS6_S2_L002 82.7
MP_SS9_S2_L002 84.4
```

--> all merged and retained ~80% of reads

2023 figures generated, done!

___________

### Some notes:

- I'm still noticing Finescale menhaden (Brevoortia gunteri) rather than Atlantic menhaden (Brevoortia tyrannus) in these samples. Same was true for 2020 and same was true for my Great South Bay samples...
- Checked through my MiFish blastdb for which menhaden species are used as reference. 

```
cd /Volumes/MyPassportforMac/eDNA-backup/databases/MiFish-U-local-20241011/derep_and_clean_db
grep Brevoortia MiFishU_derep_and_clean_taxonomy.txt 
```

There are 11 reference sequences: 
 
```
"PP824515.1_representative_of_5_identical_accessions"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;NA"
"OP057005.1_representative_of_12_identical_accessions"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;NA"
"KX686086.1_representative_of_6_identical_accessions"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;Brevoortia tyrannus"
"OR380465.1"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;Brevoortia tyrannus"
"KX686085.1"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;Brevoortia tyrannus"
"DQ912033.1"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;Brevoortia patronus"
"DQ912034.1"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;Brevoortia tyrannus"
"OQ198728.1"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;Brevoortia gunteri"
"OQ198737.1"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;Brevoortia gunteri"
"OQ198734.1"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;Brevoortia gunteri"
"OQ198733.1"	"Eukaryota;Chordata;Actinopteri;Clupeiformes;Clupeidae;Brevoortia;Brevoortia gunteri"
```

4 are tyrannus, 4 are gunteri, 1 is patronus and 2 are only listed as genus. So it's not a problem of not having the references in the database.

Get accession numbers of those 11 and generate fasta file to start looking at alignment

```
grep Brevoortia MiFishU_derep_and_clean_taxonomy.txt | cut -d '"' -f2
```


```
PP824515.1
OP057005.1
KX686086.1
OR380465.1
KX686085.1
DQ912033.1
DQ912034.1
OQ198728.1
OQ198737.1
OQ198734.1
OQ198733.1
```

```
for i in PP824515.1 OP057005.1 KX686086.1 OR380465.1 KX686085.1 DQ912033.1 DQ912034.1 OQ198728.1 OQ198737.1 OQ198734.1 OQ198733.1; do
  grep $i MiFishU_derep_and_clean_2.fasta -A 1
done 
```

Paste into new fasta file with spp names so I can easily view in an alignment viewer:

```
>PP824515.1-Brevoortia;NA
GCCACCGCGGTTATACGAGAGGCCCTAGTTGATTCACTCGGCGTAAAGAGTGGTTATGGAGAACTAAATACTAAAGCCGAAGACCCCTTAG
>OP057005.1-Brevoortia;NA
GCCACCGCGGTTATACGAGAGGCCCTAGTTGATTCACTCGGCGTAAAGAGTGGTTATGGAGAACTAGACACTAAAGCCGAAGACTCCTTAG
>KX686086.1-B.tyrannus
CACCGCGGTTATACGAGAGGCCCTAGTTGATTCACTCGGCGTAAAGAGTGGTTATGGAGAACTAAATACTAAAGCCGAAGACCCCTTAG
>OR380465.1-B.tyrannus
CACCGCGGTTATACGAGAGGCCCTAGTTGATTCACTCGGCGTAAAGAGTGGTTATGGAGAACTAAATACTAAAGCCGAAGACCCTTT
>KX686085.1-B.tyrannus
CACCGCGGTTATACGAGAGGCCCTAGTTGATTCACTCGGCGTAAAGAGTGGTTATGGAGAACTAGATACTAAAGCCGAAGACCCCTTAGGCCGTCATA
>DQ912033.1-B.patronus
CGGCGTAAAGAGTGGTTATGGAGAACTAAACACTAAAGCCGAAGACTCCTTAGGCCGTCATACGCACCTAGGGGTTCGAATTATATACACGAAAGTAGCTTTACCCTTTCCCACCAGAACCCACGACAGCCGGGACACA
>DQ912034.1-B.tyrannus
CGGCGTAAAGAGTGGTTATGGAGAACTAAATACTAAAGCCGAAGACCCCTTAGGCCGTCATACGCACCTAGGGGTTCGAATTATATACACGAAAGTAGCTTTACCCTTTCCCACCAGAACCCACGACAGCCGGGACACA
>OQ198728.1-B.gunteri
GCCACCGCGGTTATACGAGAGGCCCTAGTTGATTCACTCGGCGTAAAGAGTGGTTATGGAGAACTAAACACTAAAGCCGAAGACTCCTTAG
>OQ198737.1-B.gunteri
GCCACCGCGGTTATACGAGAGGCCCTAGTTGATTCACTCGGCGTAAAGAGTGGTTATGGAGAACTAGACACTAAAGCCGAAGACCCCTTAGGCCGTCATACGCACCTAGAGGTTCGAATTATATACACGAAAGTAGCTTTACCCTTTCCCACCAGAACCCACGACAGCCGGGACACA
>OQ198734.1-B.gunteri
GCCACCGCGGTTATACGAGAGGCCCTAGTTGATTCACTCGGCGTAAAGAGTGGTTATGGAGAACTAGACACTAAAGCCGAAGACCCCTTAGGCCGTCATACGCACCTAGGGGTTCGAATTACATACACGAAAGTAGCTTTACCCTTTCCCACCAGAACCCACGACAGCCGGGACACA
>OQ198733.1-B.gunteri
GCCACCGCGGTTATACGAGAGGCCCTAGTTGATTCACTCGGCGTAAAGAGTGGTTATGGAGAACTAGACACTAAAGCCGAAGACCCCTTAGGCCGTCATACGCACCTAGGGGTTCGAATTATATACACGAAAGTAGCTTTACCCTTTCCCACCAGAACCCACGACAGCCGGGACACA

```

Save the above in a fasta file called `references.fasta` in `/Volumes/easystore/eDNA/shirp-edna/menhaden `

Downloaded [Muscle v5.2](https://drive5.com/muscle5/manual/install.html), added to my software directory, and renamed software file to `muscle`, executed permissions according to documentation, `chmod +x ~/software/muscle`.

Still was having trouble and followed [this](https://github.com/rcedgar/muscle/issues/21) to install gss. Made new environment for muscle called `MUSCLEenv` environment

```
conda create --name MUSCLEenv 
conda activate MUSCLEenv

brew install gcc@11

```
 note had to use `brew`, `conda install` didn't work for gcc. Also needed to use `gcc@11` and not just `gcc`, which when I tried was taking >1hr to install.
 
 After installation, this worked to generate alignment file:
 
```
 cd /Volumes/easystore/eDNA/shirp-edna/menhaden
 
 muscle -align references.fasta -output alignment.fasta
```

**Summary**

- Come back and add unknowns to this file and look at alignment. There are some bp differences between the two species but I don't know if this is significant enough to really differentiate between them
- Also look at the blast hits list from REVAMP to see how the unknowns align with references
	- I took a look at these and the revamp.sh script. What it's actually doing is taking the top hit based on PID and assigning that taxonomy. Only if there are multiple hits with the same PID (eg. 100%), then it takes a concensus taxonomy or assigns the genus if there is not a concensus.
	- So overall, this still suffers from some of the same issues we were having before: if two species are closely related, they might not be able to de differentiated in this small gene region. 
 
 


#### Another thing to keep an eye on:  

- Scup vs spot- these are easliy misidentified in field according to Libby. Can we verify using eDNA?

### 10/30/24

- started preparing the 2021 and 2021 sample metadata, configuration files
- Get sample names from 2021 files, everything before `_R*_001.fastq.gz`:

`for file in *; do echo "${file}" "${file/_R*_001.fastq.gz/}"; done`


```
ACanal1-SCmiFish_S122_L002_R1_001.fastq.gz ACanal1-SCmiFish_S122_L002
ACanal1-SCmiFish_S122_L002_R2_001.fastq.gz ACanal1-SCmiFish_S122_L002
ACanal2-SCmiFish_S123_L002_R1_001.fastq.gz ACanal2-SCmiFish_S123_L002
ACanal2-SCmiFish_S123_L002_R2_001.fastq.gz ACanal2-SCmiFish_S123_L002
ACanal3-SCmiFish_S124_L002_R1_001.fastq.gz ACanal3-SCmiFish_S124_L002
ACanal3-SCmiFish_S124_L002_R2_001.fastq.gz ACanal3-SCmiFish_S124_L002
ACanal4-SCmiFish_S125_L002_R1_001.fastq.gz ACanal4-SCmiFish_S125_L002
ACanal4-SCmiFish_S125_L002_R2_001.fastq.gz ACanal4-SCmiFish_S125_L002
ACanal5-SCmiFish_S126_L002_R1_001.fastq.gz ACanal5-SCmiFish_S126_L002
ACanal5-SCmiFish_S126_L002_R2_001.fastq.gz ACanal5-SCmiFish_S126_L002
ACanal6-SCmiFish_S127_L002_R1_001.fastq.gz ACanal6-SCmiFish_S127_L002
ACanal6-SCmiFish_S127_L002_R2_001.fastq.gz ACanal6-SCmiFish_S127_L002
ACanal7-SCmiFish_S128_L002_R1_001.fastq.gz ACanal7-SCmiFish_S128_L002
ACanal7-SCmiFish_S128_L002_R2_001.fastq.gz ACanal7-SCmiFish_S128_L002
ACanal8-SCmiFish_S129_L002_R1_001.fastq.gz ACanal8-SCmiFish_S129_L002
ACanal8-SCmiFish_S129_L002_R2_001.fastq.gz ACanal8-SCmiFish_S129_L002
APosCon-SCmiFish_S131_L002_R1_001.fastq.gz APosCon-SCmiFish_S131_L002
APosCon-SCmiFish_S131_L002_R2_001.fastq.gz APosCon-SCmiFish_S131_L002
ASedge1-SCmiFish_S112_L002_R1_001.fastq.gz ASedge1-SCmiFish_S112_L002
ASedge1-SCmiFish_S112_L002_R2_001.fastq.gz ASedge1-SCmiFish_S112_L002
ASedge10-SCmiFish_S121_L002_R1_001.fastq.gz ASedge10-SCmiFish_S121_L002
ASedge10-SCmiFish_S121_L002_R2_001.fastq.gz ASedge10-SCmiFish_S121_L002
ASedge2-SCmiFish_S113_L002_R1_001.fastq.gz ASedge2-SCmiFish_S113_L002
ASedge2-SCmiFish_S113_L002_R2_001.fastq.gz ASedge2-SCmiFish_S113_L002
ASedge3-SCmiFish_S114_L002_R1_001.fastq.gz ASedge3-SCmiFish_S114_L002
ASedge3-SCmiFish_S114_L002_R2_001.fastq.gz ASedge3-SCmiFish_S114_L002
ASedge4-SCmiFish_S115_L002_R1_001.fastq.gz ASedge4-SCmiFish_S115_L002
ASedge4-SCmiFish_S115_L002_R2_001.fastq.gz ASedge4-SCmiFish_S115_L002
ASedge5-SCmiFish_S116_L002_R1_001.fastq.gz ASedge5-SCmiFish_S116_L002
ASedge5-SCmiFish_S116_L002_R2_001.fastq.gz ASedge5-SCmiFish_S116_L002
ASedge6-SCmiFish_S117_L002_R1_001.fastq.gz ASedge6-SCmiFish_S117_L002
ASedge6-SCmiFish_S117_L002_R2_001.fastq.gz ASedge6-SCmiFish_S117_L002
ASedge7-SCmiFish_S118_L002_R1_001.fastq.gz ASedge7-SCmiFish_S118_L002
ASedge7-SCmiFish_S118_L002_R2_001.fastq.gz ASedge7-SCmiFish_S118_L002
ASedge8-SCmiFish_S119_L002_R1_001.fastq.gz ASedge8-SCmiFish_S119_L002
ASedge8-SCmiFish_S119_L002_R2_001.fastq.gz ASedge8-SCmiFish_S119_L002
ASedge9-SCmiFish_S120_L002_R1_001.fastq.gz ASedge9-SCmiFish_S120_L002
ASedge9-SCmiFish_S120_L002_R2_001.fastq.gz ASedge9-SCmiFish_S120_L002
Ablank-SCmiFish_S130_L002_R1_001.fastq.gz Ablank-SCmiFish_S130_L002
Ablank-SCmiFish_S130_L002_R2_001.fastq.gz Ablank-SCmiFish_S130_L002
JCanal1-SCmiFish_S102_L002_R1_001.fastq.gz JCanal1-SCmiFish_S102_L002
JCanal1-SCmiFish_S102_L002_R2_001.fastq.gz JCanal1-SCmiFish_S102_L002
JCanal2-SCmiFish_S103_L002_R1_001.fastq.gz JCanal2-SCmiFish_S103_L002
JCanal2-SCmiFish_S103_L002_R2_001.fastq.gz JCanal2-SCmiFish_S103_L002
JCanal3-SCmiFish_S104_L002_R1_001.fastq.gz JCanal3-SCmiFish_S104_L002
JCanal3-SCmiFish_S104_L002_R2_001.fastq.gz JCanal3-SCmiFish_S104_L002
JCanal4-SCmiFish_S105_L002_R1_001.fastq.gz JCanal4-SCmiFish_S105_L002
JCanal4-SCmiFish_S105_L002_R2_001.fastq.gz JCanal4-SCmiFish_S105_L002
JCanal5-SCmiFish_S106_L002_R1_001.fastq.gz JCanal5-SCmiFish_S106_L002
JCanal5-SCmiFish_S106_L002_R2_001.fastq.gz JCanal5-SCmiFish_S106_L002
JCanal6-SCmiFish_S107_L002_R1_001.fastq.gz JCanal6-SCmiFish_S107_L002
JCanal6-SCmiFish_S107_L002_R2_001.fastq.gz JCanal6-SCmiFish_S107_L002
JCanal7-SCmiFish_S108_L002_R1_001.fastq.gz JCanal7-SCmiFish_S108_L002
JCanal7-SCmiFish_S108_L002_R2_001.fastq.gz JCanal7-SCmiFish_S108_L002
JCanal8-SCmiFish_S109_L002_R1_001.fastq.gz JCanal8-SCmiFish_S109_L002
JCanal8-SCmiFish_S109_L002_R2_001.fastq.gz JCanal8-SCmiFish_S109_L002
JPosCon-SCmiFish_S111_L002_R1_001.fastq.gz JPosCon-SCmiFish_S111_L002
JPosCon-SCmiFish_S111_L002_R2_001.fastq.gz JPosCon-SCmiFish_S111_L002
JSedge1-SCmiFish_S92_L002_R1_001.fastq.gz JSedge1-SCmiFish_S92_L002
JSedge1-SCmiFish_S92_L002_R2_001.fastq.gz JSedge1-SCmiFish_S92_L002
JSedge10-SCmiFish_S101_L002_R1_001.fastq.gz JSedge10-SCmiFish_S101_L002
JSedge10-SCmiFish_S101_L002_R2_001.fastq.gz JSedge10-SCmiFish_S101_L002
JSedge2-SCmiFish_S93_L002_R1_001.fastq.gz JSedge2-SCmiFish_S93_L002
JSedge2-SCmiFish_S93_L002_R2_001.fastq.gz JSedge2-SCmiFish_S93_L002
JSedge3-SCmiFish_S94_L002_R1_001.fastq.gz JSedge3-SCmiFish_S94_L002
JSedge3-SCmiFish_S94_L002_R2_001.fastq.gz JSedge3-SCmiFish_S94_L002
JSedge4-SCmiFish_S95_L002_R1_001.fastq.gz JSedge4-SCmiFish_S95_L002
JSedge4-SCmiFish_S95_L002_R2_001.fastq.gz JSedge4-SCmiFish_S95_L002
JSedge5-SCmiFish_S96_L002_R1_001.fastq.gz JSedge5-SCmiFish_S96_L002
JSedge5-SCmiFish_S96_L002_R2_001.fastq.gz JSedge5-SCmiFish_S96_L002
JSedge6-SCmiFish_S97_L002_R1_001.fastq.gz JSedge6-SCmiFish_S97_L002
JSedge6-SCmiFish_S97_L002_R2_001.fastq.gz JSedge6-SCmiFish_S97_L002
JSedge7-SCmiFish_S98_L002_R1_001.fastq.gz JSedge7-SCmiFish_S98_L002
JSedge7-SCmiFish_S98_L002_R2_001.fastq.gz JSedge7-SCmiFish_S98_L002
JSedge8-SCmiFish_S99_L002_R1_001.fastq.gz JSedge8-SCmiFish_S99_L002
JSedge8-SCmiFish_S99_L002_R2_001.fastq.gz JSedge8-SCmiFish_S99_L002
JSedge9-SCmiFish_S100_L002_R1_001.fastq.gz JSedge9-SCmiFish_S100_L002
JSedge9-SCmiFish_S100_L002_R2_001.fastq.gz JSedge9-SCmiFish_S100_L002
Jblank-SCmiFish_S110_L002_R1_001.fastq.gz Jblank-SCmiFish_S110_L002
Jblank-SCmiFish_S110_L002_R2_001.fastq.gz Jblank-SCmiFish_S110_L002
SCanal1-SCmiFish_S142_L002_R1_001.fastq.gz SCanal1-SCmiFish_S142_L002
SCanal1-SCmiFish_S142_L002_R2_001.fastq.gz SCanal1-SCmiFish_S142_L002
SCanal2-SCmiFish_S143_L002_R1_001.fastq.gz SCanal2-SCmiFish_S143_L002
SCanal2-SCmiFish_S143_L002_R2_001.fastq.gz SCanal2-SCmiFish_S143_L002
SCanal3-SCmiFish_S144_L002_R1_001.fastq.gz SCanal3-SCmiFish_S144_L002
SCanal3-SCmiFish_S144_L002_R2_001.fastq.gz SCanal3-SCmiFish_S144_L002
SCanal4-SCmiFish_S145_L002_R1_001.fastq.gz SCanal4-SCmiFish_S145_L002
SCanal4-SCmiFish_S145_L002_R2_001.fastq.gz SCanal4-SCmiFish_S145_L002
SCanal5-SCmiFish_S146_L002_R1_001.fastq.gz SCanal5-SCmiFish_S146_L002
SCanal5-SCmiFish_S146_L002_R2_001.fastq.gz SCanal5-SCmiFish_S146_L002
SCanal6-SCmiFish_S147_L002_R1_001.fastq.gz SCanal6-SCmiFish_S147_L002
SCanal6-SCmiFish_S147_L002_R2_001.fastq.gz SCanal6-SCmiFish_S147_L002
SCanal7-SCmiFish_S148_L002_R1_001.fastq.gz SCanal7-SCmiFish_S148_L002
SCanal7-SCmiFish_S148_L002_R2_001.fastq.gz SCanal7-SCmiFish_S148_L002
SCanal8-SCmiFish_S149_L002_R1_001.fastq.gz SCanal8-SCmiFish_S149_L002
SCanal8-SCmiFish_S149_L002_R2_001.fastq.gz SCanal8-SCmiFish_S149_L002
SPosCon-SCmiFish_S151_L002_R1_001.fastq.gz SPosCon-SCmiFish_S151_L002
SPosCon-SCmiFish_S151_L002_R2_001.fastq.gz SPosCon-SCmiFish_S151_L002
SSedge1-SCmiFish_S132_L002_R1_001.fastq.gz SSedge1-SCmiFish_S132_L002
SSedge1-SCmiFish_S132_L002_R2_001.fastq.gz SSedge1-SCmiFish_S132_L002
SSedge10-SCmiFish_S141_L002_R1_001.fastq.gz SSedge10-SCmiFish_S141_L002
SSedge10-SCmiFish_S141_L002_R2_001.fastq.gz SSedge10-SCmiFish_S141_L002
SSedge2-SCmiFish_S133_L002_R1_001.fastq.gz SSedge2-SCmiFish_S133_L002
SSedge2-SCmiFish_S133_L002_R2_001.fastq.gz SSedge2-SCmiFish_S133_L002
SSedge3-SCmiFish_S134_L002_R1_001.fastq.gz SSedge3-SCmiFish_S134_L002
SSedge3-SCmiFish_S134_L002_R2_001.fastq.gz SSedge3-SCmiFish_S134_L002
SSedge4-SCmiFish_S135_L002_R1_001.fastq.gz SSedge4-SCmiFish_S135_L002
SSedge4-SCmiFish_S135_L002_R2_001.fastq.gz SSedge4-SCmiFish_S135_L002
SSedge5-SCmiFish_S136_L002_R1_001.fastq.gz SSedge5-SCmiFish_S136_L002
SSedge5-SCmiFish_S136_L002_R2_001.fastq.gz SSedge5-SCmiFish_S136_L002
SSedge6-SCmiFish_S137_L002_R1_001.fastq.gz SSedge6-SCmiFish_S137_L002
SSedge6-SCmiFish_S137_L002_R2_001.fastq.gz SSedge6-SCmiFish_S137_L002
SSedge7-SCmiFish_S138_L002_R1_001.fastq.gz SSedge7-SCmiFish_S138_L002
SSedge7-SCmiFish_S138_L002_R2_001.fastq.gz SSedge7-SCmiFish_S138_L002
SSedge8-SCmiFish_S139_L002_R1_001.fastq.gz SSedge8-SCmiFish_S139_L002
SSedge8-SCmiFish_S139_L002_R2_001.fastq.gz SSedge8-SCmiFish_S139_L002
SSedge9-SCmiFish_S140_L002_R1_001.fastq.gz SSedge9-SCmiFish_S140_L002
SSedge9-SCmiFish_S140_L002_R2_001.fastq.gz SSedge9-SCmiFish_S140_L002
Sblank-SCmiFish_S150_L002_R1_001.fastq.gz Sblank-SCmiFish_S150_L002
Sblank-SCmiFish_S150_L002_R2_001.fastq.gz Sblank-SCmiFish_S150_L002
T10Blank-SCmiFish_S90_L002_R1_001.fastq.gz T10Blank-SCmiFish_S90_L002
T10Blank-SCmiFish_S90_L002_R2_001.fastq.gz T10Blank-SCmiFish_S90_L002
T10PosCon-SCmiFish_S91_L002_R1_001.fastq.gz T10PosCon-SCmiFish_S91_L002
T10PosCon-SCmiFish_S91_L002_R2_001.fastq.gz T10PosCon-SCmiFish_S91_L002
T10S1-SCmiFish_S77_L002_R1_001.fastq.gz T10S1-SCmiFish_S77_L002
T10S1-SCmiFish_S77_L002_R2_001.fastq.gz T10S1-SCmiFish_S77_L002
T10S10-SCmiFish_S86_L002_R1_001.fastq.gz T10S10-SCmiFish_S86_L002
T10S10-SCmiFish_S86_L002_R2_001.fastq.gz T10S10-SCmiFish_S86_L002
T10S11-SCmiFish_S87_L002_R1_001.fastq.gz T10S11-SCmiFish_S87_L002
T10S11-SCmiFish_S87_L002_R2_001.fastq.gz T10S11-SCmiFish_S87_L002
T10S2-SCmiFish_S78_L002_R1_001.fastq.gz T10S2-SCmiFish_S78_L002
T10S2-SCmiFish_S78_L002_R2_001.fastq.gz T10S2-SCmiFish_S78_L002
T10S3-SCmiFish_S79_L002_R1_001.fastq.gz T10S3-SCmiFish_S79_L002
T10S3-SCmiFish_S79_L002_R2_001.fastq.gz T10S3-SCmiFish_S79_L002
T10S4-SCmiFish_S80_L002_R1_001.fastq.gz T10S4-SCmiFish_S80_L002
T10S4-SCmiFish_S80_L002_R2_001.fastq.gz T10S4-SCmiFish_S80_L002
T10S5-SCmiFish_S81_L002_R1_001.fastq.gz T10S5-SCmiFish_S81_L002
T10S5-SCmiFish_S81_L002_R2_001.fastq.gz T10S5-SCmiFish_S81_L002
T10S6-SCmiFish_S82_L002_R1_001.fastq.gz T10S6-SCmiFish_S82_L002
T10S6-SCmiFish_S82_L002_R2_001.fastq.gz T10S6-SCmiFish_S82_L002
T10S7-SCmiFish_S83_L002_R1_001.fastq.gz T10S7-SCmiFish_S83_L002
T10S7-SCmiFish_S83_L002_R2_001.fastq.gz T10S7-SCmiFish_S83_L002
T10S8-SCmiFish_S84_L002_R1_001.fastq.gz T10S8-SCmiFish_S84_L002
T10S8-SCmiFish_S84_L002_R2_001.fastq.gz T10S8-SCmiFish_S84_L002
T10S9-SCmiFish_S85_L002_R1_001.fastq.gz T10S9-SCmiFish_S85_L002
T10S9-SCmiFish_S85_L002_R2_001.fastq.gz T10S9-SCmiFish_S85_L002
T10Tiana-SCmiFish_S88_L002_R1_001.fastq.gz T10Tiana-SCmiFish_S88_L002
T10Tiana-SCmiFish_S88_L002_R2_001.fastq.gz T10Tiana-SCmiFish_S88_L002
T10Wessuck-SCmiFish_S89_L002_R1_001.fastq.gz T10Wessuck-SCmiFish_S89_L002
T10Wessuck-SCmiFish_S89_L002_R2_001.fastq.gz T10Wessuck-SCmiFish_S89_L002
T1Blank-SCmiFish_S15_L002_R1_001.fastq.gz T1Blank-SCmiFish_S15_L002
T1Blank-SCmiFish_S15_L002_R2_001.fastq.gz T1Blank-SCmiFish_S15_L002
T1CTiana-SCmiFish_S13_L002_R1_001.fastq.gz T1CTiana-SCmiFish_S13_L002
T1CTiana-SCmiFish_S13_L002_R2_001.fastq.gz T1CTiana-SCmiFish_S13_L002
T1CW-SCmiFish_S14_L002_R1_001.fastq.gz T1CW-SCmiFish_S14_L002
T1CW-SCmiFish_S14_L002_R2_001.fastq.gz T1CW-SCmiFish_S14_L002
T1PosCon-SCmiFish_S16_L002_R1_001.fastq.gz T1PosCon-SCmiFish_S16_L002
T1PosCon-SCmiFish_S16_L002_R2_001.fastq.gz T1PosCon-SCmiFish_S16_L002
T1S1-SCmiFish_S2_L002_R1_001.fastq.gz T1S1-SCmiFish_S2_L002
T1S1-SCmiFish_S2_L002_R2_001.fastq.gz T1S1-SCmiFish_S2_L002
T1S10-SCmiFish_S11_L002_R1_001.fastq.gz T1S10-SCmiFish_S11_L002
T1S10-SCmiFish_S11_L002_R2_001.fastq.gz T1S10-SCmiFish_S11_L002
T1S11-SCmiFish_S12_L002_R1_001.fastq.gz T1S11-SCmiFish_S12_L002
T1S11-SCmiFish_S12_L002_R2_001.fastq.gz T1S11-SCmiFish_S12_L002
T1S2-SCmiFish_S3_L002_R1_001.fastq.gz T1S2-SCmiFish_S3_L002
T1S2-SCmiFish_S3_L002_R2_001.fastq.gz T1S2-SCmiFish_S3_L002
T1S3-SCmiFish_S4_L002_R1_001.fastq.gz T1S3-SCmiFish_S4_L002
T1S3-SCmiFish_S4_L002_R2_001.fastq.gz T1S3-SCmiFish_S4_L002
T1S4-SCmiFish_S5_L002_R1_001.fastq.gz T1S4-SCmiFish_S5_L002
T1S4-SCmiFish_S5_L002_R2_001.fastq.gz T1S4-SCmiFish_S5_L002
T1S5-SCmiFish_S6_L002_R1_001.fastq.gz T1S5-SCmiFish_S6_L002
T1S5-SCmiFish_S6_L002_R2_001.fastq.gz T1S5-SCmiFish_S6_L002
T1S6-SCmiFish_S7_L002_R1_001.fastq.gz T1S6-SCmiFish_S7_L002
T1S6-SCmiFish_S7_L002_R2_001.fastq.gz T1S6-SCmiFish_S7_L002
T1S7-SCmiFish_S8_L002_R1_001.fastq.gz T1S7-SCmiFish_S8_L002
T1S7-SCmiFish_S8_L002_R2_001.fastq.gz T1S7-SCmiFish_S8_L002
T1S8-SCmiFish_S9_L002_R1_001.fastq.gz T1S8-SCmiFish_S9_L002
T1S8-SCmiFish_S9_L002_R2_001.fastq.gz T1S8-SCmiFish_S9_L002
T1S9-SCmiFish_S10_L002_R1_001.fastq.gz T1S9-SCmiFish_S10_L002
T1S9-SCmiFish_S10_L002_R2_001.fastq.gz T1S9-SCmiFish_S10_L002
T3Blank-SCmiFish_S30_L002_R1_001.fastq.gz T3Blank-SCmiFish_S30_L002
T3Blank-SCmiFish_S30_L002_R2_001.fastq.gz T3Blank-SCmiFish_S30_L002
T3PosCon-SCmiFish_S31_L002_R1_001.fastq.gz T3PosCon-SCmiFish_S31_L002
T3PosCon-SCmiFish_S31_L002_R2_001.fastq.gz T3PosCon-SCmiFish_S31_L002
T3S1-SCmiFish_S17_L002_R1_001.fastq.gz T3S1-SCmiFish_S17_L002
T3S1-SCmiFish_S17_L002_R2_001.fastq.gz T3S1-SCmiFish_S17_L002
T3S10-SCmiFish_S26_L002_R1_001.fastq.gz T3S10-SCmiFish_S26_L002
T3S10-SCmiFish_S26_L002_R2_001.fastq.gz T3S10-SCmiFish_S26_L002
T3S11-SCmiFish_S27_L002_R1_001.fastq.gz T3S11-SCmiFish_S27_L002
T3S11-SCmiFish_S27_L002_R2_001.fastq.gz T3S11-SCmiFish_S27_L002
T3S2-SCmiFish_S18_L002_R1_001.fastq.gz T3S2-SCmiFish_S18_L002
T3S2-SCmiFish_S18_L002_R2_001.fastq.gz T3S2-SCmiFish_S18_L002
T3S3-SCmiFish_S19_L002_R1_001.fastq.gz T3S3-SCmiFish_S19_L002
T3S3-SCmiFish_S19_L002_R2_001.fastq.gz T3S3-SCmiFish_S19_L002
T3S4-SCmiFish_S20_L002_R1_001.fastq.gz T3S4-SCmiFish_S20_L002
T3S4-SCmiFish_S20_L002_R2_001.fastq.gz T3S4-SCmiFish_S20_L002
T3S5-SCmiFish_S21_L002_R1_001.fastq.gz T3S5-SCmiFish_S21_L002
T3S5-SCmiFish_S21_L002_R2_001.fastq.gz T3S5-SCmiFish_S21_L002
T3S6-SCmiFish_S22_L002_R1_001.fastq.gz T3S6-SCmiFish_S22_L002
T3S6-SCmiFish_S22_L002_R2_001.fastq.gz T3S6-SCmiFish_S22_L002
T3S7-SCmiFish_S23_L002_R1_001.fastq.gz T3S7-SCmiFish_S23_L002
T3S7-SCmiFish_S23_L002_R2_001.fastq.gz T3S7-SCmiFish_S23_L002
T3S8-SCmiFish_S24_L002_R1_001.fastq.gz T3S8-SCmiFish_S24_L002
T3S8-SCmiFish_S24_L002_R2_001.fastq.gz T3S8-SCmiFish_S24_L002
T3S9-SCmiFish_S25_L002_R1_001.fastq.gz T3S9-SCmiFish_S25_L002
T3S9-SCmiFish_S25_L002_R2_001.fastq.gz T3S9-SCmiFish_S25_L002
T3TC-SCmiFish_S28_L002_R1_001.fastq.gz T3TC-SCmiFish_S28_L002
T3TC-SCmiFish_S28_L002_R2_001.fastq.gz T3TC-SCmiFish_S28_L002
T3WC-SCmiFish_S29_L002_R1_001.fastq.gz T3WC-SCmiFish_S29_L002
T3WC-SCmiFish_S29_L002_R2_001.fastq.gz T3WC-SCmiFish_S29_L002
T5Blank-SCmiFish_S45_L002_R1_001.fastq.gz T5Blank-SCmiFish_S45_L002
T5Blank-SCmiFish_S45_L002_R2_001.fastq.gz T5Blank-SCmiFish_S45_L002
T5PosCon-SCmiFish_S46_L002_R1_001.fastq.gz T5PosCon-SCmiFish_S46_L002
T5PosCon-SCmiFish_S46_L002_R2_001.fastq.gz T5PosCon-SCmiFish_S46_L002
T5S1-SCmiFish_S32_L002_R1_001.fastq.gz T5S1-SCmiFish_S32_L002
T5S1-SCmiFish_S32_L002_R2_001.fastq.gz T5S1-SCmiFish_S32_L002
T5S10-SCmiFish_S41_L002_R1_001.fastq.gz T5S10-SCmiFish_S41_L002
T5S10-SCmiFish_S41_L002_R2_001.fastq.gz T5S10-SCmiFish_S41_L002
T5S11-SCmiFish_S42_L002_R1_001.fastq.gz T5S11-SCmiFish_S42_L002
T5S11-SCmiFish_S42_L002_R2_001.fastq.gz T5S11-SCmiFish_S42_L002
T5S2-SCmiFish_S33_L002_R1_001.fastq.gz T5S2-SCmiFish_S33_L002
T5S2-SCmiFish_S33_L002_R2_001.fastq.gz T5S2-SCmiFish_S33_L002
T5S3-SCmiFish_S34_L002_R1_001.fastq.gz T5S3-SCmiFish_S34_L002
T5S3-SCmiFish_S34_L002_R2_001.fastq.gz T5S3-SCmiFish_S34_L002
T5S4-SCmiFish_S35_L002_R1_001.fastq.gz T5S4-SCmiFish_S35_L002
T5S4-SCmiFish_S35_L002_R2_001.fastq.gz T5S4-SCmiFish_S35_L002
T5S5-SCmiFish_S36_L002_R1_001.fastq.gz T5S5-SCmiFish_S36_L002
T5S5-SCmiFish_S36_L002_R2_001.fastq.gz T5S5-SCmiFish_S36_L002
T5S6-SCmiFish_S37_L002_R1_001.fastq.gz T5S6-SCmiFish_S37_L002
T5S6-SCmiFish_S37_L002_R2_001.fastq.gz T5S6-SCmiFish_S37_L002
T5S7-SCmiFish_S38_L002_R1_001.fastq.gz T5S7-SCmiFish_S38_L002
T5S7-SCmiFish_S38_L002_R2_001.fastq.gz T5S7-SCmiFish_S38_L002
T5S8-SCmiFish_S39_L002_R1_001.fastq.gz T5S8-SCmiFish_S39_L002
T5S8-SCmiFish_S39_L002_R2_001.fastq.gz T5S8-SCmiFish_S39_L002
T5S9-SCmiFish_S40_L002_R1_001.fastq.gz T5S9-SCmiFish_S40_L002
T5S9-SCmiFish_S40_L002_R2_001.fastq.gz T5S9-SCmiFish_S40_L002
T5Tiana-SCmiFish_S43_L002_R1_001.fastq.gz T5Tiana-SCmiFish_S43_L002
T5Tiana-SCmiFish_S43_L002_R2_001.fastq.gz T5Tiana-SCmiFish_S43_L002
T5Wessuck-SCmiFish_S44_L002_R1_001.fastq.gz T5Wessuck-SCmiFish_S44_L002
T5Wessuck-SCmiFish_S44_L002_R2_001.fastq.gz T5Wessuck-SCmiFish_S44_L002
T7Blank-SCmiFish_S60_L002_R1_001.fastq.gz T7Blank-SCmiFish_S60_L002
T7Blank-SCmiFish_S60_L002_R2_001.fastq.gz T7Blank-SCmiFish_S60_L002
T7PosCon-SCmiFish_S61_L002_R1_001.fastq.gz T7PosCon-SCmiFish_S61_L002
T7PosCon-SCmiFish_S61_L002_R2_001.fastq.gz T7PosCon-SCmiFish_S61_L002
T7S1-SCmiFish_S47_L002_R1_001.fastq.gz T7S1-SCmiFish_S47_L002
T7S1-SCmiFish_S47_L002_R2_001.fastq.gz T7S1-SCmiFish_S47_L002
T7S10-SCmiFish_S56_L002_R1_001.fastq.gz T7S10-SCmiFish_S56_L002
T7S10-SCmiFish_S56_L002_R2_001.fastq.gz T7S10-SCmiFish_S56_L002
T7S11-SCmiFish_S57_L002_R1_001.fastq.gz T7S11-SCmiFish_S57_L002
T7S11-SCmiFish_S57_L002_R2_001.fastq.gz T7S11-SCmiFish_S57_L002
T7S2-SCmiFish_S48_L002_R1_001.fastq.gz T7S2-SCmiFish_S48_L002
T7S2-SCmiFish_S48_L002_R2_001.fastq.gz T7S2-SCmiFish_S48_L002
T7S3-SCmiFish_S49_L002_R1_001.fastq.gz T7S3-SCmiFish_S49_L002
T7S3-SCmiFish_S49_L002_R2_001.fastq.gz T7S3-SCmiFish_S49_L002
T7S4-SCmiFish_S50_L002_R1_001.fastq.gz T7S4-SCmiFish_S50_L002
T7S4-SCmiFish_S50_L002_R2_001.fastq.gz T7S4-SCmiFish_S50_L002
T7S5-SCmiFish_S51_L002_R1_001.fastq.gz T7S5-SCmiFish_S51_L002
T7S5-SCmiFish_S51_L002_R2_001.fastq.gz T7S5-SCmiFish_S51_L002
T7S6-SCmiFish_S52_L002_R1_001.fastq.gz T7S6-SCmiFish_S52_L002
T7S6-SCmiFish_S52_L002_R2_001.fastq.gz T7S6-SCmiFish_S52_L002
T7S7-SCmiFish_S53_L002_R1_001.fastq.gz T7S7-SCmiFish_S53_L002
T7S7-SCmiFish_S53_L002_R2_001.fastq.gz T7S7-SCmiFish_S53_L002
T7S8-SCmiFish_S54_L002_R1_001.fastq.gz T7S8-SCmiFish_S54_L002
T7S8-SCmiFish_S54_L002_R2_001.fastq.gz T7S8-SCmiFish_S54_L002
T7S9-SCmiFish_S55_L002_R1_001.fastq.gz T7S9-SCmiFish_S55_L002
T7S9-SCmiFish_S55_L002_R2_001.fastq.gz T7S9-SCmiFish_S55_L002
T7Tiana-SCmiFish_S58_L002_R1_001.fastq.gz T7Tiana-SCmiFish_S58_L002
T7Tiana-SCmiFish_S58_L002_R2_001.fastq.gz T7Tiana-SCmiFish_S58_L002
T7Wessuck-SCmiFish_S59_L002_R1_001.fastq.gz T7Wessuck-SCmiFish_S59_L002
T7Wessuck-SCmiFish_S59_L002_R2_001.fastq.gz T7Wessuck-SCmiFish_S59_L002
T9Blank-SCmiFish_S75_L002_R1_001.fastq.gz T9Blank-SCmiFish_S75_L002
T9Blank-SCmiFish_S75_L002_R2_001.fastq.gz T9Blank-SCmiFish_S75_L002
T9PosCon-SCmiFish_S76_L002_R1_001.fastq.gz T9PosCon-SCmiFish_S76_L002
T9PosCon-SCmiFish_S76_L002_R2_001.fastq.gz T9PosCon-SCmiFish_S76_L002
T9S1-SCmiFish_S62_L002_R1_001.fastq.gz T9S1-SCmiFish_S62_L002
T9S1-SCmiFish_S62_L002_R2_001.fastq.gz T9S1-SCmiFish_S62_L002
T9S10-SCmiFish_S71_L002_R1_001.fastq.gz T9S10-SCmiFish_S71_L002
T9S10-SCmiFish_S71_L002_R2_001.fastq.gz T9S10-SCmiFish_S71_L002
T9S11-SCmiFish_S72_L002_R1_001.fastq.gz T9S11-SCmiFish_S72_L002
T9S11-SCmiFish_S72_L002_R2_001.fastq.gz T9S11-SCmiFish_S72_L002
T9S2-SCmiFish_S63_L002_R1_001.fastq.gz T9S2-SCmiFish_S63_L002
T9S2-SCmiFish_S63_L002_R2_001.fastq.gz T9S2-SCmiFish_S63_L002
T9S3-SCmiFish_S64_L002_R1_001.fastq.gz T9S3-SCmiFish_S64_L002
T9S3-SCmiFish_S64_L002_R2_001.fastq.gz T9S3-SCmiFish_S64_L002
T9S4-SCmiFish_S65_L002_R1_001.fastq.gz T9S4-SCmiFish_S65_L002
T9S4-SCmiFish_S65_L002_R2_001.fastq.gz T9S4-SCmiFish_S65_L002
T9S5-SCmiFish_S66_L002_R1_001.fastq.gz T9S5-SCmiFish_S66_L002
T9S5-SCmiFish_S66_L002_R2_001.fastq.gz T9S5-SCmiFish_S66_L002
T9S6-SCmiFish_S67_L002_R1_001.fastq.gz T9S6-SCmiFish_S67_L002
T9S6-SCmiFish_S67_L002_R2_001.fastq.gz T9S6-SCmiFish_S67_L002
T9S7-SCmiFish_S68_L002_R1_001.fastq.gz T9S7-SCmiFish_S68_L002
T9S7-SCmiFish_S68_L002_R2_001.fastq.gz T9S7-SCmiFish_S68_L002
T9S8-SCmiFish_S69_L002_R1_001.fastq.gz T9S8-SCmiFish_S69_L002
T9S8-SCmiFish_S69_L002_R2_001.fastq.gz T9S8-SCmiFish_S69_L002
T9S9-SCmiFish_S70_L002_R1_001.fastq.gz T9S9-SCmiFish_S70_L002
T9S9-SCmiFish_S70_L002_R2_001.fastq.gz T9S9-SCmiFish_S70_L002
T9Tiana-SCmiFish_S73_L002_R1_001.fastq.gz T9Tiana-SCmiFish_S73_L002
T9Tiana-SCmiFish_S73_L002_R2_001.fastq.gz T9Tiana-SCmiFish_S73_L002
T9Wessuck-SCmiFish_S74_L002_R1_001.fastq.gz T9Wessuck-SCmiFish_S74_L002
T9Wessuck-SCmiFish_S74_L002_R2_001.fastq.gz T9Wessuck-SCmiFish_S74_L002 
```

- still waiting on input on file names from Libby. Don't all match what is in current metadata sheet on Drive.
- Start working on 2022-
	- Actually there are issues with sample names here too!
- Waiting on input from Libby...
- Can start making metadata files for expedition


## 2024 Trawl eDNA Data- MiFish primers


Remove suffix from fastq files: `for file in *; do mv "${file}" "${file/_001/}"; done`

*If needed* remove prefix from file names (if re-running after mistake): `for file in * ; do mv -v "$file" "${file#*_}"; done`

Run REVAMP

```
conda activate REVAMPenv

revamp.sh -p 01_config_file_MIFish-2024.txt -f 02_figure_config_file_MiFish-2024.txt -s 03_sample_metadata_MiFish-2024.txt -r raw_data/2024-MiFish-U -o results-revamp-2024-MiFish
```

~Pasting output~

```
Running Cutadapt: Mon Dec  2 14:19:35 EST 2024
Finished Cutadapt: Mon Dec  2 14:29:23 EST 2024
Sample	Passing Reads	Passing bp
MP_T1Blank_S22_L001	99.6%	76.2%
MP_T1Positive_S22_L001	99.5%	76.3%
MP_T1S1_S22_L001	98.9%	76.3%
MP_T1S2_S22_L001	99.5%	76.9%
MP_T1S3_S22_L001	99.4%	76.9%
MP_T1S4_S22_L001	99.5%	76.6%
MP_T1S5_S22_L001	99.4%	76.9%
MP_T1S6_S22_L001	99.5%	76.8%
MP_T1S7_S22_L001	99.4%	76.7%
MP_T1S8_S22_L001	99.5%	76.6%
MP_T1S9_S22_L001	99.6%	77.2%
MP_T1S10_S22_L001	99.4%	77.3%
MP_T1S11_S22_L001	99.4%	78.5%
MP_T1WC_S22_L001	99.4%	78.2%
MP_T1TC_S22_L001	99.5%	77.9%
MP_T3Blank_S22_L001	99.4%	76.6%
MP_T3Positive_S22_L001	96.6%	74.3%
MP_T3S1_S22_L001	99.4%	76.8%
MP_T3S2_S22_L001	99.2%	76.4%
MP_T3S3_S22_L001	99.4%	76.6%
MP_T3S4_S22_L001	99.2%	76.9%
MP_T3S5_S22_L001	99.2%	76.7%
MP_T3S6_S22_L001	99.4%	78.8%
MP_T3S7_S22_L001	99.4%	76.8%
MP_T3S8_S22_L001	99.4%	76.8%
MP_T3S9_S22_L001	99.5%	76.8%
MP_T3S10_S22_L001	99.4%	76.6%
MP_T3S11_S22_L001	99.3%	76.6%
MP_T3WC_S22_L001	99.4%	76.8%
MP_T3TC_S22_L001	99.4%	76.6%
MP_T5SBlank_S22_L001	99.5%	76.4%
MP_T5S1_S22_L001	99.5%	76.8%
MP_T5S2_S22_L001	99.5%	76.8%
MP_T5S3_S22_L001	99.5%	76.7%
MP_T5S4_S22_L001	99.3%	76.9%
MP_T5S5_S22_L001	99.4%	76.7%
MP_T5S6_S23_L001	99.3%	76.9%
MP_T5S7_S23_L001	99.5%	76.7%
MP_T5S8_S23_L001	99.3%	76.6%
MP_T5S9_S23_L001	99.5%	76.6%
MP_T5S10_S23_L001	99.4%	78.5%
MP_T5S11_S23_L001	99.4%	76.7%
MP_T5WC_S23_L001	99.5%	76.7%
MP_T5TC_S23_L001	99.5%	76.6%
MP_T7Blank_S23_L001	99.1%	76.3%
MP_T7S1_S23_L001	99.4%	77.1%
MP_T7S2_S23_L001	99.3%	76.6%
MP_T7S3_S23_L001	99.5%	76.3%
MP_T7S4_S23_L001	99.5%	76.6%
MP_T7S5_S23_L001	99.4%	76.7%
MP_T7S6_S23_L001	99.2%	76.6%
MP_T7S7_S23_L001	99.4%	76.7%
MP_T7S8_S23_L001	99.5%	76.5%
MP_T7S9_S23_L001	99.4%	76.9%
MP_T7S10_S23_L001	99.4%	76.6%
MP_T7S11_S23_L001	99.4%	76.7%
MP_T7WC_S23_L001	99.4%	76.7%
MP_T7TC_S23_L001	99.4%	76.8%
MP_T7S2_1_S23_L001	99.5%	76.6%
MP_T7S9_1_S23_L001	99.4%	76.6%
MP_T72_2_S23_L001	99.3%	76.5%
MP_T79_2_S23_L001	99.3%	76.6%
MP_June_S1_S23_L001	99.4%	76.9%
MP_June_S3_S23_L001	96.5%	74.8%
MP_June_S6_S23_L001	99.4%	77.5%
MP_June_S9_S23_L001	98.0%	77.6%
MP_June_C4_S23_L001	99.2%	76.9%
MP_June_C5_S23_L001	99.4%	77.3%
MP_June_Blank_S23_L001	99.3%	76.3%
MP_June_Positive_S23_L001	99.2%	76.6%
MP_July_S1_S23_L001	99.4%	76.8%
MP_July_S3_S23_L001	99.5%	76.7%
MP_July_S6_S24_L001	99.3%	76.7%
MP_July_S9_S24_L001	99.4%	76.8%
MP_July_C4_S24_L001	99.4%	76.5%
MP_July_C5_S24_L001	99.2%	76.5%
MP_July_Blank_S24_L001	99.4%	76.3%
MP_AS1_S24_L001	99.4%	76.6%
MP_AS3_S24_L001	99.4%	76.9%
MP_AS6_S24_L001	99.5%	76.7%
MP_AS9_S24_L001	99.5%	78.0%
MP_AC4_S24_L001	99.5%	76.7%
MP_AC5_S24_L001	99.3%	77.4%
MP_A_Blank_S24_L001	99.6%	76.3%
MP_SS1_S24_L001	99.3%	76.5%
MP_SS3_S24_L001	99.5%	76.7%
MP_SS6_S24_L001	99.5%	76.5%
MP_SS9_S24_L001	99.6%	76.6%
MP_SC4_S24_L001	99.5%	77.3%
MP_SC5_S24_L001	99.5%	76.5%
MP_S_Blank_S24_L001	99.6%	76.4%
MP_S_Positive_S24_L001	99.5%	76.4%
MP_JT1_S24_L001	99.4%	76.5%
MP_JT3_S24_L001	99.3%	76.6%
MP_ATPositive_S24_L001	99.3%	76.2%
MP_AT1_S24_L001	99.4%	77.1%
MP_AT2_S24_L001	99.5%	76.5%
MP_AT3_S24_L001	99.3%	76.7%
MP_AT4_S24_L001	99.4%	76.7%
MP_STPositive_S24_L001	99.5%	76.6%
MP_ST1_S24_L001	99.5%	76.4%
MP_ST2_S24_L001	99.2%	77.6%
MP_ST3_S24_L001	99.4%	76.7%
MP_ST4_S24_L001	99.5%	76.6%
```

```
Running DADA2: Mon Dec  2 14:29:54 EST 2024
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_T1Blank_S22_L001_R1_trimmed.fq.gz 96.2923
MP_T1Positive_S22_L001_R1_trimmed.fq.gz 96.6726
MP_T1S1_S22_L001_R1_trimmed.fq.gz 96.0504
MP_T1S2_S22_L001_R1_trimmed.fq.gz 95.8572
MP_T1S3_S22_L001_R1_trimmed.fq.gz 96.0838
MP_T1S4_S22_L001_R1_trimmed.fq.gz 96.453
MP_T1S5_S22_L001_R1_trimmed.fq.gz 96.365
MP_T1S6_S22_L001_R1_trimmed.fq.gz 96.3417
MP_T1S7_S22_L001_R1_trimmed.fq.gz 96.4566
MP_T1S8_S22_L001_R1_trimmed.fq.gz 96.8182
MP_T1S9_S22_L001_R1_trimmed.fq.gz 96.1792
MP_T1S10_S22_L001_R1_trimmed.fq.gz 96.0932
MP_T1S11_S22_L001_R1_trimmed.fq.gz 95.463
MP_T1WC_S22_L001_R1_trimmed.fq.gz 95.124
MP_T1TC_S22_L001_R1_trimmed.fq.gz 95.0554
MP_T3Blank_S22_L001_R1_trimmed.fq.gz 96.5958
MP_T3Positive_S22_L001_R1_trimmed.fq.gz 96.7875
MP_T3S1_S22_L001_R1_trimmed.fq.gz 96.6339
MP_T3S2_S22_L001_R1_trimmed.fq.gz 95.9223
MP_T3S3_S22_L001_R1_trimmed.fq.gz 96.7037
MP_T3S4_S22_L001_R1_trimmed.fq.gz 95.8377
MP_T3S5_S22_L001_R1_trimmed.fq.gz 95.2468
MP_T3S6_S22_L001_R1_trimmed.fq.gz 96.2253
MP_T3S7_S22_L001_R1_trimmed.fq.gz 96.6403
MP_T3S8_S22_L001_R1_trimmed.fq.gz 96.7426
MP_T3S9_S22_L001_R1_trimmed.fq.gz 96.516
MP_T3S10_S22_L001_R1_trimmed.fq.gz 96.6264
MP_T3S11_S22_L001_R1_trimmed.fq.gz 96.1346
MP_T3WC_S22_L001_R1_trimmed.fq.gz 96.5095
MP_T3TC_S22_L001_R1_trimmed.fq.gz 96.7631
MP_T5SBlank_S22_L001_R1_trimmed.fq.gz 96.195
MP_T5S1_S22_L001_R1_trimmed.fq.gz 96.7459
MP_T5S2_S22_L001_R1_trimmed.fq.gz 96.6035
MP_T5S3_S22_L001_R1_trimmed.fq.gz 96.6726
MP_T5S4_S22_L001_R1_trimmed.fq.gz 96.1231
MP_T5S5_S22_L001_R1_trimmed.fq.gz 96.8377
MP_T5S6_S23_L001_R1_trimmed.fq.gz 95.7014
MP_T5S7_S23_L001_R1_trimmed.fq.gz 97.0246
MP_T5S8_S23_L001_R1_trimmed.fq.gz 96.5583
MP_T5S9_S23_L001_R1_trimmed.fq.gz 97.0209
MP_T5S10_S23_L001_R1_trimmed.fq.gz 96.8242
MP_T5S11_S23_L001_R1_trimmed.fq.gz 96.8219
MP_T5WC_S23_L001_R1_trimmed.fq.gz 96.6961
MP_T5TC_S23_L001_R1_trimmed.fq.gz 97.3101
MP_T7Blank_S23_L001_R1_trimmed.fq.gz 96.4033
MP_T7S1_S23_L001_R1_trimmed.fq.gz 95.9461
MP_T7S2_S23_L001_R1_trimmed.fq.gz 96.6012
MP_T7S3_S23_L001_R1_trimmed.fq.gz 96.9533
MP_T7S4_S23_L001_R1_trimmed.fq.gz 96.8711
MP_T7S5_S23_L001_R1_trimmed.fq.gz 96.7211
MP_T7S6_S23_L001_R1_trimmed.fq.gz 96.2336
MP_T7S7_S23_L001_R1_trimmed.fq.gz 96.4241
MP_T7S8_S23_L001_R1_trimmed.fq.gz 96.6988
MP_T7S9_S23_L001_R1_trimmed.fq.gz 96.5563
MP_T7S10_S23_L001_R1_trimmed.fq.gz 96.3435
MP_T7S11_S23_L001_R1_trimmed.fq.gz 96.2234
MP_T7WC_S23_L001_R1_trimmed.fq.gz 96.2607
MP_T7TC_S23_L001_R1_trimmed.fq.gz 97.0245
MP_T7S2_1_S23_L001_R1_trimmed.fq.gz 96.4609
MP_T7S9_1_S23_L001_R1_trimmed.fq.gz 96.6718
MP_T72_2_S23_L001_R1_trimmed.fq.gz 96.2919
MP_T79_2_S23_L001_R1_trimmed.fq.gz 96.3866
MP_June_S1_S23_L001_R1_trimmed.fq.gz 96.7282
MP_June_S3_S23_L001_R1_trimmed.fq.gz 96.4124
MP_June_S6_S23_L001_R1_trimmed.fq.gz 96.6145
MP_June_S9_S23_L001_R1_trimmed.fq.gz 95.9439
MP_June_C4_S23_L001_R1_trimmed.fq.gz 95.8533
MP_June_C5_S23_L001_R1_trimmed.fq.gz 96.5168
MP_June_Blank_S23_L001_R1_trimmed.fq.gz 95.5028
MP_June_Positive_S23_L001_R1_trimmed.fq.gz 95.9989
MP_July_S1_S23_L001_R1_trimmed.fq.gz 96.9743
MP_July_S3_S23_L001_R1_trimmed.fq.gz 96.5677
MP_July_S6_S24_L001_R1_trimmed.fq.gz 96.3813
MP_July_S9_S24_L001_R1_trimmed.fq.gz 96.5819
MP_July_C4_S24_L001_R1_trimmed.fq.gz 96.2717
MP_July_C5_S24_L001_R1_trimmed.fq.gz 96.0145
MP_July_Blank_S24_L001_R1_trimmed.fq.gz 96.2609
MP_AS1_S24_L001_R1_trimmed.fq.gz 96.4056
MP_AS3_S24_L001_R1_trimmed.fq.gz 96.0904
MP_AS6_S24_L001_R1_trimmed.fq.gz 96.5523
MP_AS9_S24_L001_R1_trimmed.fq.gz 95.606
MP_AC4_S24_L001_R1_trimmed.fq.gz 96.3175
MP_AC5_S24_L001_R1_trimmed.fq.gz 95.719
MP_A_Blank_S24_L001_R1_trimmed.fq.gz 96.4254
MP_SS1_S24_L001_R1_trimmed.fq.gz 95.9717
MP_SS3_S24_L001_R1_trimmed.fq.gz 96.5923
MP_SS6_S24_L001_R1_trimmed.fq.gz 96.0416
MP_SS9_S24_L001_R1_trimmed.fq.gz 97.151
MP_SC4_S24_L001_R1_trimmed.fq.gz 96.4807
MP_SC5_S24_L001_R1_trimmed.fq.gz 96.5304
MP_S_Blank_S24_L001_R1_trimmed.fq.gz 95.9138
MP_S_Positive_S24_L001_R1_trimmed.fq.gz 97.3114
MP_JT1_S24_L001_R1_trimmed.fq.gz 96.518
MP_JT3_S24_L001_R1_trimmed.fq.gz 95.6779
MP_ATPositive_S24_L001_R1_trimmed.fq.gz 96.3921
MP_AT1_S24_L001_R1_trimmed.fq.gz 96.3839
MP_AT2_S24_L001_R1_trimmed.fq.gz 96.8972
MP_AT3_S24_L001_R1_trimmed.fq.gz 96.2941
MP_AT4_S24_L001_R1_trimmed.fq.gz 96.6301
MP_STPositive_S24_L001_R1_trimmed.fq.gz 96.4438
MP_ST1_S24_L001_R1_trimmed.fq.gz 96.5311
MP_ST2_S24_L001_R1_trimmed.fq.gz 95.7697
MP_ST3_S24_L001_R1_trimmed.fq.gz 96.132
MP_ST4_S24_L001_R1_trimmed.fq.gz 96.5269
```

```
Learning error, Dereplication, Merge, and ASVs in DADA2...
Please be patient, may take a while. Messages printed to Rscript log.


FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_T1Blank_S22_L001 94.1
MP_T1Positive_S22_L001 91.5
MP_T1S1_S22_L001 91.7
MP_T1S2_S22_L001 86.8
MP_T1S3_S22_L001 90.2
MP_T1S4_S22_L001 89.4
MP_T1S5_S22_L001 91.6
MP_T1S6_S22_L001 91.3
MP_T1S7_S22_L001 90.8
MP_T1S8_S22_L001 92.1
MP_T1S9_S22_L001 90.4
MP_T1S10_S22_L001 91.9
MP_T1S11_S22_L001 90.6
MP_T1WC_S22_L001 86.7
MP_T1TC_S22_L001 85.2
MP_T3Blank_S22_L001 94
MP_T3Positive_S22_L001 93.7
MP_T3S1_S22_L001 84.1
MP_T3S2_S22_L001 92.5
MP_T3S3_S22_L001 89.6
MP_T3S4_S22_L001 86.8
MP_T3S5_S22_L001 90
MP_T3S6_S22_L001 77.4
MP_T3S7_S22_L001 89.3
MP_T3S8_S22_L001 89.2
MP_T3S9_S22_L001 90.4
MP_T3S10_S22_L001 91.9
MP_T3S11_S22_L001 81.6
MP_T3WC_S22_L001 86.7
MP_T3TC_S22_L001 89.9
MP_T5SBlank_S22_L001 93.8
MP_T5S1_S22_L001 91.1
MP_T5S2_S22_L001 91.5
MP_T5S3_S22_L001 89.7
MP_T5S4_S22_L001 88.4
MP_T5S5_S22_L001 92.2
MP_T5S6_S23_L001 87.5
MP_T5S7_S23_L001 88.6
MP_T5S8_S23_L001 88.4
MP_T5S9_S23_L001 82.3
MP_T5S10_S23_L001 90.9
MP_T5S11_S23_L001 88
MP_T5WC_S23_L001 85.5
MP_T5TC_S23_L001 84.7
MP_T7Blank_S23_L001 94.7
MP_T7S1_S23_L001 90.1
MP_T7S2_S23_L001 88.9
MP_T7S3_S23_L001 91.8
MP_T7S4_S23_L001 90.3
MP_T7S5_S23_L001 91.4
MP_T7S6_S23_L001 87.3
MP_T7S7_S23_L001 90.1
MP_T7S8_S23_L001 89
MP_T7S9_S23_L001 89.1
MP_T7S10_S23_L001 89.5
MP_T7S11_S23_L001 90
MP_T7WC_S23_L001 90
MP_T7TC_S23_L001 91.2
MP_T7S2_1_S23_L001 90.1
MP_T7S9_1_S23_L001 90.8
MP_T72_2_S23_L001 89.8
MP_T79_2_S23_L001 89.6
MP_June_S1_S23_L001 90.1
MP_June_S3_S23_L001 91.9
MP_June_S6_S23_L001 90.8
MP_June_S9_S23_L001 91.2
MP_June_C4_S23_L001 90.6
MP_June_C5_S23_L001 90
MP_June_Blank_S23_L001 92
MP_June_Positive_S23_L001 92.3
MP_July_S1_S23_L001 88.6
MP_July_S3_S23_L001 89.4
MP_July_S6_S24_L001 89.4
MP_July_S9_S24_L001 88.9
MP_July_C4_S24_L001 87.8
MP_July_C5_S24_L001 83.7
MP_July_Blank_S24_L001 91.4
MP_AS1_S24_L001 90.2
MP_AS3_S24_L001 86.8
MP_AS6_S24_L001 91.6
MP_AS9_S24_L001 90.1
MP_AC4_S24_L001 91.7
MP_AC5_S24_L001 84.5
MP_A_Blank_S24_L001 93.6
MP_SS1_S24_L001 86.7
MP_SS3_S24_L001 89.1
MP_SS6_S24_L001 87.7
MP_SS9_S24_L001 90.6
MP_SC4_S24_L001 90.5
MP_SC5_S24_L001 82.6
MP_S_Blank_S24_L001 93.3
MP_S_Positive_S24_L001 94.1
MP_JT1_S24_L001 90.2
MP_JT3_S24_L001 88.8
MP_ATPositive_S24_L001 91.7
MP_AT1_S24_L001 91.6
MP_AT2_S24_L001 91.5
MP_AT3_S24_L001 88.3
MP_AT4_S24_L001 84.4
MP_STPositive_S24_L001 91.1
MP_ST1_S24_L001 91.1
MP_ST2_S24_L001 91.5
MP_ST3_S24_L001 86
MP_ST4_S24_L001 90.7
```



## Jan 10-15 2025
Jump back into 2021 and 2022 MiFish librariers- need to run through REVAMP

### 2021 MiFish
Remove suffix from fastq files: `for file in *; do mv "${file}" "${file/_001/}"; done`

*If needed* remove prefix from file names (if re-running after mistake): `for file in * ; do mv -v "$file" "${file#*_}"; done`

Run REVAMP

```
conda activate REVAMPenv

revamp.sh -p 01_config_file_MiFish-2021.txt -f 02_figure_config_file_MiFish-2021.txt -s 03_sample_metadata_MiFish-2021.txt -r raw_data/2021-MiFish-U -o results-revamp-2021-MiFish
```

~Pasting output~

```
Running Cutadapt: Wed Jan 15 09:22:16 EST 2025
Finished Cutadapt: Wed Jan 15 10:07:06 EST 2025
Sample	Passing Reads	Passing bp
MP_T1S1_SCmiFish_S2_L002	78.3%	76.5%
MP_T1S2_SCmiFish_S3_L002	69.0%	72.2%
MP_T1S3_SCmiFish_S4_L002	89.1%	80.3%
MP_T1S4_SCmiFish_S5_L002	88.0%	80.1%
MP_T1S5_SCmiFish_S6_L002	90.2%	80.7%
MP_T1S6_SCmiFish_S7_L002	71.6%	73.9%
MP_T1S7_SCmiFish_S8_L002	87.5%	79.8%
MP_T1S8_SCmiFish_S9_L002	97.1%	83.0%
MP_T1S9_SCmiFish_S10_L002	92.6%	81.5%
MP_T1S10_SCmiFish_S11_L002	86.0%	79.3%
MP_T1S11_SCmiFish_S12_L002	97.9%	82.4%
MP_T1CTiana_SCmiFish_S13_L002	99.0%	83.0%
MP_T1CW_SCmiFish_S14_L002	88.0%	79.5%
MP_T1Blank_SCmiFish_S15_L002	22.8%	23.3%
MP_T1PosCon_SCmiFish_S16_L002	98.5%	82.9%
MP_T3S1_SCmiFish_S17_L002	98.7%	82.9%
MP_T3S2_SCmiFish_S18_L002	97.1%	82.1%
MP_T3S3_SCmiFish_S19_L002	89.2%	80.1%
MP_T3S4_SCmiFish_S20_L002	99.1%	83.2%
MP_T3S5_SCmiFish_S21_L002	99.2%		83.3%
MP_T3S6_SCmiFish_S22_L002	98.9%	83.3%
MP_T3S7_SCmiFish_S23_L002	99.3%	83.1%
MP_T3S8_SCmiFish_S24_L002	90.7%	74.6%
MP_T3S9_SCmiFish_S25_L002	98.1%	82.7%
MP_T3S10_SCmiFish_S26_L002	99.0%	83.2%
MP_T3S11_SCmiFish_S27_L002	99.4%	83.5%
MP_T3TC_SCmiFish_S28_L002	98.2%	82.8%
MP_T3WC_SCmiFish_S29_L002	93.3%	75.8%
MP_T3Blank_SCmiFish_S30_L002	86.6%	9.5%
MP_T3PosCon_SCmiFish_S31_L002	99.0%	83.1%
MP_T5S1_SCmiFish_S32_L002	97.0%	82.6%
MP_T5S2_SCmiFish_S33_L002	93.6%	80.5%
MP_T5S3_SCmiFish_S34_L002	96.9%	75.3%
MP_T5S4_SCmiFish_S35_L002	80.4%	77.1%
MP_T5S5_SCmiFish_S36_L002	85.0%	74.7%
MP_T5S6_SCmiFish_S37_L002	98.3%	82.9%
MP_T5S7_SCmiFish_S38_L002	97.5%	75.9%
MP_T5S8_SCmiFish_S39_L002	90.6%	77.8%
MP_T5S9_SCmiFish_S40_L002	81.0%	73.1%
MP_T5S10_SCmiFish_S41_L002	98.8%	82.6%
MP_T5S11_SCmiFish_S42_L002	81.8%	68.2%
MP_T5Tiana_SCmiFish_S43_L002	99.0%	83.0%
MP_T5Wessuck_SCmiFish_S44_L002	95.4%	77.7%
MP_T5Blank_SCmiFish_S45_L002	71.7%	26.6%
MP_T5PosCon_SCmiFish_S46_L002	93.1%	72.4%
MP_T7S1_SCmiFish_S47_L002	96.1%	82.1%
MP_T7S2_SCmiFish_S48_L002	88.6%	79.8%
MP_T7S3_SCmiFish_S49_L002	95.2%	82.2%
MP_T7S4_SCmiFish_S50_L002	98.2%	82.7%
MP_T7S5_SCmiFish_S51_L002	98.8%	83.0%
MP_T7S6_SCmiFish_S52_L002	90.7%	80.6%
MP_T7S7_SCmiFish_S53_L002	74.0%	73.6%
MP_T7S8_SCmiFish_S54_L002	93.9%	68.8%
MP_T7S9_SCmiFish_S55_L002	97.3%	76.1%
MP_T7S10_SCmiFish_S56_L002	91.5%	72.2%
MP_T7S11_SCmiFish_S57_L002	95.1%	76.4%
MP_T7Tiana_SCmiFish_S58_L002	98.7%	82.9%
MP_T7Wessuck_SCmiFish_S59_L002	92.4%	81.0%
MP_T7Blank_SCmiFish_S60_L002	23.0%	13.7%
MP_T7PosCon_SCmiFish_S61_L002	94.1%	77.2%
MP_T9S1_SCmiFish_S62_L002	99.0%	83.1%
MP_T9S2_SCmiFish_S63_L002	98.4%	82.9%
MP_T9S3_SCmiFish_S64_L002	92.3%	79.2%
MP_T9S4_SCmiFish_S65_L002	91.8%	72.7%
MP_T9S5_SCmiFish_S66_L002	81.9%	71.2%
MP_T9S6_SCmiFish_S67_L002	94.3%	77.8%
MP_T9S7_SCmiFish_S68_L002	91.1%	80.6%
MP_T9S8_SCmiFish_S69_L002	96.8%	82.3%
MP_T9S9_SCmiFish_S70_L002	92.4%	71.2%
MP_T9S10_SCmiFish_S71_L002	95.7%	76.6%
MP_T9S11_SCmiFish_S72_L002	90.1%	79.6%
MP_T9Tiana_SCmiFish_S73_L002	96.3%	81.4%
MP_T9Wessuck_SCmiFish_S74_L002	98.9%	82.9%
MP_T9Blank_SCmiFish_S75_L002	20.3%	33.3%
MP_T9PosCon_SCmiFish_S76_L002	92.6%	80.6%
MP_T10S1_SCmiFish_S77_L002	98.9%	83.2%
MP_T10S2_SCmiFish_S78_L002	78.8%	67.3%
MP_T10S3_SCmiFish_S79_L002	99.0%	82.8%
MP_T10S4_SCmiFish_S80_L002	99.2%	83.0%
MP_T10S5_SCmiFish_S81_L002	99.4%	83.3%
MP_T10S6_SCmiFish_S82_L002	99.3%	83.2%
MP_T10S7_SCmiFish_S83_L002	99.1%	83.1%
MP_T10S8_SCmiFish_S84_L002	98.5%	82.3%
MP_T10S9_SCmiFish_S85_L002	99.2%	82.7%
MP_T10S10_SCmiFish_S86_L002	96.9%	82.6%
MP_T10S11_SCmiFish_S87_L002	98.6%	82.2%
MP_T10Tiana_SCmiFish_S88_L002	98.6%	82.7%
MP_T10Wessuck_SCmiFish_S89_L002	96.2%	77.8%
MP_T10Blank_SCmiFish_S90_L002	78.6%	16.1%
MP_T10PosCon_SCmiFish_S91_L002	89.7%	73.5%
MP_JSedge1_SCmiFish_S92_L002	87.9%	67.3%
MP_JSedge2_SCmiFish_S93_L002	94.6%	73.4%
MP_JSedge3_SCmiFish_S94_L002	81.5%	75.7%
MP_JSedge4_SCmiFish_S95_L002	83.5%	75.4%
MP_JSedge5_SCmiFish_S96_L002	98.9%	83.3%
MP_JSedge6_SCmiFish_S97_L002	97.3%	81.5%
MP_JSedge7_SCmiFish_S98_L002	86.2%	79.0%
MP_JSedge8_SCmiFish_S99_L002	90.0%	80.3%
MP_JSedge9_SCmiFish_S100_L002	96.8%	82.4%
MP_JSedge10_SCmiFish_S101_L002	94.0%	79.7%
MP_JCanal1_SCmiFish_S102_L002	93.8%	81.6%
MP_JCanal2_SCmiFish_S103_L002	90.6%	77.2%
MP_JCanal3_SCmiFish_S104_L002	91.7%	80.7%
MP_JCanal4_SCmiFish_S105_L002	87.8%	79.6%
MP_JCanal5_SCmiFish_S106_L002	84.8%	72.4%
MP_JCanal6_SCmiFish_S107_L002	71.3%	73.6%
MP_JCanal7_SCmiFish_S108_L002	92.3%	77.2%
MP_JCanal8_SCmiFish_S109_L002	98.6%	83.1%
MP_Jblank_SCmiFish_S110_L002	53.7%	22.2%
MP_JPosCon_SCmiFish_S111_L002	97.7%	82.5%
MP_ASedge1_SCmiFish_S112_L002	86.8%	71.9%
MP_ASedge2_SCmiFish_S113_L002	90.4%	79.5%
MP_ASedge3_SCmiFish_S114_L002	89.0%	76.9%
MP_ASedge4_SCmiFish_S115_L002	90.9%	80.0%
MP_ASedge5_SCmiFish_S116_L002	93.3%	80.3%
MP_ASedge6_SCmiFish_S117_L002	78.4%	76.4%
MP_ASedge7_SCmiFish_S118_L002	79.8%	77.0%
MP_ASedge8_SCmiFish_S119_L002	92.7%	80.9%
MP_ASedge9_SCmiFish_S120_L002	94.1%	81.6%
MP_ASedge10_SCmiFish_S121_L002	90.3%	80.1%
MP_ACanal1_SCmiFish_S122_L002	93.3%	75.6%
MP_ACanal2_SCmiFish_S123_L002	85.5%	75.1%
MP_ACanal3_SCmiFish_S124_L002	92.8%	73.0%
MP_ACanal4_SCmiFish_S125_L002	84.9%	73.5%
MP_ACanal5_SCmiFish_S126_L002	83.7%	77.9%
MP_ACanal6_SCmiFish_S127_L002	86.6%	72.4%
MP_ACanal7_SCmiFish_S128_L002	88.6%	75.0%
MP_ACanal8_SCmiFish_S129_L002	96.7%	71.8%
MP_Ablank_SCmiFish_S130_L002	59.2%	8.7%
MP_APosCon_SCmiFish_S131_L002	99.1%	83.3%
MP_SSedge1_SCmiFish_S132_L002	91.1%	78.8%
MP_SSedge2_SCmiFish_S133_L002	87.9%	77.5%
MP_SSedge3_SCmiFish_S134_L002	99.3%	83.5%
MP_SSedge4_SCmiFish_S135_L002	99.2%	83.2%
MP_SSedge5_SCmiFish_S136_L002	83.7%	77.5%
MP_SSedge6_SCmiFish_S137_L002	91.0%	80.8%
MP_SSedge7_SCmiFish_S138_L002	86.2%	72.8%
MP_SSedge8_SCmiFish_S139_L002	85.1%	78.8%
MP_SSedge9_SCmiFish_S140_L002	95.5%	74.5%
MP_SSedge10_SCmiFish_S141_L002	84.8%	76.7%
MP_SCanal1_SCmiFish_S142_L002	91.9%	80.9%
MP_SCanal2_SCmiFish_S143_L002	99.4%	83.3%
MP_SCanal3_SCmiFish_S144_L002	91.8%	80.7%
MP_SCanal4_SCmiFish_S145_L002	81.9%	77.3%
MP_SCanal5_SCmiFish_S146_L002	98.8%	82.8%
MP_SCanal6_SCmiFish_S147_L002	98.7%	83.2%
MP_SCanal7_SCmiFish_S148_L002	86.6%	79.3%
MP_SCanal8_SCmiFish_S149_L002	88.9%	76.5%
MP_Sblank_SCmiFish_S150_L002	45.1%	8.7%
MP_SPosCon_SCmiFish_S151_L002	99.1%	83.0%
```


```
Running DADA2: Wed Jan 15 10:08:21 EST 2025
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_T1S1_SCmiFish_S2_L002_R1_trimmed.fq.gz 98.0108
MP_T1S2_SCmiFish_S3_L002_R1_trimmed.fq.gz 95.6706
MP_T1S3_SCmiFish_S4_L002_R1_trimmed.fq.gz 97.7527
MP_T1S4_SCmiFish_S5_L002_R1_trimmed.fq.gz 98.0107
MP_T1S5_SCmiFish_S6_L002_R1_trimmed.fq.gz 97.6269
MP_T1S6_SCmiFish_S7_L002_R1_trimmed.fq.gz 97.9926
MP_T1S7_SCmiFish_S8_L002_R1_trimmed.fq.gz 97.7284
MP_T1S8_SCmiFish_S9_L002_R1_trimmed.fq.gz 97.9734
MP_T1S9_SCmiFish_S10_L002_R1_trimmed.fq.gz 97.5925
MP_T1S10_SCmiFish_S11_L002_R1_trimmed.fq.gz 97.9588
MP_T1S11_SCmiFish_S12_L002_R1_trimmed.fq.gz 95.0854
MP_T1CTiana_SCmiFish_S13_L002_R1_trimmed.fq.gz 96.89
MP_T1CW_SCmiFish_S14_L002_R1_trimmed.fq.gz 95.8667
MP_T1Blank_SCmiFish_S15_L002_R1_trimmed.fq.gz 42.9892
MP_T1PosCon_SCmiFish_S16_L002_R1_trimmed.fq.gz 96.9781
MP_T3S1_SCmiFish_S17_L002_R1_trimmed.fq.gz 96.6626
MP_T3S2_SCmiFish_S18_L002_R1_trimmed.fq.gz 94.9782
MP_T3S3_SCmiFish_S19_L002_R1_trimmed.fq.gz 97.0189
MP_T3S4_SCmiFish_S20_L002_R1_trimmed.fq.gz 97.6101
MP_T3S5_SCmiFish_S21_L002_R1_trimmed.fq.gz 97.8685
MP_T3S6_SCmiFish_S22_L002_R1_trimmed.fq.gz 97.9615
MP_T3S7_SCmiFish_S23_L002_R1_trimmed.fq.gz 96.4886
MP_T3S8_SCmiFish_S24_L002_R1_trimmed.fq.gz 78.0555
MP_T3S9_SCmiFish_S25_L002_R1_trimmed.fq.gz 96.9694
MP_T3S10_SCmiFish_S26_L002_R1_trimmed.fq.gz 97.3475
MP_T3S11_SCmiFish_S27_L002_R1_trimmed.fq.gz 97.8116
MP_T3TC_SCmiFish_S28_L002_R1_trimmed.fq.gz 96.8144
MP_T3WC_SCmiFish_S29_L002_R1_trimmed.fq.gz 79.9042
MP_T3Blank_SCmiFish_S30_L002_R1_trimmed.fq.gz 0.227592
MP_T3PosCon_SCmiFish_S31_L002_R1_trimmed.fq.gz 97.1472
MP_T5S1_SCmiFish_S32_L002_R1_trimmed.fq.gz 97.2576
MP_T5S2_SCmiFish_S33_L002_R1_trimmed.fq.gz 93.7299
MP_T5S3_SCmiFish_S34_L002_R1_trimmed.fq.gz 74.8482
MP_T5S4_SCmiFish_S35_L002_R1_trimmed.fq.gz 97.0872
MP_T5S5_SCmiFish_S36_L002_R1_trimmed.fq.gz 85.0477
MP_T5S6_SCmiFish_S37_L002_R1_trimmed.fq.gz 97.3984
MP_T5S7_SCmiFish_S38_L002_R1_trimmed.fq.gz 76.467
MP_T5S8_SCmiFish_S39_L002_R1_trimmed.fq.gz 88.2748
MP_T5S9_SCmiFish_S40_L002_R1_trimmed.fq.gz 84.0968
MP_T5S10_SCmiFish_S41_L002_R1_trimmed.fq.gz 95.5717
MP_T5S11_SCmiFish_S42_L002_R1_trimmed.fq.gz 70.3844
MP_T5Tiana_SCmiFish_S43_L002_R1_trimmed.fq.gz 96.9409
MP_T5Wessuck_SCmiFish_S44_L002_R1_trimmed.fq.gz 82.861
MP_T5Blank_SCmiFish_S45_L002_R1_trimmed.fq.gz 14.6564
MP_T5PosCon_SCmiFish_S46_L002_R1_trimmed.fq.gz 70.5207
MP_T7S1_SCmiFish_S47_L002_R1_trimmed.fq.gz 96.555
MP_T7S2_SCmiFish_S48_L002_R1_trimmed.fq.gz 96.5036
MP_T7S3_SCmiFish_S49_L002_R1_trimmed.fq.gz 97.8581
MP_T7S4_SCmiFish_S50_L002_R1_trimmed.fq.gz 96.8855
MP_T7S5_SCmiFish_S51_L002_R1_trimmed.fq.gz 96.5705
MP_T7S6_SCmiFish_S52_L002_R1_trimmed.fq.gz 97.0688
MP_T7S7_SCmiFish_S53_L002_R1_trimmed.fq.gz 94.3907
MP_T7S8_SCmiFish_S54_L002_R1_trimmed.fq.gz 61.7463
MP_T7S9_SCmiFish_S55_L002_R1_trimmed.fq.gz 76.553
MP_T7S10_SCmiFish_S56_L002_R1_trimmed.fq.gz 72.2134
MP_T7S11_SCmiFish_S57_L002_R1_trimmed.fq.gz 80.0875
MP_T7Tiana_SCmiFish_S58_L002_R1_trimmed.fq.gz 96.7033
MP_T7Wessuck_SCmiFish_S59_L002_R1_trimmed.fq.gz 96.5202
MP_T7Blank_SCmiFish_S60_L002_R1_trimmed.fq.gz 18.0129
MP_T7PosCon_SCmiFish_S61_L002_R1_trimmed.fq.gz 83.0258
MP_T9S1_SCmiFish_S62_L002_R1_trimmed.fq.gz 96.9267
MP_T9S2_SCmiFish_S63_L002_R1_trimmed.fq.gz 96.9059
MP_T9S3_SCmiFish_S64_L002_R1_trimmed.fq.gz 90.5129
MP_T9S4_SCmiFish_S65_L002_R1_trimmed.fq.gz 72.6061
MP_T9S5_SCmiFish_S66_L002_R1_trimmed.fq.gz 77.7491
MP_T9S6_SCmiFish_S67_L002_R1_trimmed.fq.gz 83.7635
MP_T9S7_SCmiFish_S68_L002_R1_trimmed.fq.gz 96.6119
MP_T9S8_SCmiFish_S69_L002_R1_trimmed.fq.gz 96.8475
MP_T9S9_SCmiFish_S70_L002_R1_trimmed.fq.gz 68.6219
MP_T9S10_SCmiFish_S71_L002_R1_trimmed.fq.gz 79.6841
MP_T9S11_SCmiFish_S72_L002_R1_trimmed.fq.gz 94.5396
MP_T9Tiana_SCmiFish_S73_L002_R1_trimmed.fq.gz 93.6929
MP_T9Wessuck_SCmiFish_S74_L002_R1_trimmed.fq.gz 96.4189
MP_T9Blank_SCmiFish_S75_L002_R1_trimmed.fq.gz 86.7907
MP_T9PosCon_SCmiFish_S76_L002_R1_trimmed.fq.gz 95.1412
MP_T10S1_SCmiFish_S77_L002_R1_trimmed.fq.gz 97.606
MP_T10S2_SCmiFish_S78_L002_R1_trimmed.fq.gz 69.5779
MP_T10S3_SCmiFish_S79_L002_R1_trimmed.fq.gz 96.1206
MP_T10S4_SCmiFish_S80_L002_R1_trimmed.fq.gz 96.3274
MP_T10S5_SCmiFish_S81_L002_R1_trimmed.fq.gz 97.4706
MP_T10S6_SCmiFish_S82_L002_R1_trimmed.fq.gz 96.9266
MP_T10S7_SCmiFish_S83_L002_R1_trimmed.fq.gz 96.9408
MP_T10S8_SCmiFish_S84_L002_R1_trimmed.fq.gz 94.8257
MP_T10S9_SCmiFish_S85_L002_R1_trimmed.fq.gz 95.3202
MP_T10S10_SCmiFish_S86_L002_R1_trimmed.fq.gz 97.2322
MP_T10S11_SCmiFish_S87_L002_R1_trimmed.fq.gz 94.4268
MP_T10Tiana_SCmiFish_S88_L002_R1_trimmed.fq.gz 96.0803
MP_T10Wessuck_SCmiFish_S89_L002_R1_trimmed.fq.gz 82.2324
MP_T10Blank_SCmiFish_S90_L002_R1_trimmed.fq.gz 0.0146715
MP_T10PosCon_SCmiFish_S91_L002_R1_trimmed.fq.gz 75.697
MP_JSedge1_SCmiFish_S92_L002_R1_trimmed.fq.gz 64.2038
MP_JSedge2_SCmiFish_S93_L002_R1_trimmed.fq.gz 72.1072
MP_JSedge3_SCmiFish_S94_L002_R1_trimmed.fq.gz 90.9392
MP_JSedge4_SCmiFish_S95_L002_R1_trimmed.fq.gz 88.1995
MP_JSedge5_SCmiFish_S96_L002_R1_trimmed.fq.gz 98.0742
MP_JSedge6_SCmiFish_S97_L002_R1_trimmed.fq.gz 92.6261
MP_JSedge7_SCmiFish_S98_L002_R1_trimmed.fq.gz 96.3438
MP_JSedge8_SCmiFish_S99_L002_R1_trimmed.fq.gz 96.2689
MP_JSedge9_SCmiFish_S100_L002_R1_trimmed.fq.gz 96.4865
MP_JSedge10_SCmiFish_S101_L002_R1_trimmed.fq.gz 90.5637
MP_JCanal1_SCmiFish_S102_L002_R1_trimmed.fq.gz 97.2323
MP_JCanal2_SCmiFish_S103_L002_R1_trimmed.fq.gz 85.7835
MP_JCanal3_SCmiFish_S104_L002_R1_trimmed.fq.gz 96.104
MP_JCanal4_SCmiFish_S105_L002_R1_trimmed.fq.gz 95.7212
MP_JCanal5_SCmiFish_S106_L002_R1_trimmed.fq.gz 77.5153
MP_JCanal6_SCmiFish_S107_L002_R1_trimmed.fq.gz 96.787
MP_JCanal7_SCmiFish_S108_L002_R1_trimmed.fq.gz 84.0273
MP_JCanal8_SCmiFish_S109_L002_R1_trimmed.fq.gz 97.2183
MP_Jblank_SCmiFish_S110_L002_R1_trimmed.fq.gz 11.6406
MP_JPosCon_SCmiFish_S111_L002_R1_trimmed.fq.gz 95.8301
MP_ASedge1_SCmiFish_S112_L002_R1_trimmed.fq.gz 74.6728
MP_ASedge2_SCmiFish_S113_L002_R1_trimmed.fq.gz 93.465
MP_ASedge3_SCmiFish_S114_L002_R1_trimmed.fq.gz 86.3332
MP_ASedge4_SCmiFish_S115_L002_R1_trimmed.fq.gz 94.4644
MP_ASedge5_SCmiFish_S116_L002_R1_trimmed.fq.gz 92.9757
MP_ASedge6_SCmiFish_S117_L002_R1_trimmed.fq.gz 97.2698
MP_ASedge7_SCmiFish_S118_L002_R1_trimmed.fq.gz 97.5658
MP_ASedge8_SCmiFish_S119_L002_R1_trimmed.fq.gz 95.7803
MP_ASedge9_SCmiFish_S120_L002_R1_trimmed.fq.gz 97.0265
MP_ASedge10_SCmiFish_S121_L002_R1_trimmed.fq.gz 95.4799
MP_ACanal1_SCmiFish_S122_L002_R1_trimmed.fq.gz 78.3698
MP_ACanal2_SCmiFish_S123_L002_R1_trimmed.fq.gz 84.8463
MP_ACanal3_SCmiFish_S124_L002_R1_trimmed.fq.gz 73.1868
MP_ACanal4_SCmiFish_S125_L002_R1_trimmed.fq.gz 80.3322
MP_ACanal5_SCmiFish_S126_L002_R1_trimmed.fq.gz 95.6167
MP_ACanal6_SCmiFish_S127_L002_R1_trimmed.fq.gz 75.2779
MP_ACanal7_SCmiFish_S128_L002_R1_trimmed.fq.gz 81.3099
MP_ACanal8_SCmiFish_S129_L002_R1_trimmed.fq.gz 65.6391
MP_Ablank_SCmiFish_S130_L002_R1_trimmed.fq.gz 1.82174
MP_APosCon_SCmiFish_S131_L002_R1_trimmed.fq.gz 97.6882
MP_SSedge1_SCmiFish_S132_L002_R1_trimmed.fq.gz 90.3139
MP_SSedge2_SCmiFish_S133_L002_R1_trimmed.fq.gz 89.9913
MP_SSedge3_SCmiFish_S134_L002_R1_trimmed.fq.gz 97.9103
MP_SSedge4_SCmiFish_S135_L002_R1_trimmed.fq.gz 97.1558
MP_SSedge5_SCmiFish_S136_L002_R1_trimmed.fq.gz 94.5201
MP_SSedge6_SCmiFish_S137_L002_R1_trimmed.fq.gz 97.38
MP_SSedge7_SCmiFish_S138_L002_R1_trimmed.fq.gz 77.3907
MP_SSedge8_SCmiFish_S139_L002_R1_trimmed.fq.gz 97.1412
MP_SSedge9_SCmiFish_S140_L002_R1_trimmed.fq.gz 74.9136
MP_SSedge10_SCmiFish_S141_L002_R1_trimmed.fq.gz 90.4953
MP_SCanal1_SCmiFish_S142_L002_R1_trimmed.fq.gz 96.3548
MP_SCanal2_SCmiFish_S143_L002_R1_trimmed.fq.gz 97.0031
MP_SCanal3_SCmiFish_S144_L002_R1_trimmed.fq.gz 95.7524
MP_SCanal4_SCmiFish_S145_L002_R1_trimmed.fq.gz 94.7309
MP_SCanal5_SCmiFish_S146_L002_R1_trimmed.fq.gz 95.9106
MP_SCanal6_SCmiFish_S147_L002_R1_trimmed.fq.gz 97.5418
MP_SCanal7_SCmiFish_S148_L002_R1_trimmed.fq.gz 96.7193
MP_SCanal8_SCmiFish_S149_L002_R1_trimmed.fq.gz 84.9719
MP_Sblank_SCmiFish_S150_L002_R1_trimmed.fq.gz 6.25857
MP_SPosCon_SCmiFish_S151_L002_R1_trimmed.fq.gz 97.1665

```

```
FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_T1S1_SCmiFish_S2_L002 88.8
MP_T1S2_SCmiFish_S3_L002 82.4
MP_T1S3_SCmiFish_S4_L002 88.4
MP_T1S4_SCmiFish_S5_L002 86.8
MP_T1S5_SCmiFish_S6_L002 88
MP_T1S6_SCmiFish_S7_L002 44.2
MP_T1S7_SCmiFish_S8_L002 73.4
MP_T1S8_SCmiFish_S9_L002 89.2
MP_T1S9_SCmiFish_S10_L002 86.6
MP_T1S10_SCmiFish_S11_L002 84.7
MP_T1S11_SCmiFish_S12_L002 81.9
MP_T1CTiana_SCmiFish_S13_L002 57.7
MP_T1CW_SCmiFish_S14_L002 82.6
MP_T1Blank_SCmiFish_S15_L002 42.3
MP_T1PosCon_SCmiFish_S16_L002 79
MP_T3S1_SCmiFish_S17_L002 56.4
MP_T3S2_SCmiFish_S18_L002 79.6
MP_T3S3_SCmiFish_S19_L002 78.5
MP_T3S4_SCmiFish_S20_L002 0.3
MP_T3S5_SCmiFish_S21_L002 46.1
MP_T3S6_SCmiFish_S22_L002 52.1
MP_T3S7_SCmiFish_S23_L002 72.2
MP_T3S8_SCmiFish_S24_L002 57.7
MP_T3S9_SCmiFish_S25_L002 0.2
MP_T3S10_SCmiFish_S26_L002 63.9
MP_T3S11_SCmiFish_S27_L002 65.1
MP_T3TC_SCmiFish_S28_L002 43.2
MP_T3WC_SCmiFish_S29_L002 61.4
MP_T3Blank_SCmiFish_S30_L002 0.1
MP_T3PosCon_SCmiFish_S31_L002 51.6
MP_T5S1_SCmiFish_S32_L002 54.9
MP_T5S2_SCmiFish_S33_L002 71.2
MP_T5S3_SCmiFish_S34_L002 60.8
MP_T5S4_SCmiFish_S35_L002 77.2
MP_T5S5_SCmiFish_S36_L002 72.8
MP_T5S6_SCmiFish_S37_L002 35.1
MP_T5S7_SCmiFish_S38_L002 65.6
MP_T5S8_SCmiFish_S39_L002 74.3
MP_T5S9_SCmiFish_S40_L002 72.8
MP_T5S10_SCmiFish_S41_L002 51.2
MP_T5S11_SCmiFish_S42_L002 62.6
MP_T5Tiana_SCmiFish_S43_L002 24.3
MP_T5Wessuck_SCmiFish_S44_L002 70.6
MP_T5Blank_SCmiFish_S45_L002 1
MP_T5PosCon_SCmiFish_S46_L002 64.9
MP_T7S1_SCmiFish_S47_L002 74.8
MP_T7S2_SCmiFish_S48_L002 78.6
MP_T7S3_SCmiFish_S49_L002 82.1
MP_T7S4_SCmiFish_S50_L002 11.3
MP_T7S5_SCmiFish_S51_L002 73.8
MP_T7S6_SCmiFish_S52_L002 86.2
MP_T7S7_SCmiFish_S53_L002 79.7
MP_T7S8_SCmiFish_S54_L002 51.3
MP_T7S9_SCmiFish_S55_L002 66
MP_T7S10_SCmiFish_S56_L002 62.9
MP_T7S11_SCmiFish_S57_L002 68.6
MP_T7Tiana_SCmiFish_S58_L002 56.6
MP_T7Wessuck_SCmiFish_S59_L002 85.7
MP_T7Blank_SCmiFish_S60_L002 17.8
MP_T7PosCon_SCmiFish_S61_L002 60.1
MP_T9S1_SCmiFish_S62_L002 71.1
MP_T9S2_SCmiFish_S63_L002 49.6
MP_T9S3_SCmiFish_S64_L002 72.3
MP_T9S4_SCmiFish_S65_L002 60.8
MP_T9S5_SCmiFish_S66_L002 65.1
MP_T9S6_SCmiFish_S67_L002 74.8
MP_T9S7_SCmiFish_S68_L002 75.7
MP_T9S8_SCmiFish_S69_L002 80.3
MP_T9S9_SCmiFish_S70_L002 57.3
MP_T9S10_SCmiFish_S71_L002 70
MP_T9S11_SCmiFish_S72_L002 82.8
MP_T9Tiana_SCmiFish_S73_L002 87
MP_T9Wessuck_SCmiFish_S74_L002 68.8
MP_T9Blank_SCmiFish_S75_L002 61.5
MP_T9PosCon_SCmiFish_S76_L002 84.2
MP_T10S1_SCmiFish_S77_L002 80.7
MP_T10S2_SCmiFish_S78_L002 58.5
MP_T10S3_SCmiFish_S79_L002 68.2
MP_T10S4_SCmiFish_S80_L002 47.7
MP_T10S5_SCmiFish_S81_L002 28.9
MP_T10S6_SCmiFish_S82_L002 52
MP_T10S7_SCmiFish_S83_L002 45
MP_T10S8_SCmiFish_S84_L002 63.8
MP_T10S9_SCmiFish_S85_L002 41.6
MP_T10S10_SCmiFish_S86_L002 50.9
MP_T10S11_SCmiFish_S87_L002 74.1
MP_T10Tiana_SCmiFish_S88_L002 45.2
MP_T10Wessuck_SCmiFish_S89_L002 75.2
MP_T10Blank_SCmiFish_S90_L002 0
MP_T10PosCon_SCmiFish_S91_L002 68.4
MP_JSedge1_SCmiFish_S92_L002 53.7
MP_JSedge2_SCmiFish_S93_L002 60.1
MP_JSedge3_SCmiFish_S94_L002 71.5
MP_JSedge4_SCmiFish_S95_L002 66
MP_JSedge5_SCmiFish_S96_L002 26.4
MP_JSedge6_SCmiFish_S97_L002 67.4
MP_JSedge7_SCmiFish_S98_L002 82.3
MP_JSedge8_SCmiFish_S99_L002 74.5
MP_JSedge9_SCmiFish_S100_L002 78.1
MP_JSedge10_SCmiFish_S101_L002 67
MP_JCanal1_SCmiFish_S102_L002 68.2
MP_JCanal2_SCmiFish_S103_L002 59.3
MP_JCanal3_SCmiFish_S104_L002 72.8
MP_JCanal4_SCmiFish_S105_L002 70.7
MP_JCanal5_SCmiFish_S106_L002 58.9
MP_JCanal6_SCmiFish_S107_L002 77
MP_JCanal7_SCmiFish_S108_L002 64.6
MP_JCanal8_SCmiFish_S109_L002 41.6
MP_Jblank_SCmiFish_S110_L002 11.6
MP_JPosCon_SCmiFish_S111_L002 83.9
MP_ASedge1_SCmiFish_S112_L002 60.8
MP_ASedge2_SCmiFish_S113_L002 78.7
MP_ASedge3_SCmiFish_S114_L002 68.7
MP_ASedge4_SCmiFish_S115_L002 74.9
MP_ASedge5_SCmiFish_S116_L002 70.2
MP_ASedge6_SCmiFish_S117_L002 76.5
MP_ASedge7_SCmiFish_S118_L002 85.3
MP_ASedge8_SCmiFish_S119_L002 80.7
MP_ASedge9_SCmiFish_S120_L002 76.6
MP_ASedge10_SCmiFish_S121_L002 72.8
MP_ACanal1_SCmiFish_S122_L002 55
MP_ACanal2_SCmiFish_S123_L002 51.9
MP_ACanal3_SCmiFish_S124_L002 47.1
MP_ACanal4_SCmiFish_S125_L002 61.2
MP_ACanal5_SCmiFish_S126_L002 67.2
MP_ACanal6_SCmiFish_S127_L002 52
MP_ACanal7_SCmiFish_S128_L002 51.4
MP_ACanal8_SCmiFish_S129_L002 39.3
MP_Ablank_SCmiFish_S130_L002 1.5
MP_APosCon_SCmiFish_S131_L002 87
MP_SSedge1_SCmiFish_S132_L002 79.8
MP_SSedge2_SCmiFish_S133_L002 74.1
MP_SSedge3_SCmiFish_S134_L002 41
MP_SSedge4_SCmiFish_S135_L002 46.9
MP_SSedge5_SCmiFish_S136_L002 79.5
MP_SSedge6_SCmiFish_S137_L002 84.2
MP_SSedge7_SCmiFish_S138_L002 63.5
MP_SSedge8_SCmiFish_S139_L002 82.7
MP_SSedge9_SCmiFish_S140_L002 64
MP_SSedge10_SCmiFish_S141_L002 75.5
MP_SCanal1_SCmiFish_S142_L002 76.5
MP_SCanal2_SCmiFish_S143_L002 52.1
MP_SCanal3_SCmiFish_S144_L002 70.3
MP_SCanal4_SCmiFish_S145_L002 74
MP_SCanal5_SCmiFish_S146_L002 64.2
MP_SCanal6_SCmiFish_S147_L002 40.2
MP_SCanal7_SCmiFish_S148_L002 74.1
MP_SCanal8_SCmiFish_S149_L002 73.2
MP_Sblank_SCmiFish_S150_L002 5.7
MP_SPosCon_SCmiFish_S151_L002 0
```

Some of the controls failed to merge. Also this is a relatively low number- not sure what happened with the quality here compared to other years.

Finished blast, figures, etc on morning on 1/16.  Start 2022...


### 2022 MiFish
1/16/25

Remove suffix from fastq files: 
`for file in *; do mv "${file}" "${file/_001/}"; done`

*If needed* remove prefix from file names (if re-running after mistake): `for file in * ; do mv -v "$file" "${file#*_}"; done`

Run REVAMP

```
conda activate REVAMPenv

revamp.sh -p 01_config_file_MiFish-2022.txt -f 02_figure_config_file_MiFish-2022.txt -s 03_sample_metadata_MiFish-2022.txt -r raw_data/2022-MiFish-U -o results-revamp-2022-MiFish
```

~Pasting output~

```
Running Cutadapt: Thu Jan 16 08:53:53 EST 2025
Finished Cutadapt: Thu Jan 16 09:21:54 EST 2025
Sample	Passing Reads	Passing bp
MP_T1S1_S1_L002	99.3%	76.5%
MP_T1S2_S1_L002	99.3%	76.6%
MP_T1S3_S1_L002	99.2%	76.5%
MP_T1S4_S1_L002	99.3%	76.5%
MP_T1S5_S1_L002	99.4%	76.8%
MP_T1S6_S1_L002	99.2%	76.6%
MP_T1S7_S1_L002	99.3%	76.4%
MP_T1S8_S1_L002	99.2%	76.6%
MP_T1S9_S1_L002	99.2%	76.6%
MP_T1S10_S1_L002	99.2%	76.7%
MP_T1S11_S1_L002	99.3%	81.4%
MP_T1Tiana_S1_L002	99.2%	76.9%
MP_T1Wessuck_S1_L002	99.0%	84.1%
MP_T1Blank_S1_L002	98.8%	76.3%
MP_T1PosCon_S1_L002	99.2%	77.3%
MP_T3S1_S1_L002	98.2%	82.1%
MP_T3S2_S1_L002	99.1%	84.2%
MP_T3S3_S1_L002	99.1%	77.7%
MP_T3S4_S1_L002	98.9%	76.4%
MP_T3S5_S1_L002	99.3%	76.7%
MP_T3S6_S1_L002	99.0%	84.9%
MP_T3S7_S1_L002	99.2%	76.7%
MP_T3S8_S1_L002	99.3%	76.6%
MP_T3S9_S1_L002	99.0%	85.5%
MP_T3S10_S1_L002	99.2%	78.7%
MP_T3S11_S1_L002	99.2%	76.5%
MP_T3Tiana_S1_L002	99.2%	76.5%
MP_T3Wessuck_S1_L002	98.8%	86.9%
MP_T3Blank_S1_L002	98.7%	89.1%
MP_T3PosCon_S1_L002	99.1%	81.9%
MP_T5S1_S1_L002	99.1%	77.2%
MP_T5S2_S1_L002	99.2%	77.6%
MP_T5S3_S1_L002	99.3%	76.9%
MP_T5S4_S1_L002	99.2%	78.8%
MP_T5S5_S1_L002	99.1%	76.7%
MP_T5S6_S2_L002	99.1%	77.0%
MP_T5S7_S2_L002	99.1%	76.9%
MP_T5S8_S2_L002	99.1%	78.6%
MP_T5S9_S2_L002	99.1%	76.4%
MP_T5S10_S2_L002	99.1%	76.5%
MP_T5S11_S2_L002	99.3%	76.6%
MP_T5Tiana_S2_L002	99.2%	80.6%
MP_T5Wessuck_S2_L002	99.0%	85.2%
MP_T5Blank_S2_L002	99.3%	87.6%
MP_T5PosCon_S2_L002	99.0%	84.4%
MP_JSedge1_S2_L002	99.0%	79.2%
MP_JSedge2_S2_L002	99.1%	77.3%
MP_JSedge3_S2_L002	99.1%	76.5%
MP_JSedge4_S2_L002	99.1%	76.8%
MP_JSedge5_S2_L002	99.2%	77.0%
MP_JSedge6_S2_L002	98.9%	84.3%
MP_JSedge7_S2_L002	99.3%	76.5%
MP_JSedge8_S2_L002	99.3%	76.5%
MP_JSedge9_S2_L002	99.2%	76.5%
MP_JSedge10_S2_L002	99.3%	76.6%
MP_JCanal1_S2_L002	99.3%	76.4%
MP_JCanal2_S2_L002	99.2%	76.4%
MP_JCanal3_S2_L002	99.2%	76.6%
MP_JCanal4_S2_L002	99.2%	76.5%
MP_JCanal5_S2_L002	99.2%	76.4%
MP_JCanal6_S2_L002	99.2%	76.6%
MP_JCanal7_S2_L002	99.3%	76.5%
MP_JCanal8_S2_L002	99.1%	76.5%
MP_JBlank_S2_L002	98.8%	89.2%
MP_JPosCon_S2_L002	99.0%	77.6%
MP_ASedge1_S2_L002	99.2%	78.3%
MP_ASedge2_S2_L002	98.2%	81.4%
MP_ASedge3_S2_L002	99.3%	77.9%
MP_ASedge4_S2_L002	98.7%	80.5%
MP_ASedge5_S2_L002	99.0%	77.2%
MP_ASedge6_S3_L002	99.4%	77.0%
MP_ASedge7_S3_L002	98.8%	84.5%
MP_ASedge8_S3_L002	99.3%	76.7%
MP_ASedge9_S3_L002	99.2%	76.7%
MP_ASedge10_S3_L002	99.1%	85.7%
MP_ACanal1_S3_L002	99.2%	76.7%
MP_ACanal2_S3_L002	99.3%	76.7%
MP_ACanal3_S3_L002	98.9%	76.6%
MP_ACanal4_S3_L002	98.8%	87.1%
MP_ACanal5_S3_L002	98.8%	86.4%
MP_ACanal6_S3_L002	99.1%	78.8%
MP_ACanal7_S3_L002	99.1%	76.6%
MP_ACanal8_S3_L002	99.2%	76.7%
MP_ABlank_S3_L002	99.3%	76.7%
MP_APosCon_S3_L002	99.2%	76.4%
MP_OSedge1_S3_L002	99.1%	78.4%
MP_OSedge2_S3_L002	99.2%	77.2%
MP_OSedge3_S3_L002	99.2%	76.7%
MP_OSedge4_S3_L002	99.3%	76.7%
MP_OSedge5_S3_L002	99.2%	76.8%
MP_OSedge6_S3_L002	99.2%	76.5%
MP_OSedge7_S3_L002	99.3%	76.6%
MP_OSedge8_S3_L002	99.2%	76.7%
MP_OSedge9_S3_L002	99.1%	76.7%
MP_OSedge10_S3_L002	99.3%	81.1%
MP_OCanal1_S3_L002	99.1%	82.9%
MP_OCanal2_S3_L002	99.0%	84.4%
MP_OCanal3_S3_L002	99.1%	80.0%
MP_OCanal4_S3_L002	99.2%	76.7%
MP_OCanal5_S3_L002	99.2%	76.6%
MP_OCanal6_S3_L002	99.2%	79.9%
MP_OCanal7_S3_L002	99.0%	85.6%
MP_OCanal8_S3_L002	99.3%	77.0%
MP_OBlank_S3_L002	99.3%	76.5%
MP_OPosCon_S3_L002	99.2%	76.4%
```


```
Running DADA2: Thu Jan 16 09:23:30 EST 2025
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_T1S1_S1_L002_R1_trimmed.fq.gz 95.5671
MP_T1S2_S1_L002_R1_trimmed.fq.gz 95.8112
MP_T1S3_S1_L002_R1_trimmed.fq.gz 95.1466
MP_T1S4_S1_L002_R1_trimmed.fq.gz 95.5066
MP_T1S5_S1_L002_R1_trimmed.fq.gz 94.9663
MP_T1S6_S1_L002_R1_trimmed.fq.gz 95.4935
MP_T1S7_S1_L002_R1_trimmed.fq.gz 95.4629
MP_T1S8_S1_L002_R1_trimmed.fq.gz 95.1516
MP_T1S9_S1_L002_R1_trimmed.fq.gz 95.2038
MP_T1S10_S1_L002_R1_trimmed.fq.gz 95.8484
MP_T1S11_S1_L002_R1_trimmed.fq.gz 94.4359
MP_T1Tiana_S1_L002_R1_trimmed.fq.gz 95.3668
MP_T1Wessuck_S1_L002_R1_trimmed.fq.gz 93.8949
MP_T1Blank_S1_L002_R1_trimmed.fq.gz 94.2946
MP_T1PosCon_S1_L002_R1_trimmed.fq.gz 95.335
MP_T3S1_S1_L002_R1_trimmed.fq.gz 94.9347
MP_T3S2_S1_L002_R1_trimmed.fq.gz 94.5204
MP_T3S3_S1_L002_R1_trimmed.fq.gz 95.5019
MP_T3S4_S1_L002_R1_trimmed.fq.gz 95.1486
MP_T3S5_S1_L002_R1_trimmed.fq.gz 95.8559
MP_T3S6_S1_L002_R1_trimmed.fq.gz 93.5246
MP_T3S7_S1_L002_R1_trimmed.fq.gz 94.6912
MP_T3S8_S1_L002_R1_trimmed.fq.gz 95.7906
MP_T3S9_S1_L002_R1_trimmed.fq.gz 94.1828
MP_T3S10_S1_L002_R1_trimmed.fq.gz 95.3743
MP_T3S11_S1_L002_R1_trimmed.fq.gz 95.5627
MP_T3Tiana_S1_L002_R1_trimmed.fq.gz 95.733
MP_T3Wessuck_S1_L002_R1_trimmed.fq.gz 93.2999
MP_T3Blank_S1_L002_R1_trimmed.fq.gz 93.017
MP_T3PosCon_S1_L002_R1_trimmed.fq.gz 94.4357
MP_T5S1_S1_L002_R1_trimmed.fq.gz 95.3293
MP_T5S2_S1_L002_R1_trimmed.fq.gz 95.6406
MP_T5S3_S1_L002_R1_trimmed.fq.gz 95.3351
MP_T5S4_S1_L002_R1_trimmed.fq.gz 95.3099
MP_T5S5_S1_L002_R1_trimmed.fq.gz 94.7868
MP_T5S6_S2_L002_R1_trimmed.fq.gz 95.9622
MP_T5S7_S2_L002_R1_trimmed.fq.gz 94.7347
MP_T5S8_S2_L002_R1_trimmed.fq.gz 95.4269
MP_T5S9_S2_L002_R1_trimmed.fq.gz 95.4253
MP_T5S10_S2_L002_R1_trimmed.fq.gz 94.9797
MP_T5S11_S2_L002_R1_trimmed.fq.gz 96.0023
MP_T5Tiana_S2_L002_R1_trimmed.fq.gz 95.2405
MP_T5Wessuck_S2_L002_R1_trimmed.fq.gz 94.1371
MP_T5Blank_S2_L002_R1_trimmed.fq.gz 95.5076
MP_T5PosCon_S2_L002_R1_trimmed.fq.gz 94.69
MP_JSedge1_S2_L002_R1_trimmed.fq.gz 93.717
MP_JSedge2_S2_L002_R1_trimmed.fq.gz 95.0827
MP_JSedge3_S2_L002_R1_trimmed.fq.gz 95.7996
MP_JSedge4_S2_L002_R1_trimmed.fq.gz 95.6578
MP_JSedge5_S2_L002_R1_trimmed.fq.gz 95.4225
MP_JSedge6_S2_L002_R1_trimmed.fq.gz 94.4062
MP_JSedge7_S2_L002_R1_trimmed.fq.gz 95.8379
MP_JSedge8_S2_L002_R1_trimmed.fq.gz 95.677
MP_JSedge9_S2_L002_R1_trimmed.fq.gz 95.1243
MP_JSedge10_S2_L002_R1_trimmed.fq.gz 95.5617
MP_JCanal1_S2_L002_R1_trimmed.fq.gz 95.4929
MP_JCanal2_S2_L002_R1_trimmed.fq.gz 95.3524
MP_JCanal3_S2_L002_R1_trimmed.fq.gz 94.8775
MP_JCanal4_S2_L002_R1_trimmed.fq.gz 95.0288
MP_JCanal5_S2_L002_R1_trimmed.fq.gz 95.1585
MP_JCanal6_S2_L002_R1_trimmed.fq.gz 95.5764
MP_JCanal7_S2_L002_R1_trimmed.fq.gz 94.7775
MP_JCanal8_S2_L002_R1_trimmed.fq.gz 95.5419
MP_JBlank_S2_L002_R1_trimmed.fq.gz 92.9287
MP_JPosCon_S2_L002_R1_trimmed.fq.gz 94.4203
MP_ASedge1_S2_L002_R1_trimmed.fq.gz 95.5118
MP_ASedge2_S2_L002_R1_trimmed.fq.gz 94.803
MP_ASedge3_S2_L002_R1_trimmed.fq.gz 95.3213
MP_ASedge4_S2_L002_R1_trimmed.fq.gz 94.833
MP_ASedge5_S2_L002_R1_trimmed.fq.gz 94.7399
MP_ASedge6_S3_L002_R1_trimmed.fq.gz 95.3584
MP_ASedge7_S3_L002_R1_trimmed.fq.gz 93.2398
MP_ASedge8_S3_L002_R1_trimmed.fq.gz 95.5482
MP_ASedge9_S3_L002_R1_trimmed.fq.gz 95.2804
MP_ASedge10_S3_L002_R1_trimmed.fq.gz 94.1047
MP_ACanal1_S3_L002_R1_trimmed.fq.gz 95.6464
MP_ACanal2_S3_L002_R1_trimmed.fq.gz 94.9742
MP_ACanal3_S3_L002_R1_trimmed.fq.gz 95.5846
MP_ACanal4_S3_L002_R1_trimmed.fq.gz 93.285
MP_ACanal5_S3_L002_R1_trimmed.fq.gz 93.3198
MP_ACanal6_S3_L002_R1_trimmed.fq.gz 95.2078
MP_ACanal7_S3_L002_R1_trimmed.fq.gz 95.4344
MP_ACanal8_S3_L002_R1_trimmed.fq.gz 95.4709
MP_ABlank_S3_L002_R1_trimmed.fq.gz 95.1952
MP_APosCon_S3_L002_R1_trimmed.fq.gz 95.4005
MP_OSedge1_S3_L002_R1_trimmed.fq.gz 94.4453
MP_OSedge2_S3_L002_R1_trimmed.fq.gz 95.6405
MP_OSedge3_S3_L002_R1_trimmed.fq.gz 93.9056
MP_OSedge4_S3_L002_R1_trimmed.fq.gz 95.4704
MP_OSedge5_S3_L002_R1_trimmed.fq.gz 95.2922
MP_OSedge6_S3_L002_R1_trimmed.fq.gz 95.2632
MP_OSedge7_S3_L002_R1_trimmed.fq.gz 96.0149
MP_OSedge8_S3_L002_R1_trimmed.fq.gz 95.5119
MP_OSedge9_S3_L002_R1_trimmed.fq.gz 95.1833
MP_OSedge10_S3_L002_R1_trimmed.fq.gz 95.2598
MP_OCanal1_S3_L002_R1_trimmed.fq.gz 94.617
MP_OCanal2_S3_L002_R1_trimmed.fq.gz 92.844
MP_OCanal3_S3_L002_R1_trimmed.fq.gz 94.5612
MP_OCanal4_S3_L002_R1_trimmed.fq.gz 95.2645
MP_OCanal5_S3_L002_R1_trimmed.fq.gz 95.7472
MP_OCanal6_S3_L002_R1_trimmed.fq.gz 94.8708
MP_OCanal7_S3_L002_R1_trimmed.fq.gz 94.1261
MP_OCanal8_S3_L002_R1_trimmed.fq.gz 95.542
MP_OBlank_S3_L002_R1_trimmed.fq.gz 94.0629
MP_OPosCon_S3_L002_R1_trimmed.fq.gz 95.2757
```


#### 1/17/25

Getting memory issue. From dada2 log:  

```
Loading required package: Rcpp
Warning message:
package ‘Rcpp’ was built under R version 4.4.1 
Read 105 items
Warning message:
Removed 10565 rows containing missing values or values outside the scale range
(`geom_tile()`). 
null device 
          1 
Warning message:
Removed 14310 rows containing missing values or values outside the scale range
(`geom_tile()`). 
null device 
          1 
null device 
          1 
null device 
          1 
Loading required package: Rcpp
Warning message:
package ‘Rcpp’ was built under R version 4.4.1 
Read 105 items
DADA2 - Learning error Running
3191607369 total bases in 20641697 reads from 59 samples will be used for learning the error rates.
3157049030 total bases in 20351271 reads from 58 samples will be used for learning the error rates.
Warning messages:
1: In scale_y_log10() : log-10 transformation introduced infinite values.
2: In scale_y_log10() : log-10 transformation introduced infinite values.
null device 
          1 
Warning messages:
1: In scale_y_log10() : log-10 transformation introduced infinite values.
2: In scale_y_log10() : log-10 transformation introduced infinite values.
null device 
          1 
DADA2 - Dereplication Running
Dereplicating sequence entries in Fastq file: MP_T1S1_S1_L002_R1_filtered.fq.gz
Encountered 58216 unique sequences from 396208 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S2_S1_L002_R1_filtered.fq.gz
Encountered 45419 unique sequences from 313595 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S3_S1_L002_R1_filtered.fq.gz
Encountered 33713 unique sequences from 202452 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S4_S1_L002_R1_filtered.fq.gz
Encountered 41717 unique sequences from 319482 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S5_S1_L002_R1_filtered.fq.gz
Encountered 56841 unique sequences from 408056 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S6_S1_L002_R1_filtered.fq.gz
Encountered 44179 unique sequences from 316537 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S7_S1_L002_R1_filtered.fq.gz
Encountered 53161 unique sequences from 371663 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S8_S1_L002_R1_filtered.fq.gz
Encountered 44603 unique sequences from 304901 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S9_S1_L002_R1_filtered.fq.gz
Encountered 51561 unique sequences from 369324 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S10_S1_L002_R1_filtered.fq.gz
Encountered 25791 unique sequences from 162488 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S11_S1_L002_R1_filtered.fq.gz
Encountered 58288 unique sequences from 386156 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1Tiana_S1_L002_R1_filtered.fq.gz
Encountered 53403 unique sequences from 416549 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1Wessuck_S1_L002_R1_filtered.fq.gz
Encountered 113073 unique sequences from 448058 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1Blank_S1_L002_R1_filtered.fq.gz
Encountered 15966 unique sequences from 86719 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1PosCon_S1_L002_R1_filtered.fq.gz
Encountered 46786 unique sequences from 371676 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S1_S1_L002_R1_filtered.fq.gz
Encountered 40034 unique sequences from 206915 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S2_S1_L002_R1_filtered.fq.gz
Encountered 118956 unique sequences from 473105 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S3_S1_L002_R1_filtered.fq.gz
Encountered 57414 unique sequences from 369427 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S4_S1_L002_R1_filtered.fq.gz
Encountered 41617 unique sequences from 274988 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S5_S1_L002_R1_filtered.fq.gz
Encountered 64864 unique sequences from 469555 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S6_S1_L002_R1_filtered.fq.gz
Encountered 82203 unique sequences from 298106 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S7_S1_L002_R1_filtered.fq.gz
Encountered 71636 unique sequences from 501728 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S8_S1_L002_R1_filtered.fq.gz
Encountered 54747 unique sequences from 398416 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S9_S1_L002_R1_filtered.fq.gz
Encountered 84381 unique sequences from 321964 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S10_S1_L002_R1_filtered.fq.gz
Encountered 43238 unique sequences from 268618 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S11_S1_L002_R1_filtered.fq.gz
Encountered 39574 unique sequences from 311518 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3Tiana_S1_L002_R1_filtered.fq.gz
Encountered 17297 unique sequences from 114535 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3Wessuck_S1_L002_R1_filtered.fq.gz
Encountered 130290 unique sequences from 350763 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3Blank_S1_L002_R1_filtered.fq.gz
Encountered 67895 unique sequences from 146192 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3PosCon_S1_L002_R1_filtered.fq.gz
Encountered 63905 unique sequences from 383693 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S1_S1_L002_R1_filtered.fq.gz
Encountered 52965 unique sequences from 334560 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S2_S1_L002_R1_filtered.fq.gz
Encountered 55295 unique sequences from 343123 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S3_S1_L002_R1_filtered.fq.gz
Encountered 62777 unique sequences from 434440 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S4_S1_L002_R1_filtered.fq.gz
Encountered 70488 unique sequences from 438236 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S5_S1_L002_R1_filtered.fq.gz
Encountered 62439 unique sequences from 407608 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S6_S2_L002_R1_filtered.fq.gz
Encountered 32933 unique sequences from 221667 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S7_S2_L002_R1_filtered.fq.gz
Encountered 61168 unique sequences from 342354 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S8_S2_L002_R1_filtered.fq.gz
Encountered 44197 unique sequences from 263636 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S9_S2_L002_R1_filtered.fq.gz
Encountered 55724 unique sequences from 380785 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S10_S2_L002_R1_filtered.fq.gz
Encountered 46672 unique sequences from 285772 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S11_S2_L002_R1_filtered.fq.gz
Encountered 29691 unique sequences from 222735 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5Tiana_S2_L002_R1_filtered.fq.gz
Encountered 65691 unique sequences from 370939 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5Wessuck_S2_L002_R1_filtered.fq.gz
Encountered 222755 unique sequences from 821829 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5Blank_S2_L002_R1_filtered.fq.gz
Encountered 37388 unique sequences from 175330 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5PosCon_S2_L002_R1_filtered.fq.gz
Encountered 203518 unique sequences from 887262 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JSedge1_S2_L002_R1_filtered.fq.gz
Encountered 55798 unique sequences from 283282 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JSedge2_S2_L002_R1_filtered.fq.gz
Encountered 49299 unique sequences from 357491 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JSedge3_S2_L002_R1_filtered.fq.gz
Encountered 57420 unique sequences from 411097 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JSedge4_S2_L002_R1_filtered.fq.gz
Encountered 40662 unique sequences from 268785 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JSedge5_S2_L002_R1_filtered.fq.gz
Encountered 46266 unique sequences from 326237 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JSedge6_S2_L002_R1_filtered.fq.gz
Encountered 200054 unique sequences from 845351 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JSedge7_S2_L002_R1_filtered.fq.gz
Encountered 43218 unique sequences from 356585 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JSedge8_S2_L002_R1_filtered.fq.gz
Encountered 44823 unique sequences from 331940 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JSedge9_S2_L002_R1_filtered.fq.gz
Encountered 28301 unique sequences from 183276 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JSedge10_S2_L002_R1_filtered.fq.gz
Encountered 44624 unique sequences from 329105 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JCanal1_S2_L002_R1_filtered.fq.gz
Encountered 51263 unique sequences from 359035 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JCanal2_S2_L002_R1_filtered.fq.gz
Encountered 37808 unique sequences from 263288 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JCanal3_S2_L002_R1_filtered.fq.gz
Encountered 47635 unique sequences from 342136 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JCanal4_S2_L002_R1_filtered.fq.gz
Encountered 42237 unique sequences from 290426 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JCanal5_S2_L002_R1_filtered.fq.gz
Encountered 57262 unique sequences from 408055 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JCanal6_S2_L002_R1_filtered.fq.gz
Encountered 37805 unique sequences from 235030 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JCanal7_S2_L002_R1_filtered.fq.gz
Encountered 46121 unique sequences from 297048 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JCanal8_S2_L002_R1_filtered.fq.gz
Encountered 48095 unique sequences from 355480 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JBlank_S2_L002_R1_filtered.fq.gz
Encountered 65057 unique sequences from 152851 total sequences read.
Dereplicating sequence entries in Fastq file: MP_JPosCon_S2_L002_R1_filtered.fq.gz
Encountered 56771 unique sequences from 385670 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ASedge1_S2_L002_R1_filtered.fq.gz
Encountered 39612 unique sequences from 275457 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ASedge2_S2_L002_R1_filtered.fq.gz
Encountered 95155 unique sequences from 509791 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ASedge3_S2_L002_R1_filtered.fq.gz
Encountered 46001 unique sequences from 323431 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ASedge4_S2_L002_R1_filtered.fq.gz
Encountered 60202 unique sequences from 390032 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ASedge5_S2_L002_R1_filtered.fq.gz
Encountered 45839 unique sequences from 293579 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ASedge6_S3_L002_R1_filtered.fq.gz
Encountered 115819 unique sequences from 869711 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ASedge7_S3_L002_R1_filtered.fq.gz
Encountered 74707 unique sequences from 258842 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ASedge8_S3_L002_R1_filtered.fq.gz
Encountered 56118 unique sequences from 382148 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ASedge9_S3_L002_R1_filtered.fq.gz
Encountered 57184 unique sequences from 380948 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ASedge10_S3_L002_R1_filtered.fq.gz
Encountered 77125 unique sequences from 283369 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ACanal1_S3_L002_R1_filtered.fq.gz
Encountered 27104 unique sequences from 161609 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ACanal2_S3_L002_R1_filtered.fq.gz
Encountered 36051 unique sequences from 262710 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ACanal3_S3_L002_R1_filtered.fq.gz
Encountered 23572 unique sequences from 132052 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ACanal4_S3_L002_R1_filtered.fq.gz
Encountered 178642 unique sequences from 488332 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ACanal5_S3_L002_R1_filtered.fq.gz
Encountered 138974 unique sequences from 439539 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ACanal6_S3_L002_R1_filtered.fq.gz
Encountered 77306 unique sequences from 454880 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ACanal7_S3_L002_R1_filtered.fq.gz
Encountered 62823 unique sequences from 393665 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ACanal8_S3_L002_R1_filtered.fq.gz
Encountered 56485 unique sequences from 361152 total sequences read.
Dereplicating sequence entries in Fastq file: MP_ABlank_S3_L002_R1_filtered.fq.gz
Encountered 29601 unique sequences from 146217 total sequences read.
Dereplicating sequence entries in Fastq file: MP_APosCon_S3_L002_R1_filtered.fq.gz
Encountered 55475 unique sequences from 481475 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OSedge1_S3_L002_R1_filtered.fq.gz
Encountered 68969 unique sequences from 440661 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OSedge2_S3_L002_R1_filtered.fq.gz
Encountered 68936 unique sequences from 427799 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OSedge3_S3_L002_R1_filtered.fq.gz
Encountered 68518 unique sequences from 383936 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OSedge4_S3_L002_R1_filtered.fq.gz
Encountered 58122 unique sequences from 394855 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OSedge5_S3_L002_R1_filtered.fq.gz
Encountered 58151 unique sequences from 388815 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OSedge6_S3_L002_R1_filtered.fq.gz
Encountered 47521 unique sequences from 329823 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OSedge7_S3_L002_R1_filtered.fq.gz
Encountered 31955 unique sequences from 225175 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OSedge8_S3_L002_R1_filtered.fq.gz
Encountered 35093 unique sequences from 210959 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OSedge9_S3_L002_R1_filtered.fq.gz
Encountered 38771 unique sequences from 253220 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OSedge10_S3_L002_R1_filtered.fq.gz
Encountered 35946 unique sequences from 184321 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OCanal1_S3_L002_R1_filtered.fq.gz
Encountered 82526 unique sequences from 296908 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OCanal2_S3_L002_R1_filtered.fq.gz
Encountered 100057 unique sequences from 365644 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OCanal3_S3_L002_R1_filtered.fq.gz
Encountered 66966 unique sequences from 379095 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OCanal4_S3_L002_R1_filtered.fq.gz
Encountered 71255 unique sequences from 474240 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OCanal5_S3_L002_R1_filtered.fq.gz
Encountered 30333 unique sequences from 172997 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OCanal6_S3_L002_R1_filtered.fq.gz
Encountered 85101 unique sequences from 496291 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OCanal7_S3_L002_R1_filtered.fq.gz
Encountered 151912 unique sequences from 507705 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OCanal8_S3_L002_R1_filtered.fq.gz
Encountered 67347 unique sequences from 419656 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OBlank_S3_L002_R1_filtered.fq.gz
Encountered 783 unique sequences from 2630 total sequences read.
Dereplicating sequence entries in Fastq file: MP_OPosCon_S3_L002_R1_filtered.fq.gz
Encountered 38586 unique sequences from 251608 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S1_S1_L002_R2_filtered.fq.gz
Encountered 58921 unique sequences from 396208 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S2_S1_L002_R2_filtered.fq.gz
Encountered 46338 unique sequences from 313595 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S3_S1_L002_R2_filtered.fq.gz
Encountered 33073 unique sequences from 202452 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S4_S1_L002_R2_filtered.fq.gz
Encountered 42844 unique sequences from 319482 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S5_S1_L002_R2_filtered.fq.gz
Encountered 63382 unique sequences from 408056 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S6_S1_L002_R2_filtered.fq.gz
Encountered 45266 unique sequences from 316537 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S7_S1_L002_R2_filtered.fq.gz
Encountered 54129 unique sequences from 371663 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S8_S1_L002_R2_filtered.fq.gz
Encountered 45028 unique sequences from 304901 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S9_S1_L002_R2_filtered.fq.gz
Encountered 51287 unique sequences from 369324 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S10_S1_L002_R2_filtered.fq.gz
Encountered 25545 unique sequences from 162488 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1S11_S1_L002_R2_filtered.fq.gz
Encountered 60244 unique sequences from 386156 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1Tiana_S1_L002_R2_filtered.fq.gz
Encountered 51882 unique sequences from 416549 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1Wessuck_S1_L002_R2_filtered.fq.gz
Encountered 117247 unique sequences from 448058 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1Blank_S1_L002_R2_filtered.fq.gz
Encountered 14710 unique sequences from 86719 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T1PosCon_S1_L002_R2_filtered.fq.gz
Encountered 48565 unique sequences from 371676 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S1_S1_L002_R2_filtered.fq.gz
Encountered 42217 unique sequences from 206915 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S2_S1_L002_R2_filtered.fq.gz
Encountered 125148 unique sequences from 473105 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S3_S1_L002_R2_filtered.fq.gz
Encountered 60998 unique sequences from 369427 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S4_S1_L002_R2_filtered.fq.gz
Encountered 42419 unique sequences from 274988 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S5_S1_L002_R2_filtered.fq.gz
Encountered 66081 unique sequences from 469555 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S6_S1_L002_R2_filtered.fq.gz
Encountered 84949 unique sequences from 298106 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S7_S1_L002_R2_filtered.fq.gz
Encountered 68899 unique sequences from 501728 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S8_S1_L002_R2_filtered.fq.gz
Encountered 53392 unique sequences from 398416 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S9_S1_L002_R2_filtered.fq.gz
Encountered 92861 unique sequences from 321964 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S10_S1_L002_R2_filtered.fq.gz
Encountered 45584 unique sequences from 268618 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3S11_S1_L002_R2_filtered.fq.gz
Encountered 40525 unique sequences from 311518 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3Tiana_S1_L002_R2_filtered.fq.gz
Encountered 17162 unique sequences from 114535 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3Wessuck_S1_L002_R2_filtered.fq.gz
Encountered 131049 unique sequences from 350763 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3Blank_S1_L002_R2_filtered.fq.gz
Encountered 69856 unique sequences from 146192 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T3PosCon_S1_L002_R2_filtered.fq.gz
Encountered 69229 unique sequences from 383693 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S1_S1_L002_R2_filtered.fq.gz
Encountered 53490 unique sequences from 334560 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S2_S1_L002_R2_filtered.fq.gz
Encountered 57129 unique sequences from 343123 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S3_S1_L002_R2_filtered.fq.gz
Encountered 64883 unique sequences from 434440 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S4_S1_L002_R2_filtered.fq.gz
Encountered 70944 unique sequences from 438236 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S5_S1_L002_R2_filtered.fq.gz
Encountered 59868 unique sequences from 407608 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S6_S2_L002_R2_filtered.fq.gz
Encountered 32353 unique sequences from 221667 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S7_S2_L002_R2_filtered.fq.gz
Encountered 56368 unique sequences from 342354 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S8_S2_L002_R2_filtered.fq.gz
Encountered 44764 unique sequences from 263636 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S9_S2_L002_R2_filtered.fq.gz
Encountered 54622 unique sequences from 380785 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S10_S2_L002_R2_filtered.fq.gz
Encountered 43836 unique sequences from 285772 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5S11_S2_L002_R2_filtered.fq.gz
Encountered 29671 unique sequences from 222735 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5Tiana_S2_L002_R2_filtered.fq.gz
Encountered 67771 unique sequences from 370939 total sequences read.
Dereplicating sequence entries in Fastq file: MP_T5Wessuck_S2_L002_R2_filtered.fq.gz
Error: vector memory limit of 16.0 Gb reached, see mem.maxVSize()
Execution halted
```


- Found [this thread](https://stackoverflow.com/questions/51248293/error-vector-memory-exhausted-limit-reached-r-3-5-0-macos)
	- actually i had already changed this parameter on my computer to 100Gb. Next found this thread- https://github.com/benjjneb/dada2/issues/1894
- Started to think about changing dada2 asset in REVAMP but maybe too complicated. 
- Instead try splitting sample libraries first into a and b. Based on [this](https://benjjneb.github.io/dada2/bigdata_1_2.html) there is a major quadratic increase in memory use with additional samples
	- Split cutadapt results and metadata files into two. Then run a and b seaprately:

##### 2022 MiFish a
```
conda activate REVAMPenv

revamp.sh -p 01_config_file_MiFish-2022a.txt -f 02_figure_config_file_MiFish-2022a.txt -s 03_sample_metadata_MiFish-2022a.txt -r raw_data/2022-MiFish-Ua -o results-revamp-2022-MiFisha

```

```

Running Cutadapt: Fri Jan 17 10:09:55 EST 2025
Finished Cutadapt: Fri Jan 17 10:20:05 EST 2025
Sample	Passing Reads	Passing bp
MP_ABlank_S3_L002	99.3%	76.7%
MP_ACanal1_S3_L002	99.2%	76.7%
MP_ACanal2_S3_L002	99.3%	76.7%
MP_ACanal3_S3_L002	98.9%	76.6%
MP_ACanal4_S3_L002	98.8%	87.1%
MP_ACanal5_S3_L002	98.8%	86.4%
MP_ACanal6_S3_L002	99.1%	78.8%
MP_ACanal7_S3_L002	99.1%	76.6%
MP_ACanal8_S3_L002	99.2%	76.7%
MP_APosCon_S3_L002	99.2%	76.4%
MP_ASedge1_S2_L002	99.2%	78.3%
MP_ASedge10_S3_L002	99.1%	85.7%
MP_ASedge2_S2_L002	98.2%	81.4%
MP_ASedge3_S2_L002	99.3%	77.9%
MP_ASedge4_S2_L002	98.7%	80.5%
MP_ASedge5_S2_L002	99.0%	77.2%
MP_ASedge6_S3_L002	99.4%	77.0%
MP_ASedge7_S3_L002	98.8%	84.5%
MP_ASedge8_S3_L002	99.3%	76.7%
MP_ASedge9_S3_L002	99.2%	76.7%
MP_JBlank_S2_L002	98.8%	89.2%
MP_JCanal1_S2_L002	99.3%	76.4%
MP_JCanal2_S2_L002	99.2%	76.4%
MP_JCanal3_S2_L002	99.2%	76.6%
MP_JCanal4_S2_L002	99.2%	76.5%
MP_JCanal5_S2_L002	99.2%	76.4%
MP_JCanal6_S2_L002	99.2%	76.6%
MP_JCanal7_S2_L002	99.3%	76.5%
MP_JCanal8_S2_L002	99.1%	76.5%
MP_JPosCon_S2_L002	99.0%	77.6%
MP_JSedge1_S2_L002	99.0%	79.2%
MP_JSedge10_S2_L002	99.3%	76.6%
MP_JSedge2_S2_L002	99.1%	77.3%
MP_JSedge3_S2_L002	99.1%	76.5%
MP_JSedge4_S2_L002	99.1%	76.8%
MP_JSedge5_S2_L002	99.2%	77.0%
MP_JSedge6_S2_L002	98.9%	84.3%
MP_JSedge7_S2_L002	99.3%	76.5%
MP_JSedge8_S2_L002	99.3%	76.5%
MP_JSedge9_S2_L002	99.2%	76.5%
MP_OBlank_S3_L002	99.3%	76.5%
MP_OCanal1_S3_L002	99.1%	82.9%
MP_OCanal2_S3_L002	99.0%	84.4%
MP_OCanal3_S3_L002	99.1%	80.0%
MP_OCanal4_S3_L002	99.2%	76.7%
MP_OCanal5_S3_L002	99.2%	76.6%
MP_OCanal6_S3_L002	99.2%	79.9%
MP_OCanal7_S3_L002	99.0%	85.6%
MP_OCanal8_S3_L002	99.3%	77.0%
MP_OPosCon_S3_L002	99.2%	76.4%
MP_OSedge1_S3_L002	99.1%	78.4%
MP_OSedge10_S3_L002	99.3%	81.1%
MP_OSedge2_S3_L002	99.2%	77.2%
```

```
DADA2 Filtering results:
Sample	% Reads Passing
MP_ABlank_S3_L002_R1_trimmed.fq.gz 95.1952
MP_ACanal1_S3_L002_R1_trimmed.fq.gz 95.6464
MP_ACanal2_S3_L002_R1_trimmed.fq.gz 94.9742
MP_ACanal3_S3_L002_R1_trimmed.fq.gz 95.5846
MP_ACanal4_S3_L002_R1_trimmed.fq.gz 93.285
MP_ACanal5_S3_L002_R1_trimmed.fq.gz 93.3198
MP_ACanal6_S3_L002_R1_trimmed.fq.gz 95.2078
MP_ACanal7_S3_L002_R1_trimmed.fq.gz 95.4344
MP_ACanal8_S3_L002_R1_trimmed.fq.gz 95.4709
MP_APosCon_S3_L002_R1_trimmed.fq.gz 95.4005
MP_ASedge1_S2_L002_R1_trimmed.fq.gz 95.5118
MP_ASedge10_S3_L002_R1_trimmed.fq.gz 94.1047
MP_ASedge2_S2_L002_R1_trimmed.fq.gz 94.803
MP_ASedge3_S2_L002_R1_trimmed.fq.gz 95.3213
MP_ASedge4_S2_L002_R1_trimmed.fq.gz 94.833
MP_ASedge5_S2_L002_R1_trimmed.fq.gz 94.7399
MP_ASedge6_S3_L002_R1_trimmed.fq.gz 95.3584
MP_ASedge7_S3_L002_R1_trimmed.fq.gz 93.2398
MP_ASedge8_S3_L002_R1_trimmed.fq.gz 95.5482
MP_ASedge9_S3_L002_R1_trimmed.fq.gz 95.2804
MP_JBlank_S2_L002_R1_trimmed.fq.gz 92.9287
MP_JCanal1_S2_L002_R1_trimmed.fq.gz 95.4929
MP_JCanal2_S2_L002_R1_trimmed.fq.gz 95.3524
MP_JCanal3_S2_L002_R1_trimmed.fq.gz 94.8775
MP_JCanal4_S2_L002_R1_trimmed.fq.gz 95.0288
MP_JCanal5_S2_L002_R1_trimmed.fq.gz 95.1585
MP_JCanal6_S2_L002_R1_trimmed.fq.gz 95.5764
MP_JCanal7_S2_L002_R1_trimmed.fq.gz 94.7775
MP_JCanal8_S2_L002_R1_trimmed.fq.gz 95.5419
MP_JPosCon_S2_L002_R1_trimmed.fq.gz 94.4203
MP_JSedge1_S2_L002_R1_trimmed.fq.gz 93.717
MP_JSedge10_S2_L002_R1_trimmed.fq.gz 95.5617
MP_JSedge2_S2_L002_R1_trimmed.fq.gz 95.0827
MP_JSedge3_S2_L002_R1_trimmed.fq.gz 95.7996
MP_JSedge4_S2_L002_R1_trimmed.fq.gz 95.6578
MP_JSedge5_S2_L002_R1_trimmed.fq.gz 95.4225
MP_JSedge6_S2_L002_R1_trimmed.fq.gz 94.4062
MP_JSedge7_S2_L002_R1_trimmed.fq.gz 95.8379
MP_JSedge8_S2_L002_R1_trimmed.fq.gz 95.677
MP_JSedge9_S2_L002_R1_trimmed.fq.gz 95.1243
MP_OBlank_S3_L002_R1_trimmed.fq.gz 94.0629
MP_OCanal1_S3_L002_R1_trimmed.fq.gz 94.617
MP_OCanal2_S3_L002_R1_trimmed.fq.gz 92.844
MP_OCanal3_S3_L002_R1_trimmed.fq.gz 94.5612
MP_OCanal4_S3_L002_R1_trimmed.fq.gz 95.2645
MP_OCanal5_S3_L002_R1_trimmed.fq.gz 95.7472
MP_OCanal6_S3_L002_R1_trimmed.fq.gz 94.8708
MP_OCanal7_S3_L002_R1_trimmed.fq.gz 94.1261
MP_OCanal8_S3_L002_R1_trimmed.fq.gz 95.542
MP_OPosCon_S3_L002_R1_trimmed.fq.gz 95.2757
MP_OSedge1_S3_L002_R1_trimmed.fq.gz 94.4453
MP_OSedge10_S3_L002_R1_trimmed.fq.gz 95.2598
MP_OSedge2_S3_L002_R1_trimmed.fq.gz 95.6405

```

```
FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_ABlank_S3_L002 85.1
MP_ACanal1_S3_L002 86
MP_ACanal2_S3_L002 84.8
MP_ACanal3_S3_L002 84.8
MP_ACanal4_S3_L002 60.8
MP_ACanal5_S3_L002 68.2
MP_ACanal6_S3_L002 84.3
MP_ACanal7_S3_L002 83.1
MP_ACanal8_S3_L002 76.2
MP_APosCon_S3_L002 80.4
MP_ASedge1_S2_L002 86.6
MP_ASedge10_S3_L002 72.2
MP_ASedge2_S2_L002 78
MP_ASedge3_S2_L002 76.2
MP_ASedge4_S2_L002 86.7
MP_ASedge5_S2_L002 81.2
MP_ASedge6_S3_L002 74.6
MP_ASedge7_S3_L002 74.6
MP_ASedge8_S3_L002 77.6
MP_ASedge9_S3_L002 85.1
MP_JBlank_S2_L002 64.6
MP_JCanal1_S2_L002 81.6
MP_JCanal2_S2_L002 84.9
MP_JCanal3_S2_L002 84.7
MP_JCanal4_S2_L002 84.9
MP_JCanal5_S2_L002 85.5
MP_JCanal6_S2_L002 86.1
MP_JCanal7_S2_L002 83.1
MP_JCanal8_S2_L002 85.3
MP_JPosCon_S2_L002 83.1
MP_JSedge1_S2_L002 79.1
MP_JSedge10_S2_L002 86
MP_JSedge2_S2_L002 84.7
MP_JSedge3_S2_L002 81.4
MP_JSedge4_S2_L002 83.9
MP_JSedge5_S2_L002 85.1
MP_JSedge6_S2_L002 72.9
MP_JSedge7_S2_L002 85.5
MP_JSedge8_S2_L002 84.9
MP_JSedge9_S2_L002 83.2
MP_OBlank_S3_L002 91.4
MP_OCanal1_S3_L002 67.1
MP_OCanal2_S3_L002 72.6
MP_OCanal3_S3_L002 82.3
MP_OCanal4_S3_L002 82.6
MP_OCanal5_S3_L002 79.7
MP_OCanal6_S3_L002 83.5
MP_OCanal7_S3_L002 68.5
MP_OCanal8_S3_L002 76.9
MP_OPosCon_S3_L002 85.8
MP_OSedge1_S3_L002 80.8
MP_OSedge10_S3_L002 83.2
MP_OSedge2_S3_L002 81.9

```

#### Jan 19 2025

Running from home. The above finished but I forgot my other external drive which has the blast database. So for now, get up to `dada2_Finished=TRUE
` in `progress.txt` for both data subsets, `a`, and `b` from 2022. Then run blast steps for both back at my office.

##### 2022 Mifish b
Remove suffix from fastq files: 
`for file in *; do mv "${file}" "${file/_001/}"; done`

*If needed* remove prefix from file names (if re-running after mistake): `for file in * ; do mv -v "$file" "${file#*_}"; done`

Run REVAMP'

```
conda activate REVAMPenv

revamp.sh -p 01_config_file_MiFish-2022b.txt -f 02_figure_config_file_MiFish-2022b.txt -s 03_sample_metadata_MiFish-2022b.txt -r raw_data/2022-MiFish-Ub -o results-revamp-2022-MiFishb

```


```

Running Cutadapt: Sun Jan 19 11:58:29 EST 2025
Finished Cutadapt: Sun Jan 19 12:07:27 EST 2025
Sample	Passing Reads	Passing bp
MP_OSedge3_S3_L002	99.2%	76.7%
MP_OSedge4_S3_L002	99.3%	76.7%
MP_OSedge5_S3_L002	99.2%	76.8%
MP_OSedge6_S3_L002	99.2%	76.5%
MP_OSedge7_S3_L002	99.3%	76.6%
MP_OSedge8_S3_L002	99.2%	76.7%
MP_OSedge9_S3_L002	99.1%	76.7%
MP_T1Blank_S1_L002	98.8%	76.3%
MP_T1PosCon_S1_L002	99.2%	77.3%
MP_T1S1_S1_L002	99.3%	76.5%
MP_T1S10_S1_L002	99.2%	76.7%
MP_T1S11_S1_L002	99.3%	81.4%
MP_T1S2_S1_L002	99.3%	76.6%
MP_T1S3_S1_L002	99.2%	76.5%
MP_T1S4_S1_L002	99.3%	76.5%
MP_T1S5_S1_L002	99.4%	76.8%
MP_T1S6_S1_L002	99.2%	76.6%
MP_T1S7_S1_L002	99.3%	76.4%
MP_T1S8_S1_L002	99.2%	76.6%
MP_T1S9_S1_L002	99.2%	76.6%
MP_T1Tiana_S1_L002	99.2%	76.9%
MP_T1Wessuck_S1_L002	99.0%	84.1%
MP_T3Blank_S1_L002	98.7%	89.1%
MP_T3PosCon_S1_L002	99.1%	81.9%
MP_T3S1_S1_L002	98.2%	82.1%
MP_T3S10_S1_L002	99.2%	78.7%
MP_T3S11_S1_L002	99.2%	76.5%
MP_T3S2_S1_L002	99.1%	84.2%
MP_T3S3_S1_L002	99.1%	77.7%
MP_T3S4_S1_L002	98.9%	76.4%
MP_T3S5_S1_L002	99.3%	76.7%
MP_T3S6_S1_L002	99.0%	84.9%
MP_T3S7_S1_L002	99.2%	76.7%
MP_T3S8_S1_L002	99.3%	76.6%
MP_T3S9_S1_L002	99.0%	85.5%
MP_T3Tiana_S1_L002	99.2%	76.5%
MP_T3Wessuck_S1_L002	98.8%	86.9%
MP_T5Blank_S2_L002	99.3%	87.6%
MP_T5PosCon_S2_L002	99.0%	84.4%
MP_T5S1_S1_L002	99.1%	77.2%
MP_T5S10_S2_L002	99.1%	76.5%
MP_T5S11_S2_L002	99.3%	76.6%
MP_T5S2_S1_L002	99.2%	77.6%
MP_T5S3_S1_L002	99.3%	76.9%
MP_T5S4_S1_L002	99.2%	78.8%
MP_T5S5_S1_L002	99.1%	76.7%
MP_T5S6_S2_L002	99.1%	77.0%
MP_T5S7_S2_L002	99.1%	76.9%
MP_T5S8_S2_L002	99.1%	78.6%
MP_T5S9_S2_L002	99.1%	76.4%
MP_T5Tiana_S2_L002	99.2%	80.6%
MP_T5Wessuck_S2_L002	99.0%	85.2%
```

```
Running DADA2: Sun Jan 19 12:09:58 EST 2025
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_OSedge3_S3_L002_R1_trimmed.fq.gz 93.9056
MP_OSedge4_S3_L002_R1_trimmed.fq.gz 95.4704
MP_OSedge5_S3_L002_R1_trimmed.fq.gz 95.2922
MP_OSedge6_S3_L002_R1_trimmed.fq.gz 95.2632
MP_OSedge7_S3_L002_R1_trimmed.fq.gz 96.0149
MP_OSedge8_S3_L002_R1_trimmed.fq.gz 95.5119
MP_OSedge9_S3_L002_R1_trimmed.fq.gz 95.1833
MP_T1Blank_S1_L002_R1_trimmed.fq.gz 94.2946
MP_T1PosCon_S1_L002_R1_trimmed.fq.gz 95.335
MP_T1S1_S1_L002_R1_trimmed.fq.gz 95.5671
MP_T1S10_S1_L002_R1_trimmed.fq.gz 95.8484
MP_T1S11_S1_L002_R1_trimmed.fq.gz 94.4359
MP_T1S2_S1_L002_R1_trimmed.fq.gz 95.8112
MP_T1S3_S1_L002_R1_trimmed.fq.gz 95.1466
MP_T1S4_S1_L002_R1_trimmed.fq.gz 95.5066
MP_T1S5_S1_L002_R1_trimmed.fq.gz 94.9663
MP_T1S6_S1_L002_R1_trimmed.fq.gz 95.4935
MP_T1S7_S1_L002_R1_trimmed.fq.gz 95.4629
MP_T1S8_S1_L002_R1_trimmed.fq.gz 95.1516
MP_T1S9_S1_L002_R1_trimmed.fq.gz 95.2038
MP_T1Tiana_S1_L002_R1_trimmed.fq.gz 95.3668
MP_T1Wessuck_S1_L002_R1_trimmed.fq.gz 93.8949
MP_T3Blank_S1_L002_R1_trimmed.fq.gz 93.017
MP_T3PosCon_S1_L002_R1_trimmed.fq.gz 94.4357
MP_T3S1_S1_L002_R1_trimmed.fq.gz 94.9347
MP_T3S10_S1_L002_R1_trimmed.fq.gz 95.3743
MP_T3S11_S1_L002_R1_trimmed.fq.gz 95.5627
MP_T3S2_S1_L002_R1_trimmed.fq.gz 94.5204
MP_T3S3_S1_L002_R1_trimmed.fq.gz 95.5019
MP_T3S4_S1_L002_R1_trimmed.fq.gz 95.1486
MP_T3S5_S1_L002_R1_trimmed.fq.gz 95.8559
MP_T3S6_S1_L002_R1_trimmed.fq.gz 93.5246
MP_T3S7_S1_L002_R1_trimmed.fq.gz 94.6912
MP_T3S8_S1_L002_R1_trimmed.fq.gz 95.7906
MP_T3S9_S1_L002_R1_trimmed.fq.gz 94.1828
MP_T3Tiana_S1_L002_R1_trimmed.fq.gz 95.733
MP_T3Wessuck_S1_L002_R1_trimmed.fq.gz 93.2999
MP_T5Blank_S2_L002_R1_trimmed.fq.gz 95.5076
MP_T5PosCon_S2_L002_R1_trimmed.fq.gz 94.69
MP_T5S1_S1_L002_R1_trimmed.fq.gz 95.3293
MP_T5S10_S2_L002_R1_trimmed.fq.gz 94.9797
MP_T5S11_S2_L002_R1_trimmed.fq.gz 96.0023
MP_T5S2_S1_L002_R1_trimmed.fq.gz 95.6406
MP_T5S3_S1_L002_R1_trimmed.fq.gz 95.3351
MP_T5S4_S1_L002_R1_trimmed.fq.gz 95.3099
MP_T5S5_S1_L002_R1_trimmed.fq.gz 94.7868
MP_T5S6_S2_L002_R1_trimmed.fq.gz 95.9622
MP_T5S7_S2_L002_R1_trimmed.fq.gz 94.7347
MP_T5S8_S2_L002_R1_trimmed.fq.gz 95.4269
MP_T5S9_S2_L002_R1_trimmed.fq.gz 95.4253
MP_T5Tiana_S2_L002_R1_trimmed.fq.gz 95.2405
MP_T5Wessuck_S2_L002_R1_trimmed.fq.gz 94.1371
```

```
FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_OSedge3_S3_L002 82.2
MP_OSedge4_S3_L002 84
MP_OSedge5_S3_L002 77.7
MP_OSedge6_S3_L002 84
MP_OSedge7_S3_L002 86.2
MP_OSedge8_S3_L002 86.1
MP_OSedge9_S3_L002 76.2
MP_T1Blank_S1_L002 86.7
MP_T1PosCon_S1_L002 85
MP_T1S1_S1_L002 85.4
MP_T1S10_S1_L002 87.1
MP_T1S11_S1_L002 86.1
MP_T1S2_S1_L002 86.2
MP_T1S3_S1_L002 83.9
MP_T1S4_S1_L002 86.4
MP_T1S5_S1_L002 87
MP_T1S6_S1_L002 84.8
MP_T1S7_S1_L002 86.4
MP_T1S8_S1_L002 84.2
MP_T1S9_S1_L002 84.3
MP_T1Tiana_S1_L002 84.1
MP_T1Wessuck_S1_L002 75.6
MP_T3Blank_S1_L002 65.1
MP_T3PosCon_S1_L002 82.3
MP_T3S1_S1_L002 83
MP_T3S10_S1_L002 84.3
MP_T3S11_S1_L002 81.1
MP_T3S2_S1_L002 70.5
MP_T3S3_S1_L002 86.6
MP_T3S4_S1_L002 85.2
MP_T3S5_S1_L002 84.2
MP_T3S6_S1_L002 74.7
MP_T3S7_S1_L002 79.8
MP_T3S8_S1_L002 83.4
MP_T3S9_S1_L002 72.4
MP_T3Tiana_S1_L002 88.6
MP_T3Wessuck_S1_L002 59.1
MP_T5Blank_S2_L002 87.7
MP_T5PosCon_S2_L002 66.3
MP_T5S1_S1_L002 80.8
MP_T5S10_S2_L002 83.1
MP_T5S11_S2_L002 86.3
MP_T5S2_S1_L002 77
MP_T5S3_S1_L002 86.7
MP_T5S4_S1_L002 83.3
MP_T5S5_S1_L002 84
MP_T5S6_S2_L002 85.4
MP_T5S7_S2_L002 79.9
MP_T5S8_S2_L002 82.7
MP_T5S9_S2_L002 86
MP_T5Tiana_S2_L002 85.9
MP_T5Wessuck_S2_L002 65.7


```


## CO1
Split 2024 CO1 sequences into 3 directories (otherwise crashes my computer) and run REVAMP)

Also start using parameters from Expedition config files and MIDORI ref library

### A

```
conda activate REVAMPenv

revamp.sh -p 01_config_file_CO1_2024a.txt -f 02_figure_config_file_CO1_2024a.txt -s 03_sample_metadata_CO1_2024a.txt  -r raw_data/2024-CO1a -o results-revamp-2024-CO1a

```


Output:

```
(REVAMPenv) admin@MacBook-Pro-5 shirp-edna % revamp.sh -p 01_config_file_CO1_2024a.txt -f 02_figure_config_file_CO1_2024a.txt -s 03_sample_metadata_CO1_2024a.txt  -r raw_data/2024-CO1a -o results-revamp-2024-CO1a
Config files identical
Sample metadata files identical

Start of run:
Sat Feb 15 17:19:54 EST 2025

Invoked script options:
/Users/admin/software/REVAMP/revamp.sh -p 01_config_file_CO1_2024a.txt -f 02_figure_config_file_CO1_2024a.txt -s 03_sample_metadata_CO1_2024a.txt -r raw_data/2024-CO1a -o results-revamp-2024-CO1a

Cutadapt from prior run

Running DADA2: Sat Feb 15 17:19:56 EST 2025
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_A_Blank_S1_L001_R1_trimmed.fq.gz 93.2684
MP_AC4_S1_L001_R1_trimmed.fq.gz 94.8369
MP_AC5_S1_L001_R1_trimmed.fq.gz 95.1288
MP_AS1_S1_L001_R1_trimmed.fq.gz 94.7115
MP_AS3_S1_L001_R1_trimmed.fq.gz 95.0174
MP_AS6_S1_L001_R1_trimmed.fq.gz 95.0632
MP_AS9_S1_L001_R1_trimmed.fq.gz 94.1382
MP_AT1_S1_L001_R1_trimmed.fq.gz 95.0575
MP_AT2_S1_L001_R1_trimmed.fq.gz 94.7099
MP_AT3_S1_L001_R1_trimmed.fq.gz 94.5636
MP_AT4_S1_L001_R1_trimmed.fq.gz 93.4371
MP_ATPositive_S1_L001_R1_trimmed.fq.gz 95.2676
MP_JT1_S1_L001_R1_trimmed.fq.gz 95.1784
MP_JT3_S1_L001_R1_trimmed.fq.gz 94.6969
MP_July_Blank_S1_L001_R1_trimmed.fq.gz 93.8432
MP_July_C4_S1_L001_R1_trimmed.fq.gz 94.7536
MP_July_C5_S1_L001_R1_trimmed.fq.gz 93.4289
MP_July_S1_S1_L001_R1_trimmed.fq.gz 93.146
MP_July_S3_S1_L001_R1_trimmed.fq.gz 95.4031
MP_July_S6_S1_L001_R1_trimmed.fq.gz 95.0169
MP_July_S9_S1_L001_R1_trimmed.fq.gz 95.0479
MP_June_Blank_S1_L001_R1_trimmed.fq.gz 94.0423
MP_June_C4_S1_L001_R1_trimmed.fq.gz 95.1316
MP_June_C5_S1_L001_R1_trimmed.fq.gz 95.0749
MP_June_Positive_S1_L001_R1_trimmed.fq.gz 88.1355
MP_June_S1_S1_L001_R1_trimmed.fq.gz 95.1919
MP_June_S3_S1_L001_R1_trimmed.fq.gz 95.2735
MP_June_S6_S1_L001_R1_trimmed.fq.gz 95.5201
MP_June_S9_S1_L001_R1_trimmed.fq.gz 95.1886
MP_S_Blank_S1_L001_R1_trimmed.fq.gz 94.2195
MP_S_Positive_S1_L001_R1_trimmed.fq.gz 95.2136
MP_SC4_S1_L001_R1_trimmed.fq.gz 94.8183
MP_SC5_S1_L001_R1_trimmed.fq.gz 94.012
MP_SS1_S1_L001_R1_trimmed.fq.gz 94.6209

Parameters to modify:
minLen,rm.phix,truncQ,maxEE-primer1,maxEE-primer2,trimRight,trimLeft
Current settings:
100,TRUE,2,2,2,25,0
Please check DADA2 filtering success. Proceed? [y/n/m]
y
Continuing!

Learning error, Dereplication, Merge, and ASVs in DADA2...
Please be patient, may take a while. Messages printed to Rscript log.


FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_A_Blank_S1_L001 91
MP_AC4_S1_L001 77.3
MP_AC5_S1_L001 77.8
MP_AS1_S1_L001 81.7
MP_AS3_S1_L001 80.6
MP_AS6_S1_L001 81.2
MP_AS9_S1_L001 75.8
MP_AT1_S1_L001 82.6
MP_AT2_S1_L001 82.1
MP_AT3_S1_L001 83.2
MP_AT4_S1_L001 82.3
MP_ATPositive_S1_L001 91.2
MP_JT1_S1_L001 83.4
MP_JT3_S1_L001 84.8
MP_July_Blank_S1_L001 90.2
MP_July_C4_S1_L001 81
MP_July_C5_S1_L001 81.3
MP_July_S1_S1_L001 80.8
MP_July_S3_S1_L001 83.4
MP_July_S6_S1_L001 82.7
MP_July_S9_S1_L001 84
MP_June_Blank_S1_L001 93.2
MP_June_C4_S1_L001 86
MP_June_C5_S1_L001 86.1
MP_June_Positive_S1_L001 84.4
MP_June_S1_S1_L001 86.3
MP_June_S3_S1_L001 85.7
MP_June_S6_S1_L001 86.1
MP_June_S9_S1_L001 85.1
MP_S_Blank_S1_L001 92.6
MP_S_Positive_S1_L001 90.1
MP_SC4_S1_L001 80.1
MP_SC5_S1_L001 80.3
MP_SS1_S1_L001 81.7

Do you wish to Proceed? [y/n]
y
Continuing!

Running BLASTn: Sun Feb 16 06:55:46 EST 2025
Warning: [blastn] Number of threads was reduced to 4 to match the number of available CPUs


Reformatting BLAST output: Sun Feb 16 07:22:21 EST 2025


Running ASV-2-Taxonomy Script: Sun Feb 16 07:23:05 EST 2025
07:23:11.583 [WARN] taxid 2935468 was deleted
07:23:11.584 [WARN] taxid 2989709 was deleted
07:23:11.585 [WARN] taxid 3030987 was deleted
07:23:11.585 [WARN] taxid 3030988 was deleted
07:23:11.586 [WARN] taxid 3067694 was deleted
07:23:11.586 [WARN] taxid 3048517 was deleted
07:23:11.586 [WARN] taxid 3073994 was deleted
07:23:11.586 [WARN] taxid 3080506 was deleted
07:23:11.586 [WARN] taxid 3080507 was deleted
07:23:11.587 [WARN] taxid 3126206 was deleted
07:23:11.587 [WARN] taxid 3137404 was deleted
07:23:11.588 [WARN] taxid 3149167 was deleted
07:23:11.588 [WARN] taxid 3158157 was deleted
07:23:11.588 [WARN] taxid 3230268 not found
07:23:11.588 [WARN] taxid 3230717 not found
07:23:11.588 [WARN] taxid 3230729 not found
07:23:11.588 [WARN] taxid 3231394 not found
07:23:11.588 [WARN] taxid 3240984 not found
07:23:11.588 [WARN] taxid 3241019 not found
07:23:11.588 [WARN] taxid 3241333 not found
07:23:11.588 [WARN] taxid 3298912 not found
07:23:11.588 [WARN] taxid 3341916 not found
07:23:11.588 [WARN] taxid 3347144 not found
07:23:11.595 [WARN] taxid 601278 was deleted

Reformatted taxon strings created. Options:
Continue without changes [c]
Manually edit file and replace in same location with identical file structure [m]
    (Make choice when file is modified and you are ready to proceed)
Automatically fill gaps in reformatted taxonkit hierarchy [a]
a
Reformatting...
Original reformatted taxonkit out stored at results-revamp-2024-CO1a/ASV2Taxonomy/reformatted_taxonkit_out_ORIGINAL.txt
Continuing!
Writing results-revamp-2024-CO1a_master_krona.html...
Writing results-revamp-2024-CO1a_wholeKRONA.html...
YOU MADE IT!
```



### B


```
revamp.sh -p 01_config_file_CO1_2024b.txt -f 02_figure_config_file_CO1_2024b.txt -s 03_sample_metadata_CO1_2024b.txt  -r raw_data/2024-CO1b -o results-revamp-2024-CO1b
```


Output

```
(REVAMPenv) admin@MacBook-Pro-5 shirp-edna % revamp.sh -p 01_config_file_CO1_2024b.txt -f 02_figure_config_file_CO1_2024b.txt -s 03_sample_metadata_CO1_2024b.txt  -r raw_data/2024-CO1b -o results-revamp-2024-CO1b
Config files identical
Sample metadata files identical
/Users/admin/software/REVAMP/revamp.sh: line 212: results-revamp-2024-CO1b/progress.txt: No such file or directory
mv: rename results-revamp-2024-CO1b/run.log to results-revamp-2024-CO1b/run_logs/runlog_Sun_Feb_16_08_44_54_EST_2025.txt: No such file or directory

Start of run:
Sun Feb 16 08:44:54 EST 2025

Invoked script options:
/Users/admin/software/REVAMP/revamp.sh -p 01_config_file_CO1_2024b.txt -f 02_figure_config_file_CO1_2024b.txt -s 03_sample_metadata_CO1_2024b.txt -r raw_data/2024-CO1b -o results-revamp-2024-CO1b

Running Cutadapt: Sun Feb 16 08:44:55 EST 2025
Finished Cutadapt: Sun Feb 16 08:52:39 EST 2025
Sample	Passing Reads	Passing bp
MP_SS3_S1_L001	99.5%	89.1%
MP_SS6_S1_L001	99.5%	89.2%
MP_SS9_S1_L001	99.5%	89.1%
MP_ST1_S1_L001	99.5%	89.1%
MP_ST2_S1_L001	99.4%	89.0%
MP_ST3_S1_L001	99.4%	89.0%
MP_ST4_S1_L001	99.5%	89.1%
MP_STPositive_S1_L001	99.4%	89.1%
MP_T1Blank_S1_L001	99.1%	88.8%
MP_T1Positive_S1_L001	99.5%	89.1%
MP_T1S1_S1_L001	99.3%	89.0%
MP_T1S2_S1_L001	99.4%	89.1%
MP_T1S3_S1_L001	99.4%	89.1%
MP_T1S4_S1_L001	99.3%	89.0%
MP_T1S5_S1_L001	99.5%	89.1%
MP_T1S6_S1_L001	99.4%	89.1%
MP_T1S7_S1_L001	99.5%	89.1%
MP_T1S8_S1_L001	99.4%	89.0%
MP_T1S9_S1_L001	99.3%	88.9%
MP_T1S10_S1_L001	99.4%	89.1%
MP_T1S11_S1_L001	99.5%	89.1%
MP_T1TC_S1_L001	99.5%	89.2%
MP_T1WC_S1_L001	99.4%	89.1%
MP_T3Blank_S1_L001	99.3%	89.0%
MP_T3Positive_S1_L001	99.4%	89.0%
MP_T3S1_S1_L001	99.4%	89.1%
MP_T3S2_S1_L001	99.4%	89.1%
MP_T3S3_S1_L001	99.4%	89.0%
MP_T3S4_S1_L001	99.4%	89.1%
MP_T3S5_S1_L001	99.4%	89.1%
MP_T3S6_S1_L001	99.4%	89.1%
MP_T3S7_S1_L001	99.5%	89.2%
MP_T3S8_S1_L001	99.5%	89.1%
MP_T3S9_S1_L001	99.4%	89.0%
MP_T3S10_S1_L001	99.4%	89.1%

Please check Cutadapt success. Proceed? [y/n]
y
Continuing!

Running DADA2: Sun Feb 16 08:55:31 EST 2025
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_SS3_S1_L001_R1_trimmed.fq.gz 93.6611
MP_SS6_S1_L001_R1_trimmed.fq.gz 93.3635
MP_SS9_S1_L001_R1_trimmed.fq.gz 94.8546
MP_ST1_S1_L001_R1_trimmed.fq.gz 95.0529
MP_ST2_S1_L001_R1_trimmed.fq.gz 93.4889
MP_ST3_S1_L001_R1_trimmed.fq.gz 94.9246
MP_ST4_S1_L001_R1_trimmed.fq.gz 94.9932
MP_STPositive_S1_L001_R1_trimmed.fq.gz 95.2405
MP_T1Blank_S1_L001_R1_trimmed.fq.gz 92.92
MP_T1Positive_S1_L001_R1_trimmed.fq.gz 94.2342
MP_T1S1_S1_L001_R1_trimmed.fq.gz 95.1392
MP_T1S2_S1_L001_R1_trimmed.fq.gz 95.608
MP_T1S3_S1_L001_R1_trimmed.fq.gz 95.3114
MP_T1S4_S1_L001_R1_trimmed.fq.gz 95.1743
MP_T1S5_S1_L001_R1_trimmed.fq.gz 94.5772
MP_T1S6_S1_L001_R1_trimmed.fq.gz 94.4615
MP_T1S7_S1_L001_R1_trimmed.fq.gz 94.9511
MP_T1S8_S1_L001_R1_trimmed.fq.gz 94.6468
MP_T1S9_S1_L001_R1_trimmed.fq.gz 94.3887
MP_T1S10_S1_L001_R1_trimmed.fq.gz 95.1367
MP_T1S11_S1_L001_R1_trimmed.fq.gz 94.5818
MP_T1TC_S1_L001_R1_trimmed.fq.gz 94.9939
MP_T1WC_S1_L001_R1_trimmed.fq.gz 94.8031
MP_T3Blank_S1_L001_R1_trimmed.fq.gz 94.7907
MP_T3Positive_S1_L001_R1_trimmed.fq.gz 94.5357
MP_T3S1_S1_L001_R1_trimmed.fq.gz 94.6015
MP_T3S2_S1_L001_R1_trimmed.fq.gz 95.0042
MP_T3S3_S1_L001_R1_trimmed.fq.gz 95.0367
MP_T3S4_S1_L001_R1_trimmed.fq.gz 95.1936
MP_T3S5_S1_L001_R1_trimmed.fq.gz 95.0385
MP_T3S6_S1_L001_R1_trimmed.fq.gz 94.4276
MP_T3S7_S1_L001_R1_trimmed.fq.gz 93.6742
MP_T3S8_S1_L001_R1_trimmed.fq.gz 94.6207
MP_T3S9_S1_L001_R1_trimmed.fq.gz 95.0654
MP_T3S10_S1_L001_R1_trimmed.fq.gz 94.835

Parameters to modify:
minLen,rm.phix,truncQ,maxEE-primer1,maxEE-primer2,trimRight,trimLeft
Current settings:
100,TRUE,2,2,2,25,0
Please check DADA2 filtering success. Proceed? [y/n/m]
y
Continuing!

Learning error, Dereplication, Merge, and ASVs in DADA2...
Please be patient, may take a while. Messages printed to Rscript log.


FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_SS3_S1_L001 80.5
MP_SS6_S1_L001 76.4
MP_SS9_S1_L001 82.1
MP_ST1_S1_L001 82.1
MP_ST2_S1_L001 81.2
MP_ST3_S1_L001 83.6
MP_ST4_S1_L001 82.7
MP_STPositive_S1_L001 90.5
MP_T1Blank_S1_L001 89.3
MP_T1Positive_S1_L001 91
MP_T1S1_S1_L001 84.6
MP_T1S2_S1_L001 84.3
MP_T1S3_S1_L001 82.1
MP_T1S4_S1_L001 84.5
MP_T1S5_S1_L001 86.6
MP_T1S6_S1_L001 84
MP_T1S7_S1_L001 83.8
MP_T1S8_S1_L001 84.7
MP_T1S9_S1_L001 85.4
MP_T1S10_S1_L001 85.3
MP_T1S11_S1_L001 86.7
MP_T1TC_S1_L001 86.9
MP_T1WC_S1_L001 83.7
MP_T3Blank_S1_L001 90.4
MP_T3Positive_S1_L001 90.1
MP_T3S1_S1_L001 82.3
MP_T3S2_S1_L001 81.9
MP_T3S3_S1_L001 80.1
MP_T3S4_S1_L001 84.3
MP_T3S5_S1_L001 85.6
MP_T3S6_S1_L001 84.2
MP_T3S7_S1_L001 84.6
MP_T3S8_S1_L001 85.8
MP_T3S9_S1_L001 85.4
MP_T3S10_S1_L001 84.8

Do you wish to Proceed? [y/n]
y
Continuing!

Running BLASTn: Mon Feb 17 14:49:42 EST 2025
Warning: [blastn] Number of threads was reduced to 4 to match the number of available CPUs


Reformatting BLAST output: Mon Feb 17 15:30:20 EST 2025


Running ASV-2-Taxonomy Script: Mon Feb 17 15:31:15 EST 2025
15:31:21.043 [WARN] taxid 2763925 was deleted
15:31:21.049 [WARN] taxid 3000344 was deleted
15:31:21.049 [WARN] taxid 3000446 was deleted
15:31:21.050 [WARN] taxid 3030988 was deleted
15:31:21.051 [WARN] taxid 3055840 was deleted
15:31:21.051 [WARN] taxid 3056766 was deleted
15:31:21.051 [WARN] taxid 3056966 was deleted
15:31:21.051 [WARN] taxid 3068579 was deleted
15:31:21.051 [WARN] taxid 3068582 was deleted
15:31:21.051 [WARN] taxid 3068590 was deleted
15:31:21.052 [WARN] taxid 3073994 was deleted
15:31:21.052 [WARN] taxid 3075003 was deleted
15:31:21.052 [WARN] taxid 3080506 was deleted
15:31:21.052 [WARN] taxid 3080507 was deleted
15:31:21.052 [WARN] taxid 3127030 was deleted
15:31:21.052 [WARN] taxid 3134262 was deleted
15:31:21.053 [WARN] taxid 3134263 was deleted
15:31:21.053 [WARN] taxid 3137403 was deleted
15:31:21.053 [WARN] taxid 3137404 was deleted
15:31:21.053 [WARN] taxid 3149167 was deleted
15:31:21.053 [WARN] taxid 3158157 was deleted
15:31:21.053 [WARN] taxid 3158911 was deleted
15:31:21.053 [WARN] taxid 3162510 was deleted
15:31:21.053 [WARN] taxid 3239829 not found
15:31:21.053 [WARN] taxid 3240984 not found
15:31:21.053 [WARN] taxid 3230268 not found
15:31:21.054 [WARN] taxid 3230729 not found
15:31:21.054 [WARN] taxid 3298912 not found
15:31:21.054 [WARN] taxid 3301459 not found
15:31:21.054 [WARN] taxid 3341916 not found
15:31:21.061 [WARN] taxid 601278 was deleted

Reformatted taxon strings created. Options:
Continue without changes [c]
Manually edit file and replace in same location with identical file structure [m]
    (Make choice when file is modified and you are ready to proceed)
Automatically fill gaps in reformatted taxonkit hierarchy [a]
a
Reformatting...
Original reformatted taxonkit out stored at results-revamp-2024-CO1b/ASV2Taxonomy/reformatted_taxonkit_out_ORIGINAL.txt
Continuing!
Writing results-revamp-2024-CO1b_master_krona.html...
Writing results-revamp-2024-CO1b_wholeKRONA.html...
YOU MADE IT!

```


### C


```
revamp.sh -p 01_config_file_CO1_2024c.txt -f 02_figure_config_file_CO1_2024c.txt -s 03_sample_metadata_CO1_2024c.txt  -r raw_data/2024-CO1c -o results-revamp-2024-CO1c
```


Output

```

Start of run:
Mon Feb 17 17:30:45 EST 2025

Invoked script options:
/Users/admin/software/REVAMP/revamp.sh -p 01_config_file_CO1_2024c.txt -f 02_figure_config_file_CO1_2024c.txt -s 03_sample_metadata_CO1_2024c.txt -r raw_data/2024-CO1c -o results-revamp-2024-CO1c

Running Cutadapt: Mon Feb 17 17:30:48 EST 2025
Finished Cutadapt: Mon Feb 17 17:38:33 EST 2025
Sample	Passing Reads	Passing bp
MP_T3S11_S1_L001	99.4%	89.0%
MP_T3TC_S1_L001	99.3%	89.0%
MP_T3WC_S1_L001	99.3%	89.0%
MP_T5S1_S1_L001	99.3%	89.0%
MP_T5S2_S1_L001	99.3%	89.0%
MP_T5S3_S1_L001	99.4%	89.1%
MP_T5S4_S1_L001	99.4%	89.0%
MP_T5S5_S1_L001	99.5%	89.1%
MP_T5S6_S1_L001	99.4%	89.1%
MP_T5S7_S1_L001	99.4%	89.1%
MP_T5S8_S1_L001	99.4%	89.0%
MP_T5S9_S1_L001	99.4%	89.0%
MP_T5S10_S1_L001	99.4%	89.0%
MP_T5S11_S1_L001	99.4%	89.1%
MP_T5SBlank_S1_L001	99.4%	89.1%
MP_T5TC_S1_L001	99.3%	89.0%
MP_T5WC_S1_L001	99.5%	89.1%
MP_T7Blank_S1_L001	99.4%	88.8%
MP_T7S1_S1_L001	99.4%	89.1%
MP_T7S2_1_S1_L001	99.5%	89.1%
MP_T7S2_S1_L001	99.4%	89.1%
MP_T7S3_S1_L001	99.4%	89.1%
MP_T7S4_S1_L001	99.5%	89.2%
MP_T7S5_S1_L001	99.5%	89.2%
MP_T7S6_S1_L001	99.3%	89.0%
MP_T7S7_S1_L001	99.5%	89.1%
MP_T7S8_S1_L001	99.4%	89.1%
MP_T7S9_1_S1_L001	99.5%	89.1%
MP_T7S9_S1_L001	99.4%	89.1%
MP_T7S10_S1_L001	99.3%	89.0%
MP_T7S11_S1_L001	99.4%	89.0%
MP_T7TC_S1_L001	99.4%	89.0%
MP_T7WC_S1_L001	99.3%	89.0%
MP_T72_2_S1_L001	99.5%	89.1%
MP_T79_2_S1_L001	99.4%	89.1%

Please check Cutadapt success. Proceed? [y/n]
Continuing!

Running DADA2: Mon Feb 17 19:10:15 EST 2025
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_T3S11_S1_L001_R1_trimmed.fq.gz 95.0897
MP_T3TC_S1_L001_R1_trimmed.fq.gz 94.6535
MP_T3WC_S1_L001_R1_trimmed.fq.gz 94.8145
MP_T5S1_S1_L001_R1_trimmed.fq.gz 95.3167
MP_T5S2_S1_L001_R1_trimmed.fq.gz 94.9829
MP_T5S3_S1_L001_R1_trimmed.fq.gz 94.8357
MP_T5S4_S1_L001_R1_trimmed.fq.gz 95.0469
MP_T5S5_S1_L001_R1_trimmed.fq.gz 92.8178
MP_T5S6_S1_L001_R1_trimmed.fq.gz 95.1068
MP_T5S7_S1_L001_R1_trimmed.fq.gz 94.9176
MP_T5S8_S1_L001_R1_trimmed.fq.gz 94.6487
MP_T5S9_S1_L001_R1_trimmed.fq.gz 95.0829
MP_T5S10_S1_L001_R1_trimmed.fq.gz 95.2026
MP_T5S11_S1_L001_R1_trimmed.fq.gz 94.1758
MP_T5SBlank_S1_L001_R1_trimmed.fq.gz 95.053
MP_T5TC_S1_L001_R1_trimmed.fq.gz 95.0635
MP_T5WC_S1_L001_R1_trimmed.fq.gz 94.3847
MP_T7Blank_S1_L001_R1_trimmed.fq.gz 89.2806
MP_T7S1_S1_L001_R1_trimmed.fq.gz 95.2839
MP_T7S2_1_S1_L001_R1_trimmed.fq.gz 94.2885
MP_T7S2_S1_L001_R1_trimmed.fq.gz 95.4101
MP_T7S3_S1_L001_R1_trimmed.fq.gz 95.0404
MP_T7S4_S1_L001_R1_trimmed.fq.gz 93.2765
MP_T7S5_S1_L001_R1_trimmed.fq.gz 92.6826
MP_T7S6_S1_L001_R1_trimmed.fq.gz 94.1065
MP_T7S7_S1_L001_R1_trimmed.fq.gz 95.487
MP_T7S8_S1_L001_R1_trimmed.fq.gz 95.1322
MP_T7S9_1_S1_L001_R1_trimmed.fq.gz 94.5849
MP_T7S9_S1_L001_R1_trimmed.fq.gz 95.2941
MP_T7S10_S1_L001_R1_trimmed.fq.gz 94.8198
MP_T7S11_S1_L001_R1_trimmed.fq.gz 94.0254
MP_T7TC_S1_L001_R1_trimmed.fq.gz 94.4726
MP_T7WC_S1_L001_R1_trimmed.fq.gz 95.0384
MP_T72_2_S1_L001_R1_trimmed.fq.gz 94.8793
MP_T79_2_S1_L001_R1_trimmed.fq.gz 94.8787

Parameters to modify:
minLen,rm.phix,truncQ,maxEE-primer1,maxEE-primer2,trimRight,trimLeft
Current settings:
100,TRUE,2,2,2,25,0
Please check DADA2 filtering success. Proceed? [y/n/m]
Continuing!

Learning error, Dereplication, Merge, and ASVs in DADA2...
Please be patient, may take a while. Messages printed to Rscript log.


FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_T3S11_S1_L001 82.6
MP_T3TC_S1_L001 84.1
MP_T3WC_S1_L001 82.6
MP_T5S1_S1_L001 80.2
MP_T5S2_S1_L001 80
MP_T5S3_S1_L001 77.2
MP_T5S4_S1_L001 81.4
MP_T5S5_S1_L001 82.1
MP_T5S6_S1_L001 84.3
MP_T5S7_S1_L001 83.9
MP_T5S8_S1_L001 84.5
MP_T5S9_S1_L001 84.2
MP_T5S10_S1_L001 81.5
MP_T5S11_S1_L001 82.8
MP_T5SBlank_S1_L001 90.4
MP_T5TC_S1_L001 81.7
MP_T5WC_S1_L001 78.9
MP_T7Blank_S1_L001 88
MP_T7S1_S1_L001 84.9
MP_T7S2_1_S1_L001 80.9
MP_T7S2_S1_L001 83.5
MP_T7S3_S1_L001 82.5
MP_T7S4_S1_L001 83.7
MP_T7S5_S1_L001 83
MP_T7S6_S1_L001 84
MP_T7S7_S1_L001 84.9
MP_T7S8_S1_L001 85.9
MP_T7S9_1_S1_L001 85.2
MP_T7S9_S1_L001 83.9
MP_T7S10_S1_L001 83.5
MP_T7S11_S1_L001 84.6
MP_T7TC_S1_L001 77.5
MP_T7WC_S1_L001 83.5
MP_T72_2_S1_L001 81.6
MP_T79_2_S1_L001 83.9

Do you wish to Proceed? [y/n]
Continuing!

Running BLASTn: Tue Feb 18 06:56:12 EST 2025
Warning: [blastn] Number of threads was reduced to 4 to match the number of available CPUs


Reformatting BLAST output: Tue Feb 18 07:23:42 EST 2025


Running ASV-2-Taxonomy Script: Tue Feb 18 07:24:22 EST 2025
07:24:30.989 [33m[WARN][0m taxid 2951023 was deleted
07:24:30.992 [33m[WARN][0m taxid 3030988 was deleted
07:24:30.992 [33m[WARN][0m taxid 3060260 was deleted
07:24:30.992 [33m[WARN][0m taxid 3055840 was deleted
07:24:30.992 [33m[WARN][0m taxid 3068582 was deleted
07:24:30.993 [33m[WARN][0m taxid 3073994 was deleted
07:24:30.993 [33m[WARN][0m taxid 3074953 was deleted
07:24:30.994 [33m[WARN][0m taxid 3115570 was deleted
07:24:30.994 [33m[WARN][0m taxid 3137404 was deleted
07:24:30.994 [33m[WARN][0m taxid 3138242 was deleted
07:24:30.994 [33m[WARN][0m taxid 3230268 not found
07:24:30.994 [33m[WARN][0m taxid 3230729 not found
07:24:30.994 [33m[WARN][0m taxid 3240984 not found
07:24:30.994 [33m[WARN][0m taxid 3241019 not found
07:24:30.994 [33m[WARN][0m taxid 3241333 not found
07:24:30.994 [33m[WARN][0m taxid 3243676 not found
07:24:30.995 [33m[WARN][0m taxid 3341916 not found
07:24:31.001 [33m[WARN][0m taxid 601278 was deleted

Reformatted taxon strings created. Options:
Continue without changes [c]
Manually edit file and replace in same location with identical file structure [m]
    (Make choice when file is modified and you are ready to proceed)
Automatically fill gaps in reformatted taxonkit hierarchy [a]
Reformatting...
Original reformatted taxonkit out stored at results-revamp-2024-CO1c/ASV2Taxonomy/reformatted_taxonkit_out_ORIGINAL.txt
Continuing!
Writing results-revamp-2024-CO1c_master_krona.html...
Writing results-revamp-2024-CO1c_wholeKRONA.html...
YOU MADE IT!

```


## 3/11/2025-3/19 COI
- Decided to use MIDORI above. BLASTing against local NCBI database was taking days, even for these reduced datasets. ON the other hand, scanning through Krona plots, the MIDORI assignments are not great for Chordates, and that's a key target group for ShiRP... 
	- Pull out all ASVS assigned as Chordates by MIDORI and reBLAST against NCBI
		- Include the Unknowns as well, just to see if I can get a better idea of missing taxa
	- Doing this for both Expedition and regular 2024 season data. 

### Try on the `test` dataset first:

Note: I just need to get it to the point where it rewrites these equivalent files to include the missing NCBI BLASTed- ASVs:

- `results-revamp-2024-MiFIsh-expedition/ASV2Taxonomy/ASVs_counts_NOUNKNOWNS.tsv`
- `results-revamp-2024-MiFIsh-expedition/ASV2Taxonomy/results-revamp-2024-MiFish-expedition_asvTaxonomyTable_NOUNKNOWNS.txt`
- Sample metadata files already written in previous MIDORI analysis


```
cd /Volumes/easystore/eDNA/shirp-edna/results-revamp-2024-CO1-expeditiona-test/ASV2Taxonomy
```

<br>

Generate a taxonomy file with only ASVs with unknown Kingdom, Phylum, or Class, and all Chordates. These will be re-BLASTed against NCBI nt

```
awk -F'\t' 'NR==1 || $2 == "Unknown NA" || $3 == "Unknown NA" || $4 == "Unknown NA" || $3 == "Chordata"' results-revamp-2024-CO1-expeditiona-test_asvTaxonomyTable.txt > ../Unknowns_reBLAST/results-revamp-2024-CO1-expeditiona-test_asvTaxonomyTable-filtered.txt
```

<br>

Copy everything (manually) from `dada2` subfolder, except fastq files (because large) and pdf images (bc unecessary), into `results-revamp-2024-CO1-expeditiona-test/Unknowns_reBLAST` subfolder. Also copy config files and sample name lists here

<br>

In this subfolder `results-revamp-2024-CO1-expeditiona-test/Unknowns_reBLAST/dada2` subfolder, remove the ASVs that are not being re-BLASTed from the fasta file

```
cd /Volumes/easystore/eDNA/shirp-edna/results-revamp-2024-CO1-expeditiona-test/Unknowns_reBLAST
```

Pull out corresponding ASVs from fasta file

Then rename `ASVs_filtered.fa` to `ASVs.fa` bc that it what REVAMP expects. Note this removes the full ASVs.fa file (which is backed up in the MIDORI results directory anyway)

```
awk 'NR==FNR {asvs[">"$1]; next} /^>/ {seq=($1 in asvs)} seq' ../ASV2Taxonomy/results-revamp-2024-CO1-expeditiona-test_asvTaxonomyTable-filtered.txt ../dada2/ASVs.fa > dada2/ASVs_filtered.fa

mv dada2/ASVs_filtered.fa dada2/ASVs.fa
```

<br>

Do same modficiation for `ASVs_counts.tsv` and retain headers

```
awk 'NR==FNR {asvs[$1]; next} FNR==1 || ($1 in asvs)' ../ASV2Taxonomy/results-revamp-2024-CO1-expeditiona-test_asvTaxonomyTable-filtered.txt ../dada2/ASVs_counts.tsv > dada2/ASVs_counts_filtered.tsv

mv dada2/ASVs_counts_filtered.tsv dada2/ASVs_counts.tsv
```


<br>

Also modified `blast_assessment.pl` script in REVAMP because it was renaming ASV_1, 2 etc rather than pulling actual names of subset AVSs. This was messing up the `checkmaxtargetseqs.txt` file and all downstream analyses.

EDIT: changed this back to riginal script and kept my modified script as `blast_assessment_mod.pl` in REVAMP software directory


<br>

Try starting REVAMP from this point, with `progress.txt` indicating only cutadapt and dada2 were completed. BLAST against just NCBI nt (local). Also made new config_file, `01_config_file_CO1_2024-expeditiona-test-reblast.txt`, indicating NCBI database. Figure config file and sample metadata are the same.



```
cd /Volumes/easystore/eDNA/shirp-edna

revamp.sh -p 01_config_file_CO1_2024-expeditiona-test-reblast.txt -f 02_figure_config_file_CO1_2024-expeditiona-test.txt -s 03_sample_metadata_CO1_2024-expeditiona-test.txt  -r raw_data/results-revamp-2024-CO1-expeditiona-test -o results-revamp-2024-CO1-expeditiona-test/Unknowns_reBLAST

```


<br>

#### Check output

- REVAMP got stuck because of missing data in reference files compared to full dataset. But completed BLAST and BLAST reformat steps. I will address continuing,  but meanwhile, scanning through some of the blast results....
	- `ASV_1017` and `ASV_468` have VERY different results according to MIDORI and NCBI.
		- `ASV_1017`:
			- Using MIDORI, is taxID 143519, which is `Eukaryota;Chordata;Amphibia;Anura;Mantellidae;Mantella;Mantella haraldmeieri`
			- Using NCBI, it is taxID 2558399, which is `Eukaryota;Arthropoda;Insecta;Diptera;Simuliidae;Simulium;Simulium nr_ paynei sensu lato LHSMI151_09`

		- `ASV_468`:
			- Using MIDORI: taxID 143519, `Eukaryota;Chordata;Amphibia;Anura;Mantellidae;Mantella;Mantella haraldmeieri`
			- Using NCBI, taxID 674295, `Eukaryota;Mollusca;Gastropoda;Cephalaspidea;Haminoeidae;Haloa;Haloa japonica`
	- I blasted the sequence in the BLASTn GUI (confirming the sequences were the same in each fasta file and nothing went wrong when I subsetted the file) and similarly the results are all over the phyogenetic tree. These are for `ASV_468`:

![image](figures-expedition/Blast-screenshot_20250314.png)

- For what it's worth, the hit identified by MIDORI, Mantella, is a voucher specimen, although amphibians seem to be rare on this full list of hits, and very low down on the ranking of e-scores. And it is a species from Madagascar! Ok this is definitely not right. These are most likely red algae based on BLASTn GUI, but REVAMP doesn't spit that out using either reference library...
- At least, for both these strange ASVs, abundance is low. Checking the more abundant ones makes more sense- the methods agree on ASV_62 and ASV_326, which are both `Ascidia ahodori`
- The NCBI taxonomy gives a lot more tax resolution for the teleosts


At this point, copy `ASV_blastn_nt.btab` file from total (MIDORI) analysis into this subfolder, substitute the lines in from the NCBI analysis

```
cd /Volumes/easystore/eDNA/shirp-edna/results-revamp-2024-CO1-expeditiona-test/Unknowns_reBLAST

mv blast_results/ASV_blastn_nt.btab blast_results/ASV_blastn_nt_unknowns_chordates_only.btab

cp ../blast_results/ASV_blastn_nt.btab blast_results/
```

Replace rows of reBLASTed ASVs into `ASV_blastn_nt_formatted.txt` file 

```
cd blast_results

awk '
NR==FNR {
    asv[$1] = 1
    data[$1] = data[$1] $0 ORS
    order[NR] = $1
    next
}
{
    if ($1 in asv) {
        if (!seen[$1]) {
            print data[$1]
            seen[$1] = 1
        }
    } else {
        print
    }
}
END {
    for (i = 1; i <= NR; i++) {
        asvName = order[i]
        if (!(asvName in seen)) {
            print data[asvName]
        }
    }
}
' ASV_blastn_nt_unknowns_chordates_only.btab ASV_blastn_nt.btab > ASV_blastn_nt_updated.btab

awk 'NF' ASV_blastn_nt_updated.btab > ASV_blastn_nt_final.btab
```


Overwrite the copied file to maintain file naming structure for REVAMP

```
mv ASV_blastn_nt_final.btab ASV_blastn_nt.btab

```

Next, overwrite reBLAST/dada2/ASVs.fa to include all ASVs again. (It currently only reflects the reBLASTed ones but REVAMP is expecting all ASV names in this file.

```
cd ..

cp ../dada2/ASVs.fa dada2/

```


Run REVAMP in `Unknowns_reBLAST` directory again, starting with `progress.txt` at `blastformattingFinished=FALSE`. 

```
cd /Volumes/easystore/eDNA/shirp-edna

revamp.sh -p 01_config_file_CO1_2024-expeditiona-test-reblast.txt -f 02_figure_config_file_CO1_2024-expeditiona-test.txt -s 03_sample_metadata_CO1_2024-expeditiona-test.txt  -r raw_data/results-revamp-2024-CO1-expeditiona-test -o results-revamp-2024-CO1-expeditiona-test/Unknowns_reBLAST

```


I had help integrating all of the above into a script, `automate_reblast.sh` that subsets the Chordates and unknowns from the MIDORI results, puts them in a dada2 subfolder in an reblast subfolder, renames thems ASV_1, 2, 3, etc from their original names (REVAMPrequires this), reruns REVAMP only on this subset, renames them back to their original names, and integrates them into the original MIDORI results while backing up the orginal:

```
./automate_reblast.sh results-revamp-2024-CO1-expeditiona-test
```


Was getting the memory mapping error again but using `ulimit -n 9999 ` temporarily overides this (from [here](https://www.biostars.org/p/414500/))

## COI re-BLAST continued
### 3/20/25- 3/26/25

I finally got it to work. The trick was not putting the Unknowns_reblast subdirectory into the already generated MIDORI result directory, but in an equivalent level bc thats where REVAMP was looking for it: 

Keep working on `automate_reblast.sh` to re-generate results files:

I just need to re-generate `results-revamp-2024-MiFIsh-expedition/ASV2Taxonomy/results-revamp-2024-MiFish-expedition_asvTaxonomyTable_NOUNKNOWNS.txt` by inserting the new taxonomy of the subsetted ASVs into there. The counts and sample metadata remain the same

Worked!!!! Did some cross-chcking of `results-revamp-2024-CO1-expeditiona-test_Updated_asvTaxonomyTable.txt` to see if it makes sense and it does, the ASVs numbers were put back correctly. I think this is working now. Start running on each of the COI subset of results

#### COI expedition

```
cd /Volumes/easystore/eDNA/shirp-edna

./automate_reblast.sh results-revamp-2024-CO1-expeditiona CO1_2024-expeditiona
```

- 1st argument is name of directory with MIDORI results
- 2nd argument is name used in config file (this is a new config file that points to NCBI reference database rather than MIDORI). Naming convention I've been using for these files is `01_config_file_{name]-reblast.txt`
- Make sure to cancel once REVAMP starts, modify progress.txt so it doesn't re-run cutadapt and dada2 steps
- Also shifted to focusing on Chordata only because there are too many ASVs and blasting against NCBI is taking forever


Check over results and that correct ASVs were replaced. Meanwhile run B...
- make config file, `01_config_file_CO1_2024-expeditionb-test-reblast.txt`, other 2 are the same as for MIDORI analysis. Pipeline copies and renames them into subdirectory

```
cd /Volumes/easystore/eDNA/shirp-edna

./automate_reblast.sh results-revamp-2024-CO1-expeditionb CO1_2024-expeditionb
```

run C...

```
cd /Volumes/easystore/eDNA/shirp-edna

./automate_reblast.sh results-revamp-2024-CO1-expeditionc CO1_2024-expeditionc
```

and run the 2024 COI results
A-

```
cd /Volumes/easystore/eDNA/shirp-edna

./automate_reblast.sh results-revamp-2024-CO1a CO1_2024a
```

B-

```
cd /Volumes/easystore/eDNA/shirp-edna

./automate_reblast.sh results-revamp-2024-CO1b CO1_2024b
```

C-

```
cd /Volumes/easystore/eDNA/shirp-edna

./automate_reblast.sh results-revamp-2024-CO1c CO1_2024c
```



Meanwhile, the taxonomy files were generated with incorrect tabs and this is messing up taxonomy when importing to R. To quickly correct them so i can continue in R:

From within each subdirectory:

```
awk '{
  if (NF > 8) {
    $8 = $8 FS $9;
    for (i = 9; i < NF; i++) $i = "";
  }
  NF = 8;
  print $0
}' OFS='\t' results-revamp-2024-CO1-expeditiona_Updated_asvTaxonomyTable.txt > results-revamp-2024-CO1-expeditiona_Updated_asvTaxonomyTable_fixed.txt

```

```
awk '{
  if (NF > 8) {
    $8 = $8 FS $9;
    for (i = 9; i < NF; i++) $i = "";
  }
  NF = 8;
  print $0
}' OFS='\t' results-revamp-2024-CO1-expeditionb_Updated_asvTaxonomyTable.txt > results-revamp-2024-CO1-expeditionb_Updated_asvTaxonomyTable_fixed.txt

```

```
awk '{
  if (NF > 8) {
    $8 = $8 FS $9;
    for (i = 9; i < NF; i++) $i = "";
  }
  NF = 8;
  print $0
}' OFS='\t' results-revamp-2024-CO1-expeditionc_Updated_asvTaxonomyTable.txt > results-revamp-2024-CO1-expeditionc_Updated_asvTaxonomyTable_fixed.txt

```

also updated script so this will be fixed in future runs-- DIDN"T WORK... continue to do it manually...

```
awk '{
  if (NF > 8) {
    $8 = $8 FS $9;
    for (i = 9; i < NF; i++) $i = "";
  }
  NF = 8;
  print $0
}' OFS='\t' results-revamp-2024-CO1a_Updated_asvTaxonomyTable.txt > results-revamp-2024-CO1a_Updated_asvTaxonomyTable_fixed.txt 
```

```
awk '{
  if (NF > 8) {
    $8 = $8 FS $9;
    for (i = 9; i < NF; i++) $i = "";
  }
  NF = 8;
  print $0
}' OFS='\t' results-revamp-2024-CO1b_Updated_asvTaxonomyTable.txt > results-revamp-2024-CO1b_Updated_asvTaxonomyTable_fixed.txt 
```

```
awk '{
  if (NF > 8) {
    $8 = $8 FS $9;
    for (i = 9; i < NF; i++) $i = "";
  }
  NF = 8;
  print $0
}' OFS='\t' results-revamp-2024-CO1c_Updated_asvTaxonomyTable.txt > results-revamp-2024-CO1c_Updated_asvTaxonomyTable_fixed.txt 
```