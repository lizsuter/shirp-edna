---
title: "Analysis Pipeline for MiFish/ Elas02/ mlCO1-generated amplicons, 2020-2024, SHiRP Project"
output: html_notebook
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


