---
title: "Analysis Pipeline for MiFish- and Elas02-generated amplicons from 2024 USV Expedition/SHiRP Project"
output: html_notebook
---

		
## 2024 Expedition Data- MiFish


Remove suffix from fastq files: `for file in *; do mv "${file}" "${file/_001/}"; done`

Remove prefix from file names (if re-running after mistake): `for file in * ; do mv -v "$file" "${file#*_}"; done`

Run REVAMP

```
conda activate REVAMPenv

revamp.sh -p 01_config_file_MIFish-2024-expedition.txt -f 02_figure_config_file_MiFish-2024-expedition.txt -s 03_sample_metadata_MiFIsh-2024-expedition.txt -r raw_data/2024-MiFish-U-expedition -o results-revamp-2024-MiFish-expedition
```

~Pasting output~

```
Running Cutadapt: Mon Nov  4 10:24:12 EST 2024
Finished Cutadapt: Mon Nov  4 10:32:48 EST 2024
Sample	Passing Reads	Passing bp
MP_1_2ES2_S25_L001	99.6%	82.7%
MP_1_4ES2_S25_L001	99.2%	83.5%
MP_1_5ES2_S25_L001	99.5%	81.6%
MP_1_7ES2_S25_L001	99.3%	81.0%
MP_1_9ES2_S25_L001	99.4%	79.5%
MP_1_10ES2_S25_L001	99.4%	78.3%
MP_1_11ES2_S25_L001	99.4%	76.8%
MP_1_12ES2_S25_L001	99.4%	77.3%
MP_1_13ES2_S25_L001	99.3%	77.7%
MP_1_14ES2_S25_L001	99.4%	77.8%
MP_1_15ES2_S25_L001	99.5%	77.0%
MP_1_16ES2_S25_L001	99.3%	77.3%
MP_1_18ES2_S25_L001	99.5%	76.4%
MP_1_19ES2_S25_L001	98.9%	76.6%
MP_1_20ES2_S25_L001	99.3%	77.6%
MP_2_1ES2_S25_L001	99.5%	82.2%
MP_2_2ES2_S25_L001	99.3%	77.2%
MP_2_3ES2_S25_L001	99.4%	78.9%
MP_2_4ES2_S25_L001	99.4%	80.8%
MP_2_5ES2_S25_L001	99.6%	80.7%
MP_2_6ES2_S25_L001	99.5%	82.7%
MP_2_7ES2_S25_L001	99.4%	81.7%
MP_2_8ES2_S25_L001	99.5%	84.8%
MP_2_9ES2_S25_L001	99.4%	78.6%
MP_2_10ES2_S25_L001	99.4%	82.2%
MP_2_11ES2_S25_L001	99.5%	84.5%
MP_2_12ES2_S25_L001	99.5%	81.8%
MP_2_13ES2_S25_L001	99.7%	82.5%
MP_2_14ES2_S25_L001	99.5%	79.0%
MP_2_15ES2_S25_L001	99.5%	81.0%
MP_3_7ES2_S25_L001	99.5%	83.3%
MP_4_2ES2_S25_L001	99.6%	76.5%
MP_4_3ES2_S25_L001	99.4%	77.0%
MP_4_4ES2_S25_L001	99.6%	77.8%
MP_4_5ES2_S25_L001	99.5%	76.7%
MP_4_6ES2_S25_L001	99.6%	78.4%
MP_4_7ES2_S25_L001	99.6%	76.7%
MP_4_8ES2_S25_L001	99.4%	76.7%
MP_4_9ES2_S25_L001	99.5%	76.6%
MP_4_12ES2_S25_L001	99.5%	77.0%
MP_4_13ES2_S25_L001	99.6%	78.5%
MP_4_14ES2_S25_L001	99.4%	77.0%
MP_4_15ES2_S25_L001	99.5%	77.0%
MP_5_1ES2_S25_L001	99.0%	77.5%
MP_5_2ES2_S25_L001	99.7%	76.4%
MP_5_3ES2_S26_L001	99.4%	77.4%
MP_5_4ES2_S26_L001	99.4%	76.6%
MP_5_5ES2_S26_L001	99.5%	76.8%
MP_5_6ES2_S26_L001	99.6%	76.5%
MP_5_8ES2_S26_L001	99.4%	76.4%
MP_5_9ES2_S26_L001	99.5%	76.3%
MP_5_10ES2_S26_L001	99.4%	76.6%
MP_5_13ES2_S26_L001	99.4%	76.9%
MP_5_16ES2_S26_L001	99.4%	76.9%
MP_5_17ES2_S26_L001	99.5%	77.2%
MP_5_19ES2_S26_L001	99.5%	76.8%
MP_5_20ES2_S26_L001	99.4%	76.7%
MP_5_23ES2_S26_L001	99.2%	76.6%
MP_5_24ES2_S26_L001	99.5%	79.3%
MP_6_2ES2_S26_L001	99.3%	76.1%
MP_6_3ES2_S26_L001	99.4%	76.2%
MP_6_4ES2_S26_L001	99.6%	76.7%
MP_6_5ES2_S26_L001	98.8%	77.1%
MP_6_6ES2_S26_L001	99.5%	76.9%
MP_6_7ES2_S26_L001	99.3%	77.0%
MP_6_9ES2_S26_L001	99.1%	84.5%
MP_7_1ES2_S26_L001	99.2%	78.6%
MP_7_2ES2_S26_L001	99.1%	77.9%
MP_7_3ES2_S26_L001	99.2%	77.7%
MP_7_4ES2_S26_L001	99.2%	76.6%
MP_7_5ES2_S26_L001	99.5%	79.0%
MP_7_8ES2_S26_L001	99.4%	76.6%
MP_7_9ES2_S26_L001	99.5%	77.8%
MP_7_10ES2_S26_L001	99.3%	76.9%
MP_7_11ES2_S26_L001	99.3%	77.2%
MP_7_12ES2_S26_L001	99.5%	76.6%
MP_7_13ES2_S26_L001	99.4%	78.1%
MP_7_15ES2_S26_L001	99.5%	76.6%
MP_7_17ES2_S26_L001	99.6%	76.4%
MP_7_24ES2_S26_L001	99.5%	78.2%
MP_7_25ES2_S26_L001	99.4%	80.3%
MP_C_2ES2_S25_L001	98.8%	79.4%
MP_C_3ES2_S25_L001	99.6%	89.8%
MP_C_4ES2_S25_L001	99.2%	76.1%
MP_C_5ES2_S25_L001	99.5%	76.3%
MP_8_1ES2_S26_L001	99.3%	77.1%
MP_8_2ES2_S26_L001	99.4%	78.5%
MP_8_3ES2_S26_L001	99.4%	77.7%
MP_8_4ES2_S26_L001	99.6%	77.4%
MP_8_7ES2_S26_L001	98.7%	84.5%
MP_8_9ES2_S26_L001	99.6%	76.5%
MP_8_10ES2_S26_L001	99.5%	78.1%
MP_8_11ES2_S26_L001	99.6%	76.4%
MP_8_15ES2_S26_L001	99.6%	76.5%
MP_8_16ES2_S26_L001	99.7%	76.6%
MP_8_17ES2_S26_L001	99.4%	76.5%
MP_8_18ES2_S26_L001	99.3%	77.6%
MP_8_22ES2_S26_L001	99.4%	77.7%
```

```
Running DADA2: Mon Nov  4 10:34:01 EST 2024
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_1_2ES2_S25_L001_R1_trimmed.fq.gz 95.6925
MP_1_4ES2_S25_L001_R1_trimmed.fq.gz 94.9602
MP_1_5ES2_S25_L001_R1_trimmed.fq.gz 95.5289
MP_1_7ES2_S25_L001_R1_trimmed.fq.gz 95.2713
MP_1_9ES2_S25_L001_R1_trimmed.fq.gz 95.1686
MP_1_10ES2_S25_L001_R1_trimmed.fq.gz 96.5551
MP_1_11ES2_S25_L001_R1_trimmed.fq.gz 96.2096
MP_1_12ES2_S25_L001_R1_trimmed.fq.gz 96.5391
MP_1_13ES2_S25_L001_R1_trimmed.fq.gz 96.1519
MP_1_14ES2_S25_L001_R1_trimmed.fq.gz 96.2972
MP_1_15ES2_S25_L001_R1_trimmed.fq.gz 96.9075
MP_1_16ES2_S25_L001_R1_trimmed.fq.gz 96.8478
MP_1_18ES2_S25_L001_R1_trimmed.fq.gz 96.844
MP_1_19ES2_S25_L001_R1_trimmed.fq.gz 96.7156
MP_1_20ES2_S25_L001_R1_trimmed.fq.gz 95.8291
MP_2_1ES2_S25_L001_R1_trimmed.fq.gz 95.5225
MP_2_2ES2_S25_L001_R1_trimmed.fq.gz 96.0025
MP_2_3ES2_S25_L001_R1_trimmed.fq.gz 95.7013
MP_2_4ES2_S25_L001_R1_trimmed.fq.gz 96.003
MP_2_5ES2_S25_L001_R1_trimmed.fq.gz 95.6849
MP_2_6ES2_S25_L001_R1_trimmed.fq.gz 95.524
MP_2_7ES2_S25_L001_R1_trimmed.fq.gz 95.8085
MP_2_8ES2_S25_L001_R1_trimmed.fq.gz 94.9052
MP_2_9ES2_S25_L001_R1_trimmed.fq.gz 95.5658
MP_2_10ES2_S25_L001_R1_trimmed.fq.gz 95.2607
MP_2_11ES2_S25_L001_R1_trimmed.fq.gz 95.0179
MP_2_12ES2_S25_L001_R1_trimmed.fq.gz 95.4866
MP_2_13ES2_S25_L001_R1_trimmed.fq.gz 95.6042
MP_2_14ES2_S25_L001_R1_trimmed.fq.gz 96.1504
MP_2_15ES2_S25_L001_R1_trimmed.fq.gz 95.8152
MP_3_7ES2_S25_L001_R1_trimmed.fq.gz 94.9807
MP_4_2ES2_S25_L001_R1_trimmed.fq.gz 96.9346
MP_4_3ES2_S25_L001_R1_trimmed.fq.gz 96.1482
MP_4_4ES2_S25_L001_R1_trimmed.fq.gz 96.5321
MP_4_5ES2_S25_L001_R1_trimmed.fq.gz 96.2392
MP_4_6ES2_S25_L001_R1_trimmed.fq.gz 96.9844
MP_4_7ES2_S25_L001_R1_trimmed.fq.gz 97.192
MP_4_8ES2_S25_L001_R1_trimmed.fq.gz 96.83
MP_4_9ES2_S25_L001_R1_trimmed.fq.gz 96.9987
MP_4_12ES2_S25_L001_R1_trimmed.fq.gz 97.322
MP_4_13ES2_S25_L001_R1_trimmed.fq.gz 96.3232
MP_4_14ES2_S25_L001_R1_trimmed.fq.gz 96.1524
MP_4_15ES2_S25_L001_R1_trimmed.fq.gz 96.6063
MP_5_1ES2_S25_L001_R1_trimmed.fq.gz 96.6364
MP_5_2ES2_S25_L001_R1_trimmed.fq.gz 97.2778
MP_5_3ES2_S26_L001_R1_trimmed.fq.gz 96.4168
MP_5_4ES2_S26_L001_R1_trimmed.fq.gz 96.9042
MP_5_5ES2_S26_L001_R1_trimmed.fq.gz 96.8317
MP_5_6ES2_S26_L001_R1_trimmed.fq.gz 96.7775
MP_5_8ES2_S26_L001_R1_trimmed.fq.gz 96.4695
MP_5_9ES2_S26_L001_R1_trimmed.fq.gz 96.5429
MP_5_10ES2_S26_L001_R1_trimmed.fq.gz 96.49
MP_5_13ES2_S26_L001_R1_trimmed.fq.gz 96.6814
MP_5_16ES2_S26_L001_R1_trimmed.fq.gz 96.5425
MP_5_17ES2_S26_L001_R1_trimmed.fq.gz 96.6776
MP_5_19ES2_S26_L001_R1_trimmed.fq.gz 96.4242
MP_5_20ES2_S26_L001_R1_trimmed.fq.gz 96.5082
MP_5_23ES2_S26_L001_R1_trimmed.fq.gz 96.8004
MP_5_24ES2_S26_L001_R1_trimmed.fq.gz 95.7137
MP_6_2ES2_S26_L001_R1_trimmed.fq.gz 96.2568
MP_6_3ES2_S26_L001_R1_trimmed.fq.gz 96.5431
MP_6_4ES2_S26_L001_R1_trimmed.fq.gz 97.2228
MP_6_5ES2_S26_L001_R1_trimmed.fq.gz 96.5302
MP_6_6ES2_S26_L001_R1_trimmed.fq.gz 96.7827
MP_6_7ES2_S26_L001_R1_trimmed.fq.gz 96.4464
MP_6_9ES2_S26_L001_R1_trimmed.fq.gz 94.0092
MP_7_1ES2_S26_L001_R1_trimmed.fq.gz 96.1593
MP_7_2ES2_S26_L001_R1_trimmed.fq.gz 95.5325
MP_7_3ES2_S26_L001_R1_trimmed.fq.gz 95.5963
MP_7_4ES2_S26_L001_R1_trimmed.fq.gz 96.8434
MP_7_5ES2_S26_L001_R1_trimmed.fq.gz 96.0887
MP_7_8ES2_S26_L001_R1_trimmed.fq.gz 96.7489
MP_7_9ES2_S26_L001_R1_trimmed.fq.gz 96.6186
MP_7_10ES2_S26_L001_R1_trimmed.fq.gz 95.9956
MP_7_11ES2_S26_L001_R1_trimmed.fq.gz 96.1827
MP_7_12ES2_S26_L001_R1_trimmed.fq.gz 96.6008
MP_7_13ES2_S26_L001_R1_trimmed.fq.gz 96.6909
MP_7_15ES2_S26_L001_R1_trimmed.fq.gz 96.4345
MP_7_17ES2_S26_L001_R1_trimmed.fq.gz 97.1196
MP_7_24ES2_S26_L001_R1_trimmed.fq.gz 96.3848
MP_7_25ES2_S26_L001_R1_trimmed.fq.gz 95.9307
MP_C_2ES2_S25_L001_R1_trimmed.fq.gz 95.7142
MP_C_3ES2_S25_L001_R1_trimmed.fq.gz 93.5174
MP_C_4ES2_S25_L001_R1_trimmed.fq.gz 96.3586
MP_C_5ES2_S25_L001_R1_trimmed.fq.gz 96.3283
MP_8_1ES2_S26_L001_R1_trimmed.fq.gz 96.0976
MP_8_2ES2_S26_L001_R1_trimmed.fq.gz 96.3825
MP_8_3ES2_S26_L001_R1_trimmed.fq.gz 95.7172
MP_8_4ES2_S26_L001_R1_trimmed.fq.gz 96.8659
MP_8_7ES2_S26_L001_R1_trimmed.fq.gz 88.252
MP_8_9ES2_S26_L001_R1_trimmed.fq.gz 97.3666
MP_8_10ES2_S26_L001_R1_trimmed.fq.gz 96.4904
MP_8_11ES2_S26_L001_R1_trimmed.fq.gz 96.8591
MP_8_15ES2_S26_L001_R1_trimmed.fq.gz 96.8779
MP_8_16ES2_S26_L001_R1_trimmed.fq.gz 97.1988
MP_8_17ES2_S26_L001_R1_trimmed.fq.gz 96.4484
MP_8_18ES2_S26_L001_R1_trimmed.fq.gz 95.6261
MP_8_22ES2_S26_L001_R1_trimmed.fq.gz 96.2765
```

```

FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_1_2ES2_S25_L001 88.2
MP_1_4ES2_S25_L001 87.7
MP_1_5ES2_S25_L001 84.6
MP_1_7ES2_S25_L001 88.7
MP_1_9ES2_S25_L001 90
MP_1_10ES2_S25_L001 89
MP_1_11ES2_S25_L001 86.6
MP_1_12ES2_S25_L001 89.4
MP_1_13ES2_S25_L001 90.4
MP_1_14ES2_S25_L001 90.3
MP_1_15ES2_S25_L001 89.8
MP_1_16ES2_S25_L001 89
MP_1_18ES2_S25_L001 93.3
MP_1_19ES2_S25_L001 90.4
MP_1_20ES2_S25_L001 90.7
MP_2_1ES2_S25_L001 89.7
MP_2_2ES2_S25_L001 90.7
MP_2_3ES2_S25_L001 91.8
MP_2_4ES2_S25_L001 89.7
MP_2_5ES2_S25_L001 90
MP_2_6ES2_S25_L001 89.8
MP_2_7ES2_S25_L001 88.8
MP_2_8ES2_S25_L001 88
MP_2_9ES2_S25_L001 85.5
MP_2_10ES2_S25_L001 87.4
MP_2_11ES2_S25_L001 86.5
MP_2_12ES2_S25_L001 84.6
MP_2_13ES2_S25_L001 87.1
MP_2_14ES2_S25_L001 89.1
MP_2_15ES2_S25_L001 88.7
MP_3_7ES2_S25_L001 89.6
MP_4_2ES2_S25_L001 93.1
MP_4_3ES2_S25_L001 88.3
MP_4_4ES2_S25_L001 89.1
MP_4_5ES2_S25_L001 89.9
MP_4_6ES2_S25_L001 87.7
MP_4_7ES2_S25_L001 89.8
MP_4_8ES2_S25_L001 90.6
MP_4_9ES2_S25_L001 90.3
MP_4_12ES2_S25_L001 89.4
MP_4_13ES2_S25_L001 92.4
MP_4_14ES2_S25_L001 91
MP_4_15ES2_S25_L001 90.6
MP_5_1ES2_S25_L001 87.8
MP_5_2ES2_S25_L001 93.6
MP_5_3ES2_S26_L001 88.5
MP_5_4ES2_S26_L001 87.2
MP_5_5ES2_S26_L001 90
MP_5_6ES2_S26_L001 90.9
MP_5_8ES2_S26_L001 88.9
MP_5_9ES2_S26_L001 87.9
MP_5_10ES2_S26_L001 90.1
MP_5_13ES2_S26_L001 89.5
MP_5_16ES2_S26_L001 90.1
MP_5_17ES2_S26_L001 91.5
MP_5_19ES2_S26_L001 90.6
MP_5_20ES2_S26_L001 89.4
MP_5_23ES2_S26_L001 89.4
MP_5_24ES2_S26_L001 89.2
MP_6_2ES2_S26_L001 91.3
MP_6_3ES2_S26_L001 90
MP_6_4ES2_S26_L001 90
MP_6_5ES2_S26_L001 90.8
MP_6_6ES2_S26_L001 91
MP_6_7ES2_S26_L001 91.2
MP_6_9ES2_S26_L001 82.1
MP_7_1ES2_S26_L001 91.1
MP_7_2ES2_S26_L001 89.8
MP_7_3ES2_S26_L001 88.6
MP_7_4ES2_S26_L001 90.9
MP_7_5ES2_S26_L001 92.4
MP_7_8ES2_S26_L001 31.8
MP_7_9ES2_S26_L001 92.3
MP_7_10ES2_S26_L001 89.1
MP_7_11ES2_S26_L001 89.8
MP_7_12ES2_S26_L001 93.3
MP_7_13ES2_S26_L001 89.6
MP_7_15ES2_S26_L001 91.5
MP_7_17ES2_S26_L001 94.1
MP_7_24ES2_S26_L001 91.9
MP_7_25ES2_S26_L001 71.8
MP_C_2ES2_S25_L001 91.3
MP_C_3ES2_S25_L001 90.2
MP_C_4ES2_S25_L001 89.6
MP_C_5ES2_S25_L001 91.9
MP_8_1ES2_S26_L001 81.4
MP_8_2ES2_S26_L001 91.5
MP_8_3ES2_S26_L001 77.6
MP_8_4ES2_S26_L001 90.9
MP_8_7ES2_S26_L001 77.9
MP_8_9ES2_S26_L001 92.1
MP_8_10ES2_S26_L001 71
MP_8_11ES2_S26_L001 94.4
MP_8_15ES2_S26_L001 91.1
MP_8_16ES2_S26_L001 94.6
MP_8_17ES2_S26_L001 86.2
MP_8_18ES2_S26_L001 90.9
MP_8_22ES2_S26_L001 86.7
```

## 11/4-11/6/2024

- started sorting through expedition data
- tried using `decontam` to remove ASVs that were detected in negative controls from whole dataset but kept running into issues
	- it would detect some ASVs at low abundance in the neg controls (<100 reads) and high abund in samples (>100,000) and remove them from the entire dataset. These were common species like menhaden, which are clearly real in the samples
	- It wasn't picking up on some high read abundance ASVs in the neg control samples like human reads.
	- Code below is deleted notes from my R plotting script:

```
Use `decontam` to remove contaminants from samples based on controls. Following vignette [here](https://benjjneb.github.io/decontam/vignettes/decontam_intro.html)

Check read abundances of controls 

df <- as.data.frame(sample_data(phylo_2024_exp)) # Put sample_data into a ggplot-friendly data.frame
df$LibrarySize <- sample_sums(phylo_2024_exp)
df <- df[order(df$LibrarySize),]
df$Index <- seq(nrow(df))
ggplot(data=df, aes(x=Index, y=LibrarySize, color=controls)) + geom_point()

Identify contaminants by prevalence

sample_data(phylo_2024_exp)$is.neg <- sample_data(phylo_2024_exp)$controls == "negative"
sample_data(phylo_2024_exp)$is.neg[is.na(sample_data(phylo_2024_exp)$is.neg)] <- FALSE

contamdf.prev <- isContaminant(phylo_2024_exp, method="prevalence", neg="is.neg", threshold=0.3)

contamdf.prev
table(contamdf.prev$contaminant)
#rownames(contamdf.prev[which(contamdf.prev$contaminant),])
tax_table(phylo_2024_exp)[rownames(contamdf.prev[which(contamdf.prev$contaminant),])]
```


- Next I manually started removing ASVs that were prokaryotes and human, dog. etc.
	
- I also used set min thresholds based on tropicals signal from controls in other samples BUT be cautious....
	- this minimum means that low-abundance interesting things can get cut out including HUMPBACK WHALE, detected in sample 5_16 (the inlet!), with ~750 read (also at very low abundance in some other samples with 3-5 reads but I am not sure if this is carryover)
	- Also don't blindly remove all mammals- keep marine mammals
- Used package `metagMisc` to remove instances of read abundances <500 reads. This was a good compromise between removing some of the "Cross-talk" between samples and not removing the low abundance/ interesting things. See closer analysis in [MiFish-plots.Rmd](MiFish-plots.Rmd)



###  11/11 Notes from Discussion with Libby and Natalia

To get feedback on initial expedition bubble plots

- check on butterflyfish from pos controls
	- Natalia will reach out to Katie from marine station and Chris Paparo
- check tilefish- weird. if it's near the marina makes more sense because this is commercial but this is an open water and very deep species. Even near the inlet this is weird
  - Confirmed this is from St. 19 Shagawong, near the marina- probably from the restaurants!!!!
- check annotation of menhaden- how closely related are the species? it's weird we are getting this Gulf species
- Check driftfishes (Nomeidae)
	- are these just misannotation of Scombriformes? Check blast hits.
	- Also butterfish are part of this family.
	- Check sequences more closely
	- *Feedback from Chris*: As for driftfish, it is probably barrelfish. They are super abundant in our bays (I took this video https://vimeo.com/280021999?share=copy) and they are SUPER slimy so I bet they shed a lot of edna.
- Put Sci name on one axis of these plots- then alphabetize by sci name so the groupings are together (eg. Scombriformes family and Scombridae will be next to each other)


11/12/24- Got update on positive control species

**Positive controls known in tank:**

- Short big eye *Pristigenys alta*
- Dotterel filefish *Aluterus heudelotii*
- Bandtail puffer *Sphoeroides spengleri*
- Lookdown *Selene vomer* 
- Spotfin butterflyfish *Chaetodon ocellatus*
- Banded butterflyfish *Chaetodon striatus*
- Blue angelfish *Holacanthus bermudensis*

*Recently in tank but not at the time of sampling*

- Orange filefish *Aluterus schoepfii*
- Glasseye snapper (possibly) *Pristigenys serrula*



**What was detected:**

- Dotterel filefish *Aluterus heudelotii*
- Menhaden *Brevoortia gunteri*, contamination probably due to this being filled with bay water.....
- Spotfin butterflyfish *Chaetodon ocellatus*
- Banded butterflyfish *Chaetodon striatus*
- Bandtail puffer *Sphoeroides spengleri*

So we detected 4 of the 7 present species



## Elas02
11/13/24

We received raw data form Elas02 run yesterday. Start running REVAMP

- Updated config files. Only minor changes compared to MiFish config files:
	- primer sequence and DADA2 trimming parameters
	- in sample_data-
		- changed mifish positive controls to negative controls (because there are no elasmobranchs in the tank). So there are two types of negative controls- tank water and ddH2O
		- updated sample names. some minor differences life S2 instead of S1 and different underscores

	
Remove suffix from fastq files: `for file in *; do mv "${file}" "${file/_001/}"; done`

Remove prefix from file names (if re-running after mistake): `for file in * ; do mv -v "$file" "${file#*_}"; done`

Run REVAMP

```
conda activate REVAMPenv

revamp.sh -p 01_config_file_Elas02-2024-expedition.txt -f 02_figure_config_file_Elas02-2024-expedition.txt -s 03_sample_metadata_Elas02-2024-expedition.txt -r raw_data/2024-Elas02-expedition -o results-revamp-2024-Elas02-expedition
```

~Pasting output~

```
Running Cutadapt: Wed Nov 13 14:42:13 EST 2024
Finished Cutadapt: Wed Nov 13 15:02:25 EST 2024
Sample	Passing Reads	Passing bp
MP_1_2_ES_S1_L002	85.9%	68.0%
MP_1_4_ES_S1_L002	89.0%	70.3%
MP_1_5_ES_S1_L002	78.4%	70.3%
MP_1_7_ES_S1_L002	89.8%	70.7%
MP_1_9_ES_S1_L002	97.8%	76.7%
MP_1_10_ES_S1_L002	97.4%	76.2%
MP_1_11_ES_S1_L002	97.2%	76.1%
MP_1_12_ES_S1_L002	97.7%	76.6%
MP_1_13_ES_S1_L002	98.2%	77.3%
MP_1_14_ES_S1_L002	92.3%	71.9%
MP_1_15_ES_S1_L002	96.6%	76.4%
MP_1_16_ES_S1_L002	92.0%	71.6%
MP_1_18_ES_S1_L002	93.3%	72.8%
MP_1_19_ES_S1_L002	97.5%	76.5%
MP_1_20_ES_S1_L002	94.2%	73.5%
MP_2_1_ES_S1_L002	82.1%	64.2%
MP_2_2_ES_S1_L002	80.6%	65.8%
MP_2_3_ES_S1_L002	94.5%	78.4%
MP_2_4_ES_S1_L002	93.9%	81.6%
MP_2_5_ES_S1_L002	32.7%	28.9%
MP_2_6_ES_S1_L002	84.9%	67.0%
MP_2_7_ES_S1_L002	53.5%	40.2%
MP_2_8_ES_S1_L002	92.0%	82.9%
MP_2_9_ES_S1_L002	76.8%	66.3%
MP_2_10_ES_S1_L002	54.9%	48.9%
MP_2_11_ES_S1_L002	93.2%	72.3%
MP_2_12_ES_S1_L002	14.5%	12.2%
MP_2_13_ES_S1_L002	93.1%	82.4%
MP_2_14_ES_S1_L002	97.9%	77.1%
MP_2_15_ES_S1_L002	69.8%	59.4%
MP_3_7_ES_S1_L002	90.9%	78.3%
MP_4_2_ES_S1_L002	97.9%	76.6%
MP_4_3_ES_S1_L002	98.1%	76.8%
MP_4_4_ES_S1_L002	94.5%	74.7%
MP_4_5_ES_S1_L002	88.1%	69.4%
MP_4_6_ES_S1_L002	88.0%	67.0%
MP_4_7_ES_S1_L002	97.9%	76.7%
MP_4_8_ES_S1_L002	98.0%	76.8%
MP_4_9_ES_S1_L002	97.6%	82.8%
MP_4_12_ES_S1_L002	96.5%	75.5%
MP_4_13_ES_S1_L002	96.6%	75.5%
MP_4_14_ES_S1_L002	83.4%	68.0%
MP_4_15_ES_S1_L002	97.5%	76.3%
MP_5_1_ES_S1_L002	82.1%	69.4%
MP_5_2_ES_S1_L002	55.2%	43.0%
MP_5_3_ES_S1_L002	76.3%	57.7%
MP_5_4_ES_S1_L002	95.8%	80.1%
MP_5_5_ES_S1_L002	47.3%	35.9%
MP_5_6_ES_S1_L002	17.7%	13.5%
MP_5_8_ES_S1_L002	95.4%	74.2%
MP_5_9_ES_S1_L002	85.0%	65.9%
MP_5_10_ES_S1_L002	92.7%	72.1%
MP_5_13_ES_S1_L002	94.5%	73.8%
MP_5_16_ES_S1_L002	96.3%	75.4%
MP_5_17_ES_S1_L002	98.6%	77.1%
MP_5_19_ES_S1_L002	97.3%	75.9%
MP_5_20_ES_S1_L002	96.1%	75.1%
MP_5_23_ES_S1_L002	89.0%	69.1%
MP_5_24_ES_S1_L002	89.2%	69.9%
MP_6_2_ES_S1_L002	93.6%	73.0%
MP_6_3_ES_S1_L002	54.6%	44.1%
MP_6_4_ES_S1_L002	98.2%	76.8%
MP_6_5_ES_S1_L002	88.2%	68.6%
MP_6_6_ES_S1_L002	81.2%	62.2%
MP_6_7_ES_S1_L002	45.3%	34.1%
MP_6_9_ES_S1_L002	83.6%	73.5%
MP_7_1_ES_S1_L002	85.0%	66.1%
MP_7_2_ES_S1_L002	81.5%	63.6%
MP_7_3_ES_S1_L002	94.0%	74.0%
MP_7_4_ES_S1_L002	96.3%	75.3%
MP_7_5_ES_S1_L002	97.1%	75.9%
MP_7_8_ES_S1_L002	89.0%	69.4%
MP_7_9_ES_S1_L002	90.3%	77.8%
MP_7_10_ES_S1_L002	6.2%	5.2%
MP_7_11_ES_S1_L002	23.1%	19.8%
MP_7_12_ES_S1_L002	96.0%	73.8%
MP_7_13_ES_S1_L002	80.1%	65.4%
MP_7_15_ES_S1_L002	22.1%	18.7%
MP_7_17_ES_S1_L002	97.0%	74.9%
MP_7_24_ES_S1_L002	76.0%	58.7%
MP_7_25_ES_S1_L002	36.4%	32.1%
MP_C_2_ES_S1_L002	94.3%	72.6%
MP_C_3_ES_S1_L002	82.2%	62.5%
MP_C_4_ES_S1_L002	72.7%	54.3%
MP_C_5_ES_S1_L002	89.0%	67.6%
MP_8_1_ES_S1_L002	94.8%	74.0%
MP_8_2_ES_S1_L002	98.3%	76.8%
MP_8_3_ES_S1_L002	94.5%	74.7%
MP_8_4_ES_S1_L002	94.1%	75.9%
MP_8_7_ES_S1_L002	98.2%	76.8%
MP_8_9_ES_S1_L002	16.2%	13.3%
MP_8_10_ES_S1_L002	97.0%	75.7%
MP_8_11_ES_S1_L002	11.9%	10.2%
MP_8_15_ES_S1_L002	64.5%	21.9%
MP_8_16_ES_S1_L002	98.4%	77.0%
MP_8_17_ES_S1_L002	98.9%	77.2%
MP_8_18_ES_S1_L002	96.7%	75.6%
MP_8_22_ES_S1_L002	89.3%	68.5%
```

Mostly 60-80% retained with some much lower than that. This is not as good as the MiFish but that is expected since this is a much more narrow taxonomic group.

```
Running DADA2: Wed Nov 13 15:03:54 EST 2024
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_1_2_ES_S1_L002_R1_trimmed.fq.gz 96.5953
MP_1_4_ES_S1_L002_R1_trimmed.fq.gz 96.6881
MP_1_5_ES_S1_L002_R1_trimmed.fq.gz 95.242
MP_1_7_ES_S1_L002_R1_trimmed.fq.gz 96.5855
MP_1_9_ES_S1_L002_R1_trimmed.fq.gz 97.0262
MP_1_10_ES_S1_L002_R1_trimmed.fq.gz 97.4295
MP_1_11_ES_S1_L002_R1_trimmed.fq.gz 97.118
MP_1_12_ES_S1_L002_R1_trimmed.fq.gz 94.2316
MP_1_13_ES_S1_L002_R1_trimmed.fq.gz 95.4641
MP_1_14_ES_S1_L002_R1_trimmed.fq.gz 97.5602
MP_1_15_ES_S1_L002_R1_trimmed.fq.gz 96.3874
MP_1_16_ES_S1_L002_R1_trimmed.fq.gz 96.9346
MP_1_18_ES_S1_L002_R1_trimmed.fq.gz 97.5781
MP_1_19_ES_S1_L002_R1_trimmed.fq.gz 80.4747
MP_1_20_ES_S1_L002_R1_trimmed.fq.gz 97.2321
MP_2_1_ES_S1_L002_R1_trimmed.fq.gz 83.2152
MP_2_2_ES_S1_L002_R1_trimmed.fq.gz 79.5119
MP_2_3_ES_S1_L002_R1_trimmed.fq.gz 94.7815
MP_2_4_ES_S1_L002_R1_trimmed.fq.gz 71.9702
MP_2_5_ES_S1_L002_R1_trimmed.fq.gz 91.6858
MP_2_6_ES_S1_L002_R1_trimmed.fq.gz 96.4712
MP_2_7_ES_S1_L002_R1_trimmed.fq.gz 11.0574
MP_2_8_ES_S1_L002_R1_trimmed.fq.gz 95.7581
MP_2_9_ES_S1_L002_R1_trimmed.fq.gz 71.9937
MP_2_10_ES_S1_L002_R1_trimmed.fq.gz 93.4275
MP_2_11_ES_S1_L002_R1_trimmed.fq.gz 16.2878
MP_2_12_ES_S1_L002_R1_trimmed.fq.gz 78.0172
MP_2_13_ES_S1_L002_R1_trimmed.fq.gz 82.7819
MP_2_14_ES_S1_L002_R1_trimmed.fq.gz 97.3254
MP_2_15_ES_S1_L002_R1_trimmed.fq.gz 64.7008
MP_3_7_ES_S1_L002_R1_trimmed.fq.gz 67.2618
MP_4_2_ES_S1_L002_R1_trimmed.fq.gz 96.6825
MP_4_3_ES_S1_L002_R1_trimmed.fq.gz 96.6654
MP_4_4_ES_S1_L002_R1_trimmed.fq.gz 96.9714
MP_4_5_ES_S1_L002_R1_trimmed.fq.gz 97.2812
MP_4_6_ES_S1_L002_R1_trimmed.fq.gz 4.3227
MP_4_7_ES_S1_L002_R1_trimmed.fq.gz 96.0309
MP_4_8_ES_S1_L002_R1_trimmed.fq.gz 97.0891
MP_4_9_ES_S1_L002_R1_trimmed.fq.gz 95.9777
MP_4_12_ES_S1_L002_R1_trimmed.fq.gz 97.2585
MP_4_13_ES_S1_L002_R1_trimmed.fq.gz 96.8571
MP_4_14_ES_S1_L002_R1_trimmed.fq.gz 29.8567
MP_4_15_ES_S1_L002_R1_trimmed.fq.gz 96.6485
MP_5_1_ES_S1_L002_R1_trimmed.fq.gz 96.087
MP_5_2_ES_S1_L002_R1_trimmed.fq.gz 96.3366
MP_5_3_ES_S1_L002_R1_trimmed.fq.gz 6.53319
MP_5_4_ES_S1_L002_R1_trimmed.fq.gz 88.5074
MP_5_5_ES_S1_L002_R1_trimmed.fq.gz 51.1443
MP_5_6_ES_S1_L002_R1_trimmed.fq.gz 45.7419
MP_5_8_ES_S1_L002_R1_trimmed.fq.gz 97.4511
MP_5_9_ES_S1_L002_R1_trimmed.fq.gz 97.7529
MP_5_10_ES_S1_L002_R1_trimmed.fq.gz 97.6533
MP_5_13_ES_S1_L002_R1_trimmed.fq.gz 96.962
MP_5_16_ES_S1_L002_R1_trimmed.fq.gz 96.1603
MP_5_17_ES_S1_L002_R1_trimmed.fq.gz 96.5283
MP_5_19_ES_S1_L002_R1_trimmed.fq.gz 97.7926
MP_5_20_ES_S1_L002_R1_trimmed.fq.gz 97.0706
MP_5_23_ES_S1_L002_R1_trimmed.fq.gz 97.6988
MP_5_24_ES_S1_L002_R1_trimmed.fq.gz 97.1075
MP_6_2_ES_S1_L002_R1_trimmed.fq.gz 97.039
MP_6_3_ES_S1_L002_R1_trimmed.fq.gz 50.076
MP_6_4_ES_S1_L002_R1_trimmed.fq.gz 96.9521
MP_6_5_ES_S1_L002_R1_trimmed.fq.gz 97.8629
MP_6_6_ES_S1_L002_R1_trimmed.fq.gz 7.27997
MP_6_7_ES_S1_L002_R1_trimmed.fq.gz 17.7325
MP_6_9_ES_S1_L002_R1_trimmed.fq.gz 80.8926
MP_7_1_ES_S1_L002_R1_trimmed.fq.gz 97.3596
MP_7_2_ES_S1_L002_R1_trimmed.fq.gz 96.8575
MP_7_3_ES_S1_L002_R1_trimmed.fq.gz 94.5656
MP_7_4_ES_S1_L002_R1_trimmed.fq.gz 97.1804
MP_7_5_ES_S1_L002_R1_trimmed.fq.gz 97.3795
MP_7_8_ES_S1_L002_R1_trimmed.fq.gz 97.1688
MP_7_9_ES_S1_L002_R1_trimmed.fq.gz 67.6427
MP_7_10_ES_S1_L002_R1_trimmed.fq.gz 68.279
MP_7_11_ES_S1_L002_R1_trimmed.fq.gz 86.9638
MP_7_12_ES_S1_L002_R1_trimmed.fq.gz 2.86433
MP_7_13_ES_S1_L002_R1_trimmed.fq.gz 31.2299
MP_7_15_ES_S1_L002_R1_trimmed.fq.gz 70.3532
MP_7_17_ES_S1_L002_R1_trimmed.fq.gz 3.39002
MP_7_24_ES_S1_L002_R1_trimmed.fq.gz 12.1081
MP_7_25_ES_S1_L002_R1_trimmed.fq.gz 90.9853
MP_C_2_ES_S1_L002_R1_trimmed.fq.gz 4.18268
MP_C_3_ES_S1_L002_R1_trimmed.fq.gz 3.65234
MP_C_4_ES_S1_L002_R1_trimmed.fq.gz 4.78178
MP_C_5_ES_S1_L002_R1_trimmed.fq.gz 3.75302
MP_8_1_ES_S1_L002_R1_trimmed.fq.gz 95.9763
MP_8_2_ES_S1_L002_R1_trimmed.fq.gz 97.737
MP_8_3_ES_S1_L002_R1_trimmed.fq.gz 93.0576
MP_8_4_ES_S1_L002_R1_trimmed.fq.gz 96.7916
MP_8_7_ES_S1_L002_R1_trimmed.fq.gz 97.3135
MP_8_9_ES_S1_L002_R1_trimmed.fq.gz 76.0219
MP_8_10_ES_S1_L002_R1_trimmed.fq.gz 97.7193
MP_8_11_ES_S1_L002_R1_trimmed.fq.gz 84.0096
MP_8_15_ES_S1_L002_R1_trimmed.fq.gz 12.42
MP_8_16_ES_S1_L002_R1_trimmed.fq.gz 96.8568
MP_8_17_ES_S1_L002_R1_trimmed.fq.gz 96.5491
MP_8_18_ES_S1_L002_R1_trimmed.fq.gz 97.0082
MP_8_22_ES_S1_L002_R1_trimmed.fq.gz 4.71789


```


```

FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_1_2_ES_S1_L002 91.6
MP_1_4_ES_S1_L002 92.4
MP_1_5_ES_S1_L002 87.5
MP_1_7_ES_S1_L002 91.9
MP_1_9_ES_S1_L002 93.2
MP_1_10_ES_S1_L002 91.8
MP_1_11_ES_S1_L002 92.9
MP_1_12_ES_S1_L002 90.5
MP_1_13_ES_S1_L002 90.3
MP_1_14_ES_S1_L002 92.3
MP_1_15_ES_S1_L002 90.9
MP_1_16_ES_S1_L002 93
MP_1_18_ES_S1_L002 92.9
MP_1_19_ES_S1_L002 76.3
MP_1_20_ES_S1_L002 91.7
MP_2_1_ES_S1_L002 79.3
MP_2_2_ES_S1_L002 75.3
MP_2_3_ES_S1_L002 90.7
MP_2_4_ES_S1_L002 66.9
MP_2_5_ES_S1_L002 82
MP_2_6_ES_S1_L002 92.4
MP_2_7_ES_S1_L002 9
MP_2_8_ES_S1_L002 90.8
MP_2_9_ES_S1_L002 67.4
MP_2_10_ES_S1_L002 84
MP_2_11_ES_S1_L002 15.1
MP_2_12_ES_S1_L002 50.9
MP_2_13_ES_S1_L002 78.2
MP_2_14_ES_S1_L002 92.4
MP_2_15_ES_S1_L002 58.6
MP_3_7_ES_S1_L002 60.6
MP_4_2_ES_S1_L002 93
MP_4_3_ES_S1_L002 91.7
MP_4_4_ES_S1_L002 93.3
MP_4_5_ES_S1_L002 91.8
MP_4_6_ES_S1_L002 3.9
MP_4_7_ES_S1_L002 91.3
MP_4_8_ES_S1_L002 92.2
MP_4_9_ES_S1_L002 92.4
MP_4_12_ES_S1_L002 91.4
MP_4_13_ES_S1_L002 88.4
MP_4_14_ES_S1_L002 27.5
MP_4_15_ES_S1_L002 93.3
MP_5_1_ES_S1_L002 88.3
MP_5_2_ES_S1_L002 91
MP_5_3_ES_S1_L002 4.9
MP_5_4_ES_S1_L002 84.8
MP_5_5_ES_S1_L002 45.4
MP_5_6_ES_S1_L002 40.1
MP_5_8_ES_S1_L002 92
MP_5_9_ES_S1_L002 67.2
MP_5_10_ES_S1_L002 91.9
MP_5_13_ES_S1_L002 92.8
MP_5_16_ES_S1_L002 92
MP_5_17_ES_S1_L002 92.5
MP_5_19_ES_S1_L002 93.5
MP_5_20_ES_S1_L002 92.7
MP_5_23_ES_S1_L002 92
MP_5_24_ES_S1_L002 92.3
MP_6_2_ES_S1_L002 93
MP_6_3_ES_S1_L002 47
MP_6_4_ES_S1_L002 93
MP_6_5_ES_S1_L002 93.1
MP_6_6_ES_S1_L002 6.4
MP_6_7_ES_S1_L002 13.7
MP_6_9_ES_S1_L002 78.2
MP_7_1_ES_S1_L002 91.5
MP_7_2_ES_S1_L002 91.3
MP_7_3_ES_S1_L002 89.7
MP_7_4_ES_S1_L002 91.7
MP_7_5_ES_S1_L002 92.6
MP_7_8_ES_S1_L002 93.7
MP_7_9_ES_S1_L002 63.9
MP_7_10_ES_S1_L002 58.4
MP_7_11_ES_S1_L002 76.2
MP_7_12_ES_S1_L002 2.7
MP_7_13_ES_S1_L002 29.5
MP_7_15_ES_S1_L002 65.3
MP_7_17_ES_S1_L002 3.1
MP_7_24_ES_S1_L002 11.7
MP_7_25_ES_S1_L002 81.5
MP_C_2_ES_S1_L002 4.1
MP_C_3_ES_S1_L002 3.1
MP_C_4_ES_S1_L002 4.2
MP_C_5_ES_S1_L002 3.4
MP_8_1_ES_S1_L002 89.2
MP_8_2_ES_S1_L002 92
MP_8_3_ES_S1_L002 89.4
MP_8_4_ES_S1_L002 93.4
MP_8_7_ES_S1_L002 93.8
MP_8_9_ES_S1_L002 51.1
MP_8_10_ES_S1_L002 93.3
MP_8_11_ES_S1_L002 35.6
MP_8_15_ES_S1_L002 9.2
MP_8_16_ES_S1_L002 93.9
MP_8_17_ES_S1_L002 92.9
MP_8_18_ES_S1_L002 92.3
MP_8_22_ES_S1_L002 3.9
```


## 11/18/2024
Primarily using output from REVAMP and working up figures in R notebooks. Some notes:

- Been correpsonding with Scot Dowd, Mr. DNA, on next sequencing library (see below). Due to these conversations, I've been reading [Wang et al. 2023](https://www.frontiersin.org/journals/ecology-and-evolution/articles/10.3389/fevo.2023.1164206/full) closely. They state:

```
The taxonomic discrimination ability of each different primer set was assessed by using the “ecotaxspecificity” command in the OBITools software package. Two taxa (species or genus) are considered as distinguishable if they have at least 2 nucleotide differences.
```


--> Think about this and the defintion of distinguishable for Menhaden and Mustelus species. I am consistently getting the Finescale menhaden rather than Atlantic; Also consistently seeing M. henlei and M. griseus at low abundance (Pacific species). How many bp different are these than the expected species? Do this analysis for the paper.

________

### Looking into new primer set for upper trophic levels:
Also, for my notes, email to IOCS group on 11/12/24

```
Liz Suter <lizzysuter@gmail.com>
Tue, Nov 12, 10:53 AM (6 days ago)
to Ellen, Christine, Elizabeth

Hi all,
After looking into this a little bit, these are the two additional primer sets I would recommend for sequencing for the expedition samples:
V16S-U from Wang et al, which amplifies 98% of all vertebrates in silico (including mammals, birds, reptiles, amphibians, and overlaps some with MiFIsh- some Actinopterygii and Chondrichthyes). These are designed to avoid non-specific amplification, and have been successfully applied in situ at least once. They seem to do better than other comparable primer sets like MarVer3.
mlCOIintF and jgHCO2198 from Leray et al., which target arthropods, cnidaria, bryozoans, annelids, and molluscs. These have been applied successively for detecting zooplankton prey of fish (one example but they seem to have been used widely at this point). 
If you could add a third library, I would add:
Euk1391F/ EukBr, the universal 18S primers originally from Amaral-Zettler, modified and validated by Stoeck et al. and used by the Earth microbiome project. These are mainly for detecting microalgae (dinoflagellates, diatoms) but also pick up some zooplankton.
Let me know what you think in terms of budget and Libby and I can coordinate with Mr DNA,
Liz
```

References:

- [VertU: universal multilocus primer sets for eDNA metabarcoding of vertebrate diversity, evaluated by both artificial and natural cases](https://www.frontiersin.org/journals/ecology-and-evolution/articles/10.3389/fevo.2023.1164206/full)
- [Novel universal primers for metabarcoding environmental DNA surveys of marine mammals and other marine vertebrates](https://onlinelibrary.wiley.com/doi/full/10.1002/edn3.72)
- [A new versatile primer set targeting a short fragment of the mitochondrial COI region for metabarcoding metazoan diversity: application for characterizing coral reef fish gut contents](https://frontiersinzoology.biomedcentral.com/articles/10.1186/1742-9994-10-34)
- [eDNA metabarcoding of small plankton samples to detect fish larvae and their preys from Atlantic and Pacific waters](https://www.nature.com/articles/s41598-021-86731-z)
- [A Method for Studying Protistan Diversity Using Massively Parallel Sequencing of V9 Hypervariable Regions of Small-Subunit Ribosomal RNA Genes](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0006372)
- [Multiple marker parallel tag environmental DNA sequencing reveals a highly complex eukaryotic community in marine anoxic water](https://onlinelibrary.wiley.com/doi/10.1111/j.1365-294X.2009.04480.x)
- [Earth microbiome project](https://earthmicrobiome.org/protocols-and-standards/18s/)

-----


And email correspondence with Scot/ Mr DNA and Libby about new primer set:

```
From: Elizabeth Salzman <elizabeth.salzman@stonybrook.edu>
Sent: Friday, November 15, 2024 2:24 PM
To: sdowd mrdnalab.com <sdowd@mrdnalab.com>
Cc: Liz Suter <lizzysuter@gmail.com>
Subject: Running new primers on sterivex samples
 
Hi Scot,

We want to expand our analysis to upper trophic levels and have investigated a few primer sets that target vertebrates broadly. We have identified two options: V16S-U from Wang et al. 2023, and MarVer3 from Valsecchi et al. 2020. V16S-U seems to be an improvement upon MarVer3, and so we would like to get a quote for a library from the 2024 ES2 samples (from Sterviexes) for this primer set. However, if you have an opinion as to which is better or experience with a different primer set out there, we are open to suggestions. Neither has been applied widely. Please let us know. 

Thanks,
Libby 


```

```
sdowd mrdnalab.com
Attachments
Fri, Nov 15, 3:49 PM (3 days ago)
to Elizabeth, me

Howdy Libby 😉  

okay sure ..  I cannot go into the literature to pull primer information (policy from getting the wrong primers back in the day) .. so can you pull the primer sequences , length of the amplicon and the cycling conditions (we will probably convert those cycling to our system as usual but it helps to have a place to start  with annealing) .. put them into text in body of a reply email (for ease I put the table from the paper to help) ..   sorry it is a bit of a silly thing to require the primers put into an email like that when we have them in the table 😉  but ...  it has saved us before .

did you want both the V16s  run and V12s  .. Although V12S-U and VCOI-U had some extent of amplification bias and non-specific amplification, they could detect a bulk of vertebrate species that were missed by V16S-U from our eDNA samples, showing good complementary ability

and remind me on how many samples we are talking about  (I think these are the ones we extracted recently? ) 

all easy from there .. as far as broad range that also hit vertebrates I always suggest something like the mlcoi in general as the databases are well done for those .. I dont recognize the ones above but with the primer sequence I can run it through our simulations real quick (database driven and literature summary) see what comes up with those ..   I am sure you know the mlcoi so probably not what you are wanting specifically to target vertebrates . 

but yeah excited to check out the new primers (always a joy) .. can get the quote together on Monday but let me know on the above few things 😉 

Scot

```
 
```

Liz Suter <lizzysuter@gmail.com>
10:57 AM (3 hours ago)
to sdowd, Elizabeth

Hi Scot,

Thank you for the reply-

We initially chose V16S-U over V1212S-U and VCOI-U because of the issues with nonspecific amplification in the paper. But if you feel that you could overcome those it would be worth exploring those as well. Could you run all 3 through your in silico analysis so we can see which is best for our specific regional species?

V12S-U 
Amplicon size: 208 
V12S-U-F: 5'- GTGCCAGCNRCCGCGGTYANAC -3'
V12S-U-R: 5'- ATAGTRGGGTATCTAATCCYAGT -3'

V16S-U 
Amplicon size: 253
V16S-U-F: 5'- ACGAGAAGACCCYRYGRARCTT -3'
V16S-U-R: 5'- TCTHRRANAGGATTGCGCTGTTA -3'

VCOI-U
Amplicon size: 212
VCOI-U-F: 5'- CAYGCHTTTGTNATRATYTTYTT -3'
VCOI-U-R: 5'- GGRGGRTADACDGTYCANCCNGT -3'

Cycling conditions for all 3 above:
30 s at 98°C 
40 cycles of 15 s at 98°C, 30 s at 50°C, 30 s at 72°C,
final extension of 10 min at 72°C


We did also consider the mlcoi primers from Leray et al. and we may actually ask for that library next, budget permitting. From my reading of Leray et al., this set does a great job with metazoans, and especially invertebrates, but I don't think they tested it on marine mammals, reptiles, amphibians, or birds specifically in that paper. Fig. 2 and Table 2 from Wang et al. suggests that the mlCOIintF/jgHCO2198 set are not as great at distinguishing taxa in these groups as their Vert-U sets. Still, if you have a quick way of doing an in silico analysis, we can see what comes out of it. Those primers would be:
mlCOIintF: 5'- GGWACWGGWTGAACWGTWTAYCCYCC -3'
jgHCO2198: 5'- TAIACYTCIGGRTGICCRAARAAYCA -3'
Amplicon size = 313bp
Leray et al. use a touchdown PCR: denaturation for 10s at 95°C, annealing for 30s at 62°C (−1°C per cycle) and extension for 60s at 72°C, followed by 25 cycles at 46°C annealing temperature


If you are thinking of a different COI primer set, please let us know and I will look into it as well.

And yes, all of the above applies to the samples that you extracted recently. I believe there are 98 samples (Libby can correct me on that if not).

Liz

```

```

sdowd mrdnalab.com
11:06 AM (3 hours ago)
to me, Elizabeth

noted .. appreciate the primer format in the email ..  perfect   I dont know anything other than what was in the paper suggesting that 12s and 16s complement which is somewhat expected due to the size unit differences across the taxa

I will have with my simulation some limitations related to the database content or it would run for weeks (just as we would when running classification analysis) ..  but they are all running now ..

so far we see that both the V12 and V16 are tricky on PCR but that is the same with miFISH .. the coi should not have problems (just as with mlcoi) 

I will know more by end of day.. it is somewhat subjective also .. just dont want to portrait it as "a know it all" haha

more soon
SCot
```