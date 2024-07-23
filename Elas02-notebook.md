---
title: "Analysis Pipeline for Elas02 amplicons from SHiRP Project"
output: html_notebook
---

Lab Notebook for REVAMP analysis of Elasmobranh-SHiRP amplicons.

Re-started Jun 2024 utilizing [REVAMP](https://github.com/McAllister-NOAA/REVAMP). Previously I was using my own pipeline with DADA2 and blast+ toolkit to blastn sequences (after quality filtering) and retaining top hits. Instead, I've switched to making a reference database using [rCRUX](https://github.com/CalCOFI/rCRUX) and the Elas02 primers. (See database repo). This method should be an improvement/ better approach based on 1) it utilizes a curated database specific to our primers and 2) it picks closest hits based on a phylogenetic analysis of the top 100 blastn hits

## Download REVAMP
```
cd ~/software/
git clone https://github.com/McAllister-NOAA/REVAMP.git
```


```
export PATH=~/software/REVAMP:$PATH
which revamp.sh
```

For me, adding `export PATH=~/software/REVAMP:$PATH` to my `.zshrc` file permanently added it to my path. Got there from Home (`cd ~`) then `sudo nano .zshrc` and added export line to bottome of file. (To list hidden files use `ls -a`). [This site](https://stackoverflow.com/questions/22465332/setting-path-environment-variable-in-osx-permanently) was helpful in figuring out path for my Mac.

## Install dependencies
Note- I already have NCBI nt database in `../databases/NCBI_blast_nt` up to `nt.146`and `blast+` tools (see databases workbook).

### Check blast+ version
```
blastn -version
```
blastn: 2.6.0+
May run into problem?- Documentation says it requires v2.13 but when I update I keep getting v 2.6


### Get taxonomy tools
```
cd ~/software/
mkdir taxonomy-tools/
cd taxonomy-tools/
wget https://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz
tar -zxvf taxdump.tar.gz
```


### Cutadapt and Krona
Re-download cutadapt following [documentation](https://cutadapt.readthedocs.io/en/stable/installation.html)


I was having errors because I had two versions of cutadapt and had installed them two different ways, using `pip` and `conda`. I uninstalled everything and installed into conda environment called `REVAMPenv`. However, the instructions from the cutadapt documentation didn't exactly work. I followed suggestions [here](https://www.biostars.org/p/9522705/). Then to activate environment, run `conda activate REVAMPenv`. Python 3.8 is the version compatible with cutadapt 3.7 (the version that is used by the developer of REVAMP). Similarly, REVAMP documentation says it uses Krona v.2.7.1 (search for bioconda package versions and click on "i" for more info on compatibility, etc. of the different versions)

```

conda create -n REVAMPenv python=3.8 
conda activate REVAMPenv

# install cutadapt 3.7
pip install cutadapt==3.7

# check installation with 
pip list
# or
cutadapt --version

# install krona 2.7.1
conda install -c bioconda krona=2.7.1

# check with 
conda list

```
To deactivate environment, `conda deactivate`

**EDIT 1, 7/8/24** later on having trouble with krona installation. Uninstalled using conda (in REVAMPenv) using `conda remove krona`.  Then install manually following [this](https://github.com/marbl/Krona/issues/46):

```
cd ~/software
curl -LOk https://github.com/marbl/Krona/releases/download/v2.7/KronaTools-2.7.tar
tar xvf KronaTools-2.7.tar
cd KronaTools-2.7
./install.pl
```

I think it worked:

```
Creating links...

Installation complete.

Run ./updateTaxonomy.sh to use scripts that rely on NCBI taxonomy:
   ktClassifyBLAST
   ktGetLCA
   ktGetTaxInfo
   ktImportBLAST
   ktImportTaxonomy
   ktImportMETAREP-BLAST

Run ./updateAccessions.sh to use scripts that get taxonomy IDs from accessions:
   ktClassifyBLAST
   ktGetTaxIDFromAcc
   ktImportBLAST

```

Then according to ducmentation, need to run updateTaxonomy.sh, from within KronaTool-2.7 folder:
```
./updateTaxonomy.sh

```

May need to run update accessions too but this is a much bigger file and will take long time. Wait for now:
./updateAccessions.sh 

### TaxonKit
Install [TaxonKit](https://bioinf.shenwei.me/taxonkit/download/). I searched for the v0.5.0 darwin 64-bit tar file and unzipped it into my software folder. Had to right-click/ force open the `taxonkit` unix file the first time bc it was from untrusted developer. Then it would run in terminal as long as `export PATH=~/software:$PATH` is in my `.zshrc` file.

```
taxonkit version
```
taxonkit v0.5.0


**EDIT** later on had a problem bc files after unzipping needed to be in certain place. See documentation from [taxonkit](https://bioinf.shenwei.me/taxonkit/usage/)

```
tar -zxvf taxdump.tar.gz

mkdir -p $HOME/.taxonkit
cp names.dmp nodes.dmp delnodes.dmp merged.dmp $HOME/.taxonkit

```


### Rpackages
First installed all using `install.packages("")` or similar (see REVAMP documentation)

```
library(dada2)
library(phyloseq)
library(vegan)
library(spatstat)
library(tidyverse)
library(ggrepel)
library(ggpubr)
library(ggalt)
library(mapdata)
library(terra) # not listed in REVAMP docs but had to manually install terra as dependency of marmap
library(marmap)
library(mapproj)
library(scatterpie)
library(janitor)
library(VennDiagram)
```

### Perl dependencies
Documentation says REVAMP requires Perl dependencies [List::Util](https://metacpan.org/pod/List::Util) and [List::MoreUtils](https://metacpan.org/pod/List::MoreUtils).

How did I do this? Using [CPAN](https://perldoc.perl.org/CPAN):

Open terminal, then `perl -MCPAN -e shell` to open cpan shell, then `install Sub::Util` and `install Sub::MoreUtils` to install each. 

Then `exit` to close out cpan shell. 

Check perl modules with
```
cpan -l
```

Long list but shows versions of the two I just installed:
`Sub::Util	1.46_02` and
`List::Util	1.46_02`

**EDIT** later on I had problem with perl dependencies not being there. IDK why but this `conda install perl-list-moreutils` seems to have resolved it.

**EDIT 2, 7/8/24** Later on having trouble again with script in assets, `asv_taxonomy_processing_figureOuts.pl`. To try to troubleshoot I ran `perl asv_taxonomy_processing_figureOuts.pl -h` and got error about MoreUtil: `Can't locate List/MoreUtils.pm in @INC (you may need to install the List::MoreUtils module) (@INC contains: /opt/anaconda3/lib/site_perl/5.26.2/darwin-thread-multi-2level /opt/anaconda3/lib/site_perl/5.26.2 /opt/anaconda3/lib/5.26.2/darwin-thread-multi-2level /opt/anaconda3/lib/5.26.2 .) at asv_taxonomy_processing_figureOuts.pl line 4.
BEGIN failed--compilation aborted at asv_taxonomy_processing_figureOuts.pl line 4.`. Tried `sudo cpan List::MoreUtils` to install MoreUtils. Hopefully worked...

- Tried installing MoreUtils with conda from [here](https://anaconda.org/bioconda/perl-list-moreutils), with `conda install bioconda::perl-list-moreutils
`

**EDIT 2, 7/22/24**
also tried `sudo cpan List::Util` and installed but didn't help with error in merge_taxonomy.pl

## Configuration files
Start messing with config files `01_config_file-txt`, `02_figure_config_file.txt`, and `03_sample_metadata.txt`. I already had played around a little bit with dada2 parameters from analyzing the 2023 data. For now just using 2021 elas02 metadata file modified from what Libby sent me.

## Run REVAMP
Set up configuarion files first according to examples


Make sure activate `REVAMPenv` in a terminal window and inside my `SHIRP` directory

### 2021 Elas02 dataset:

- waiting to get metadata sheet completed from Libby. Missing lat/long for some samples and possibly more info on controls. Can start with cutadapt and dada2 steps but not visualizations
- Also there are empty fastq file with no reads (`T5Blank` and `T10Blank`). Also `T1Blank` has 12 reads, `T7Blank` has only 3 reads, and `T9Blank` has only 14. Delete the `T5Blank` and `T10Blank` files and delete from metadata sheet. Leave other blanks for now...


```
revamp.sh -p 01_config_file_Elas02-2021.txt -f 02_figure_config_file_Elas02-2021.txt -s 03_sample_metadata_Elas02-2021.txt -r raw_data/2021-Elas02 -o results/revamp-2021-Elas02/
```

### 2023 Elas02 dataset:

- First remove T3blank_S3 fastq files. These are empty and mess up the ordering of the samples bc cutadapt doesn't run (but doesn't skip sample names).
	- Also remove from metadata sheet

```
revamp.sh -p 01_config_file_Elas02-2023.txt -f 02_figure_config_file_Elas02-2023.txt -s 03_sample_metadata_Elas02-2023.txt -r raw_data/2023-Elas02/demux -o results/revamp-2023-Elas02/
```

<br>

---

<br>

#### Steps/ Troubleshooting Notes as I Go:

- Had to copy the config file and metadata files into the out directory and call them simply `config_file.txt` and `sample_metadata.txt`. The first thing it did was check if those were identifical to my `-p` and `-s` files in parent directory.
- Had trouble with cutadapt step for 2021 bc the raw files weren't in "*.fastq.gz" format, which the script is looking for. Needed to gzip first:

	```
	cd raw_data/2021-Elas02
	for i in $(ls *.fastq);
	do
		gzip $i
	done
	```


	Helpful [link](https://unix.stackexchange.com/questions/45212/remove-prefixes-from-filenames0 for removing prefixes) for removing prefixes from files (the revamp.sh keeps adding prefixes to my fast.gz file names so when rerun, it gets messed up).


	```
	for file in * ; do
		echo mv -v "$file" "${file#*_}"
	done

	for file in * ; do
    	mv -v "$file" "${file#*_}"
	done
	```


- Also needed to remove "_001" suffix of file names (before the fastq.gz and after R1/2) before script would work. [Link](https://stackoverflow.com/questions/1500204/how-do-i-remove-specific-characters-from-file-names-using-bash)

	```
	for file in *; do mv "${file}" "${file/_001/}"; done
	```

- **6/24/24** Finally the cutadapt step is at least running and recognizing files from 2021 dataset but parameters are F*ed up, It is throwing out >99% of reads because it doesn't detect adaptor. Continue to mess with this here. 
- **6/25/24** Running using same cutadapt parameters on 2023 data. Cutadapt parameters are close to the ones I previously used in my own pipeline (less strict on length but exactly the same on primers and flags and throwing out untrimmed). cutadapt is leaving >95% of reads for most samples from 2023 dataset, so something is different with 2021 reads.
	- Also ran filter and trim steps for dada2. 
- **6/26/24** Did some reading through old emails and documentation and googling. The fastq files from 2021 already went through Mr. DNA's fastq processor, which means they've been demultiplexed *and* the primers were removed already. I'm not sure why the 2023 data were not treated in the same way. I therefore want to run cutadapt on these (because it is still detecting primer in some reads, up to 33% of reads in one case) but modify cutadapt parameters to keep untrimmed rather than discard. Had to modify revamp.sh script: deleted L293, `--discard-untrimmed \`. Then run command above on 2021 data and then added L293 back in after cutadapt run (for future use of script).
	- Leave dada2 running overnight on 2023 data. Try to start 2021 data late evening so it will be done by morning, if possible.


<br>

---

<br>

#### Saved some output from successful runs

**2021 Elas02**

`cutadapt` output:

```
Sample	Passing Reads	Passing bp
MP_AMW_RB1_S1_L001	100.0%	97.6%
MP_AMW_S2_S1_L001	100.0%	97.4%
MP_CCE1_S1_L001	100.0%	97.7%
MP_CCE2_S1_L001	100.0%	97.3%
MP_MC1_S1_L001	100.0%	97.2%
MP_MC2_S1_L001	100.0%	97.1%
MP_MEB_S1_L001	100.0%	96.9%
MP_SA1_S1_L001	100.0%	97.7%
MP_SA2_S1_L001	100.0%	97.0%
MP_Shark_blood_S2_L001	100.0%	98.4%
MP_T1S1_S1_L001	100.0%	97.6%
MP_T1S2_S1_L001	100.0%	98.0%
MP_T1S3_S1_L001	100.0%	98.0%
MP_T1S4_S1_L001	100.0%	97.9%
MP_T1S5_S1_L001	100.0%	97.6%
MP_T1S6_S1_L001	100.0%	98.8%
MP_T1S7_S1_L001	100.0%	98.2%
MP_T1S8_S1_L001	100.0%	97.5%
MP_T1S9_S1_L001	100.0%	97.8%
MP_T1S10_S1_L001	100.0%	97.9%
MP_T1S11_S1_L001	100.0%	97.8%
MP_T1Tiana_S1_L001	100.0%	98.7%
MP_T1Wessuck_S1_L001	100.0%	98.2%
MP_T1Blank_S1_L001	100.0%	99.4%
MP_T3S1_S1_L001	100.0%	98.8%
MP_T3S2_S1_L001	100.0%	98.5%
MP_T3S3_S1_L001	100.0%	98.6%
MP_T3S4_S1_L001	100.0%	98.5%
MP_T3S5_S1_L001	100.0%	98.2%
MP_T3S6_S1_L001	100.0%	97.5%
MP_T3S7_S1_L001	100.0%	98.2%
MP_T3S8_S1_L001	100.0%	98.4%
MP_T3S9_S1_L001	100.0%	99.0%
MP_T3S10_S1_L001	100.0%	98.6%
MP_T3S11_S1_L001	100.0%	98.5%
MP_T3Tiana_S1_L001	100.0%	97.9%
MP_T3Wessuck_S1_L001	100.0%	98.5%
MP_T3Blank_S1_L001	94.0%	78.8%
MP_T5S1_S1_L001	100.0%	98.1%
MP_T5S2_S1_L001	100.0%	97.9%
MP_T5S3_S1_L001	100.0%	98.4%
MP_T5S4_S1_L001	100.0%	98.2%
MP_T5S5_S1_L001	100.0%	98.1%
MP_T5S6_S1_L001	100.0%	98.9%
MP_T5S7_S1_L001	100.0%	97.9%
MP_T5S8_S1_L001	100.0%	98.8%
MP_T5S9_S1_L001	100.0%	98.1%
MP_T5S10_S1_L001	100.0%	98.6%
MP_T5S11_S2_L001	100.0%	98.3%
MP_T5Tiana_S2_L001	100.0%	98.4%
MP_T5Wessuck_S2_L001	100.0%	98.6%
MP_T7S1_S2_L001	100.0%	97.6%
MP_T7S2_S2_L001	100.0%	97.7%
MP_T7S3_S2_L001	100.0%	98.3%
MP_T7S4_S2_L001	100.0%	97.8%
MP_T7S5_S2_L001	100.0%	99.5%
MP_T7S6_S2_L001	100.0%	98.0%
MP_T7S7_S2_L001	100.0%	98.5%
MP_T7S8_S2_L001	100.0%	98.5%
MP_T7S9_S2_L001	100.0%	98.0%
MP_T7S10_S2_L001	100.0%	98.8%
MP_T7S11_S2_L001	100.0%	98.2%
MP_T7Tiana_S2_L001	100.0%	98.3%
MP_T7Wessuck_S2_L001	100.0%	98.5%
MP_T7Blank_S2_L001	100.0%	92.1%
MP_T9S1_S2_L001	100.0%	98.4%
MP_T9S2_S2_L001	100.0%	98.1%
MP_T9S3_S2_L001	100.0%	98.3%
MP_T9S4_S2_L001	100.0%	98.3%
MP_T9S5_S2_L001	100.0%	98.1%
MP_T9S6_S2_L001	100.0%	98.0%
MP_T9S7_S2_L001	100.0%	99.3%
MP_T9S8_S2_L001	100.0%	98.6%
MP_T9S9_S2_L001	100.0%	98.2%
MP_T9S10_S2_L001	100.0%	98.1%
MP_T9S11_S2_L001	100.0%	98.2%
MP_T9Tiana_S2_L001	100.0%	98.4%
MP_T9Wessuck_S2_L001	100.0%	98.2%
MP_T9Blank_S2_L001	100.0%	98.2%
MP_T10S1_S2_L001	100.0%	98.1%
MP_T10S2_S2_L001	100.0%	97.8%
MP_T10S3_S2_L001	100.0%	97.9%
MP_T10S4_S2_L001	100.0%	98.5%
MP_T10S5_S2_L001	100.0%	98.6%
MP_T10S6_S2_L001	100.0%	98.1%
MP_T10S7_S2_L001	100.0%	98.7%
MP_T10S8_S2_L001	100.0%	98.5%
MP_T10S9_S2_L001	100.0%	98.9%
MP_T10S10_S2_L001	100.0%	97.9%
MP_T10S11_S2_L001	100.0%	98.6%
MP_T10Tiana_S2_L001	100.0%	98.3%
MP_T10Wessuck_S2_L001	100.0%	98.6%
```

* Remember for above, I reset cutadapt parameters in `revamp.sh` so it wouldn't throw out untrimmed since this already went through Mr DNA's fastq processor. Then I re-edited the script back to its normal parameters because future data was not treated in this way.

**2023 Elas02**

`cutadapt` output:

- Hint: if lost log from previous day and can't copy-paste from log, I modified this from within the revamp.sh which pulls the stats from the `cutadapt_primer_trimming_stats.txt` directory. Need to be in `cutadapt` results directory:

	```
	echo "Sample	Passing Reads	Passing bp"
	paste ../sample_order.txt <(grep "passing" cutadapt_primer_trimming_stats.txt | cut -f3 -d "(" | tr -d ")") <(grep "filtered" cutadapt_primer_trimming_stats.txt | cut -f3 -d "(" | tr -d ")")
	```

```
Sample	Passing Reads	Passing bp
MP_T2Blank_S3_L002	98.4%	85.0%
MP_T2Positive_S3_L002	98.8%	83.6%
MP_T2S1_S3_L002	99.1%	88.4%
MP_T2S2_S3_L002	99.4%	81.1%
MP_T2S3_S3_L002	99.4%	84.1%
MP_T2S4_S3_L002	99.2%	80.7%
MP_T2S5_S3_L002	99.1%	79.7%
MP_T2S6_S3_L002	99.0%	79.4%
MP_T2S7_S3_L002	98.4%	86.5%
MP_T2S8_S3_L002	98.9%	81.7%
MP_T2S9_S3_L002	99.1%	80.0%
MP_T2S10_S3_L002	99.3%	79.4%
MP_T2S11_S3_L002	99.0%	83.5%
MP_T2WC_S3_L002	99.3%	79.1%
MP_T2Tiana_S3_L002	99.2%	79.4%
MP_T3Positive_S3_L002	99.1%	77.8%
MP_T3S1_S3_L002	99.2%	79.6%
MP_T3S2_S3_L002	96.3%	84.5%
MP_T3S3_S3_L002	99.2%	88.3%
MP_T3S4_S3_L002	99.2%	77.7%
MP_T3S5_S3_L002	99.3%	77.9%
MP_T3S6_S3_L002	98.9%	77.7%
MP_T3S7_S3_L002	99.0%	78.7%
MP_T3S8_S3_L002	99.1%	78.0%
MP_T3S9_S3_L002	99.1%	77.8%
MP_T3S10_S3_L002	99.0%	78.2%
MP_T3S11_S3_L002	99.1%	77.7%
MP_T3WC_S3_L002	76.4%	67.8%
MP_T3Tiana_S3_L002	99.2%	77.8%
MP_T5Blank_S4_L002	86.4%	66.6%
MP_T5Positive_S4_L002	99.1%	81.6%
MP_T5S1_S3_L002	98.4%	85.9%
MP_T5S2_S3_L002	98.8%	77.9%
MP_T5S3_S3_L002	99.1%	78.0%
MP_T5S4_S3_L002	99.1%	77.9%
MP_T5S5_S3_L002	99.3%	78.1%
MP_T5S6_S3_L002	98.9%	77.7%
MP_T5S7_S3_L002	99.3%	78.4%
MP_T5S8_S3_L002	98.6%	77.4%
MP_T5S9_S3_L002	98.9%	77.7%
MP_T5S10_S3_L002	99.2%	78.0%
MP_T5S11_S3_L002	99.2%	81.1%
MP_T5WC_S4_L002	88.6%	76.0%
MP_T5Tiana_S4_L002	99.3%	87.3%
MP_A_Blank_S4_L002	99.3%	76.7%
MP_A_Positive_S4_L002	94.8%	73.1%
MP_AC4_S4_L002	97.2%	85.7%
MP_AC5_S4_L002	99.3%	78.7%
MP_AS1_S4_L002	99.2%	77.8%
MP_AS3_S4_L002	99.0%	87.6%
MP_AS6_S4_L002	96.2%	83.6%
MP_AS9_S4_L002	98.6%	88.3%
MP_J_Blank_S4_L002	98.2%	79.8%
MP_J_Positive_S4_L002	99.3%	76.5%
MP_JC4_S4_L002	99.2%	88.5%
MP_JC5_S4_L002	99.1%	81.3%
MP_JS1_S4_L002	99.2%	87.7%
MP_JS3_S4_L002	98.2%	88.1%
MP_JS6_S4_L002	99.2%	88.0%
MP_JS9_S4_L002	89.1%	80.6%
MP_S_Blank_S4_L002	99.2%	76.7%
MP_S_Positive_S4_L002	99.1%	78.2%
MP_SC4_S4_L002	95.7%	82.2%
MP_SC5_S4_L002	87.2%	78.0%
MP_SS1_S4_L002	99.1%	83.7%
MP_SS3_S4_L002	99.3%	88.8%
MP_SS6_S4_L002	97.5%	85.7%
MP_SS9_S4_L002	98.2%	86.3%
```


`dada2` filtering results

```
DADA2 Filtering results:
Sample	% Reads Passing
MP_T2Blank_S3_L002_R1_trimmed.fq.gz 90.3206
MP_T2Positive_S3_L002_R1_trimmed.fq.gz 90.5224
MP_T2S1_S3_L002_R1_trimmed.fq.gz 87.6947
MP_T2S2_S3_L002_R1_trimmed.fq.gz 87.1964
MP_T2S3_S3_L002_R1_trimmed.fq.gz 90.1976
MP_T2S4_S3_L002_R1_trimmed.fq.gz 91.2425
MP_T2S5_S3_L002_R1_trimmed.fq.gz 91.7826
MP_T2S6_S3_L002_R1_trimmed.fq.gz 91.301
MP_T2S7_S3_L002_R1_trimmed.fq.gz 88.2449
MP_T2S8_S3_L002_R1_trimmed.fq.gz 89.241
MP_T2S9_S3_L002_R1_trimmed.fq.gz 89.9689
MP_T2S10_S3_L002_R1_trimmed.fq.gz 91.9888
MP_T2S11_S3_L002_R1_trimmed.fq.gz 89.5974
MP_T2WC_S3_L002_R1_trimmed.fq.gz 85.5114
MP_T2Tiana_S3_L002_R1_trimmed.fq.gz 92.1302
MP_T3Positive_S3_L002_R1_trimmed.fq.gz 92.2075
MP_T3S1_S3_L002_R1_trimmed.fq.gz 92.9461
MP_T3S2_S3_L002_R1_trimmed.fq.gz 80.2856
MP_T3S3_S3_L002_R1_trimmed.fq.gz 84.8524
MP_T3S4_S3_L002_R1_trimmed.fq.gz 92.8276
MP_T3S5_S3_L002_R1_trimmed.fq.gz 92.8181
MP_T3S6_S3_L002_R1_trimmed.fq.gz 92.2754
MP_T3S7_S3_L002_R1_trimmed.fq.gz 92.1461
MP_T3S8_S3_L002_R1_trimmed.fq.gz 91.6896
MP_T3S9_S3_L002_R1_trimmed.fq.gz 92.5981
MP_T3S10_S3_L002_R1_trimmed.fq.gz 91.597
MP_T3S11_S3_L002_R1_trimmed.fq.gz 93.0038
MP_T3WC_S3_L002_R1_trimmed.fq.gz 90.1207
MP_T3Tiana_S3_L002_R1_trimmed.fq.gz 91.2139
MP_T5Blank_S4_L002_R1_trimmed.fq.gz 91.8364
MP_T5Positive_S4_L002_R1_trimmed.fq.gz 91.4351
MP_T5S1_S3_L002_R1_trimmed.fq.gz 87.1272
MP_T5S2_S3_L002_R1_trimmed.fq.gz 91.2127
MP_T5S3_S3_L002_R1_trimmed.fq.gz 91.3059
MP_T5S4_S3_L002_R1_trimmed.fq.gz 93.2008
MP_T5S5_S3_L002_R1_trimmed.fq.gz 92.2056
MP_T5S6_S3_L002_R1_trimmed.fq.gz 91.0665
MP_T5S7_S3_L002_R1_trimmed.fq.gz 90.608
MP_T5S8_S3_L002_R1_trimmed.fq.gz 91.5112
MP_T5S9_S3_L002_R1_trimmed.fq.gz 92.3221
MP_T5S10_S3_L002_R1_trimmed.fq.gz 92.258
MP_T5S11_S3_L002_R1_trimmed.fq.gz 84.8926
MP_T5WC_S4_L002_R1_trimmed.fq.gz 85.8071
MP_T5Tiana_S4_L002_R1_trimmed.fq.gz 89.4138
MP_A_Blank_S4_L002_R1_trimmed.fq.gz 93.5082
MP_A_Positive_S4_L002_R1_trimmed.fq.gz 92.258
MP_AC4_S4_L002_R1_trimmed.fq.gz 88.374
MP_AC5_S4_L002_R1_trimmed.fq.gz 92.8049
MP_AS1_S4_L002_R1_trimmed.fq.gz 92.8017
MP_AS3_S4_L002_R1_trimmed.fq.gz 88.8055
MP_AS6_S4_L002_R1_trimmed.fq.gz 88.5756
MP_AS9_S4_L002_R1_trimmed.fq.gz 88.1189
MP_J_Blank_S4_L002_R1_trimmed.fq.gz 73.7895
MP_J_Positive_S4_L002_R1_trimmed.fq.gz 93.7787
MP_JC4_S4_L002_R1_trimmed.fq.gz 74.4103
MP_JC5_S4_L002_R1_trimmed.fq.gz 88.7596
MP_JS1_S4_L002_R1_trimmed.fq.gz 89.0989
MP_JS3_S4_L002_R1_trimmed.fq.gz 87.0878
MP_JS6_S4_L002_R1_trimmed.fq.gz 88.5759
MP_JS9_S4_L002_R1_trimmed.fq.gz 86.6657
MP_S_Blank_S4_L002_R1_trimmed.fq.gz 92.9048
MP_S_Positive_S4_L002_R1_trimmed.fq.gz 92.4335
MP_SC4_S4_L002_R1_trimmed.fq.gz 89.5045
MP_SC5_S4_L002_R1_trimmed.fq.gz 74.0315
MP_SS1_S4_L002_R1_trimmed.fq.gz 90.1618
MP_SS3_S4_L002_R1_trimmed.fq.gz 80.4737
MP_SS6_S4_L002_R1_trimmed.fq.gz 88.4368
MP_SS9_S4_L002_R1_trimmed.fq.gz 75.8247
```


**Next morning 6/27**

- Failed due to memory error
	- Generated the _filtered fastq.gz files for all R1 reads but there are none for the R2 reads in the directory. Also only the R1 reads are listed in the `filtered_out_stats.txt` file and only R1 reads were listed as `trimmed.fq.gz` in the ouput pasted above. Maybe it runs through the whole things with one direction first? Eg. Trim -> Filter -> Derep for R1 first then all 3 steps for R2 then merge?... No, checked the script and it doesn't do that. Plus the R2 reads are plotted in `trimRQualityPlot.pdf` but I am not sure where the actual files are located. 
		- The trimmed plots and filtered out stats file also have the same numbers in/out for both R1 and R2 reads. I think this has something to do with cutadapt, which cut primers from both reads in one run and output one number for total reads passing filter.
		- Also note that `trimFQualityPlot.pdf` and `trimRQualityPlot.pdf` should be **filter**FQualityPlot.pdf because the trimmed fastq files (aka output from cutadapt) are the "raw" plots in this `dada2` results directory and the output of filterAndTrim are called filtered.fastq.gz files
	- the `dada2_rscripts_out.log` says it dereplicated all R1 filtered reads and most of R2 reads (although I don't see where the actual R2 filtered reads are) but halted after `MP_T5S10_S3_L002_R2_filtered.fq.gz` with this error:
	
	```
	Dereplicating sequence entries in Fastq file: MP_T5S11_S3_L002_R2_filtered.fq.gz
Error: vector memory limit of 16.0 Gb reached, see mem.maxVSize()
Execution halted
```
	- In REVAMP documentation, looks like the memory becomes important in the sub script, [dada2_step2.R](https://github.com/McAllister-NOAA/REVAMP/blob/main/assets/dada2_step2.R), L20, right before `learnErrors` is run. But this ran fine: I can see in the `errorFPlot.pdf` and `errorRPlot.pdf` plots. RIght after that is the `derepFastq` function which is where it seems to have run into the memory error (L40, derep-ing the R reads). 
	- I might have to reduce the `systemmemoryMB` parameter in config file. Changed from 16000 MB to 10000
- Also looked at the `trimFQualityPlot.pdf` and `trimRQualityPlot.pdf` and  the trimmed reads are too long. The `revamp.sh` script doesn't take an argument for truncation length (`truncLen`) in the `filterAndTrim` command of dada2. I can modify the script or set `trimRight` instead. According to `filterAndTrim` [documentation](https://rdrr.io/bioc/dada2/man/filterAndTrim.html), this is what `trimRight` does:  "The number of nucleotides to remove from the end of each read. If both truncLen and trimRight are provided, truncation will be performed after trimRight is enforced."
	- Previously I trimmed using `truncLen` down to 175 bp. So since these are 250 bp reads, setting `trimRight` to 75 should do same thing? Change in both config_files

	
- Adjusted all of above and did a test run (in `test` directory in results folder) with file that failed on last run, `T5S10_S3_L002` and `T5S11_S3_L002` (Note: [lapply leads to error with just one sample run](https://github.com/benjjneb/dada2/issues/280))
	
	```
	revamp.sh -p 01_config_file_Elas02-2023test.txt -f 02_figure_config_file_Elas02-2023test.txt -s 03_sample_metadata_Elas02-2023test.txt -r raw_data/test -o results/test
	```
	
	- dada2 steps worked after some playing around!
	
		```
		Sample	%Reads Retained
		MP_T5S10_S3_L002 92.4
		MP_T5S11_S3_L002 86.3
		```
		
		continue messing with this to see if can get blastn to work before running on full dataset
	
	- getting stuck on blastn step. Run independently to try to troubleshoot...
		
		```
		  blastn -db ../databases/Taberlet-elas02-local-20240612/blastdb/nt -query results/test/dada2/ASVs.fa -outfmt '6 qseqid pident length staxids sacc' -subject_besthit -max_target_seqs 4000 -num_threads 6 -out results/test/blast_results/ASV_blastn_nt.btab

		```
		
		Holy sh* that worked. Now try to figure out why it's not working in revamp.sh pipeline
		
		- Had to set configuration file, last line: `blastMode=allIN #options: allIN, allEnvOUT, mostEnvOUT` instead of most EnvOut. I think since I am using my own, small database instead of all nt this is what I want.
		- Now the blast step works but following step, assign taxonomy, is looking for taxIDs in the blastdb and not finding them. I tried `blastdbcheck -db blastdb/nt  -must_have_taxids -verbosity 3` on the blast database and it's failing to find taxIDs. Alternatively, `blastdbcmd -db blastdb/nt -entry all -outfmt "%T"` will list all TaxIDs, which right now are all zeroes.
		- I went back to my `databases` R project ane remade blastdb and checked for taxIDs and they are there (it tooks some finagling). Now try again. Redo blastn step in test directory, do delete blast lines from progress.txt.
		```
		revamp.sh -p 01_config_file_Elas02-2023test.txt -f 02_figure_config_file_Elas02-2023test.txt -s 03_sample_metadata_Elas02-2023test.txt -r raw_data/test -o results/test
		```
		
		- blastn now seems to be working correctly!
	- ASV2Taxonomy step was looking for the taxdump files in my `blastdb` folder alongside the `nt` files so I also copied them in there. It still was not finding one that doesn't exist: `There is no ../databases/Taberlet-elas02-local-20240612/blastdb/taxdump/common_names.dmp file!!`
		- Hidden in the REVAMP github in `assets/asv_taxonomy_processing_figureOuts.pl`, it is looking for the parameter `-c` which says this in the comment: "Location of common names file (grep "genbank common name" from names.dmp NCBI taxonomy file)"
			- So I went back into my `../databases/Taberlet-elas02-local-20240612/blastdb/taxdump` folder and made `common_names.dmp` with  `grep "genbank common name" names.dmp > common_names.dmp` but still getting same error... I copied it into software folder and `~/.taxonkit` folder and it's still not finding it, so IDK. I don't know if that's a major problem for the script to continue... **STUCK HERE**
			- Try to run ASV2Tax script on its own from with `ASV2Taxonomy` sub directory:
			`perl ~/software/REVAMP/assets/asv_taxonomy_processing_figureOuts.pl -a ../dada2/ASVs_counts.tsv -s ../blast_results/ASV_blastn_nt_formatted.txt -t reformatted_taxonkit_out.txt -f 97,95,90,80,70,60 -n ../ -c ../../../../databases/Taberlet-elas02-local-20240612/blastdb/taxdump/common_names.dmp -o ../sample_order.txt`
			
			- AHA- the problem is location. Within the script, you are in the `ASV2Taxonomy` sub directory so calling the `locationNTdatabase` parameter from the config file using a relative operator (`..`) gets messed up. Changed to absolute location in all config files, `/Volumes/MyPassport/eDNA/databases/Taberlet-elas02-local-20240612/blastdb`
	-  Next error still within ASV2Taxonomy step: ` sh: results/test_unique_terminaltaxa_w_taxids.txt: No such file or directory
Something wrong with taxonkit name2taxid output`
		- Tried running ASV2Tax script on its own again from with `ASV2Taxonomy` sub directory:
			`perl ~/software/REVAMP/assets/asv_taxonomy_processing_figureOuts.pl -a ../dada2/ASVs_counts.tsv -s ../blast_results/ASV_blastn_nt_formatted.txt -t reformatted_taxonkit_out.txt -f 97,95,90,80,70,60 -n test -c ../../../../databases/Taberlet-elas02-local-20240612/blastdb/taxdump/common_names.dmp -o ../sample_order.txt` and get this error:

		```
Can't exec "ImportText.pl": No such file or directory at /Users/admin/software/REVAMP/assets/asv_taxonomy_processing_figureOuts.pl line 1258.
Can't exec "ImportText.pl": No such file or directory at /Users/admin/software/REVAMP/assets/asv_taxonomy_processing_figureOuts.pl line 1260.
		```

		- I think I'm getting problems because my files are in directories within directories
			- Try rerunning with different file structure, from within SHIRP directory:		
			
		```revamp.sh -p 01_config_file_Elas02-2023test.txt -f 02_figure_config_file_Elas02-2023test.txt -s 03_sample_metadata_Elas02-2023test.txt -r raw_data/test -o results-test```

	- Reorganizing directories solved that problem, next problem... `Can't exec "ImportText.pl": No such file or directory at /Users/admin/software/REVAMP/assets/asv_taxonomy_processing_figureOuts.pl line 1258.
Can't exec "ImportText.pl": No such file or directory at /Users/admin/software/REVAMP/assets/asv_taxonomy_processing_figureOuts.pl line 1260.`


		- Seems to be an error with Krona and finding directories?... Reinstall Krona (see above) and try again 
		- `perl ImportText.pl DNA_krona.txt`

		-	**LQDBN$%#$** messing with parameter of install.pl in Krona messed with and deleted my databases folder!!!! Using Disk Drill to find everything. See RECOVERJUL82024 folder in my Documents. Right now backing up taxonomizr directory. Next will have to do blastdb which is huge....ugh
		- 7/11/24 I finished recovering deleted files and backed up everything on new hard drive... working on new HD (easystore) and now Krona is working ...
		- No phyloseq/ vegan results were written except bar charts but it could be because there are only two samples. The maps were written and the tables that feed into the ordinations. I feel comfortable trying actual samples at this point since I can do a lot of the ordination analysis myself.

--

Restart with **2021 Elas data**. The cutadapt step was already completed

- Modify progress.txt to only say `cutadaptFinished=TRUE` so that it starts at the dada2 step
- Slightly modify revamp line now that file structure is different:

`revamp.sh -p 01_config_file_Elas02-2021.txt -f 02_figure_config_file_Elas02-2021.txt -s 03_sample_metadata_Elas02-2021.txt -r raw_data/2021-Elas02 -o results-revamp-2021-Elas02/`

dada2 filtering results

```
FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_AMW_RB1_S1_L001 86.8
MP_AMW_S2_S1_L001 92.6
MP_CCE1_S1_L001 90.9
MP_CCE2_S1_L001 91.2
MP_MC1_S1_L001 90.9
MP_MC2_S1_L001 90.1
MP_MEB_S1_L001 68.5
MP_SA1_S1_L001 86.1
MP_SA2_S1_L001 90.3
MP_Shark_blood_S2_L001 91.9
MP_T1S1_S1_L001 85
MP_T1S2_S1_L001 89.5
MP_T1S3_S1_L001 89.6
MP_T1S4_S1_L001 84.7
MP_T1S5_S1_L001 91.3
MP_T1S6_S1_L001 84.4
MP_T1S7_S1_L001 87.6
MP_T1S8_S1_L001 90.7
MP_T1S9_S1_L001 88.6
MP_T1S10_S1_L001 90.7
MP_T1S11_S1_L001 91.3
MP_T1Tiana_S1_L001 85.6
MP_T1Wessuck_S1_L001 89.8
MP_T1Blank_S1_L001 41.7
MP_T3S1_S1_L001 85.5
MP_T3S2_S1_L001 85.3
MP_T3S3_S1_L001 85.6
MP_T3S4_S1_L001 81
MP_T3S5_S1_L001 88.7
MP_T3S6_S1_L001 90.3
MP_T3S7_S1_L001 88.5
MP_T3S8_S1_L001 81.5
MP_T3S9_S1_L001 75.7
MP_T3S10_S1_L001 79.1
MP_T3S11_S1_L001 89.7
MP_T3Tiana_S1_L001 91.2
MP_T3Wessuck_S1_L001 86.4
MP_T3Blank_S1_L001 7.6
MP_T5S1_S1_L001 89.3
MP_T5S2_S1_L001 91.7
MP_T5S3_S1_L001 83
MP_T5S4_S1_L001 89.3
MP_T5S5_S1_L001 90.1
MP_T5S6_S1_L001 81.9
MP_T5S7_S1_L001 90.5
MP_T5S8_S1_L001 85.7
MP_T5S9_S1_L001 91.8
MP_T5S10_S1_L001 89.3
MP_T5S11_S2_L001 91.4
MP_T5Tiana_S2_L001 91.3
MP_T5Wessuck_S2_L001 87
MP_T7S1_S2_L001 92.1
MP_T7S2_S2_L001 91.7
MP_T7S3_S2_L001 91.4
MP_T7S4_S2_L001 92.6
MP_T7S5_S2_L001 79.2
MP_T7S6_S2_L001 88.8
MP_T7S7_S2_L001 82.9
MP_T7S8_S2_L001 82.4
MP_T7S9_S2_L001 90.3
MP_T7S10_S2_L001 81.8
MP_T7S11_S2_L001 91.2
MP_T7Tiana_S2_L001 88.5
MP_T7Wessuck_S2_L001 84.2
MP_T7Blank_S2_L001 0
MP_T9S1_S2_L001 90.3
MP_T9S2_S2_L001 89.6
MP_T9S3_S2_L001 79.4
MP_T9S4_S2_L001 91.5
MP_T9S5_S2_L001 90.8
MP_T9S6_S2_L001 88.1
MP_T9S7_S2_L001 70.7
MP_T9S8_S2_L001 88.9
MP_T9S9_S2_L001 87.9
MP_T9S10_S2_L001 89.7
MP_T9S11_S2_L001 90.8
MP_T9Tiana_S2_L001 84.5
MP_T9Wessuck_S2_L001 89.7
MP_T9Blank_S2_L001 42.9
MP_T10S1_S2_L001 90.3
MP_T10S2_S2_L001 89.2
MP_T10S3_S2_L001 76.3
MP_T10S4_S2_L001 81.3
MP_T10S5_S2_L001 87.9
MP_T10S6_S2_L001 91.9
MP_T10S7_S2_L001 82.6
MP_T10S8_S2_L001 82.9
MP_T10S9_S2_L001 82.8
MP_T10S10_S2_L001 87.6
MP_T10S11_S2_L001 84.5
MP_T10Tiana_S2_L001 91.2
MP_T10Wessuck_S2_L001 87.2
```

**Holy c** I think it worked. Got minor error, but it generated all plots:

```
Illegal division by zero at /Users/admin/software/REVAMP/assets/merge_on_taxonomy.pl line 163.
Illegal division by zero at /Users/admin/software/REVAMP/assets/stats.pl line 162.
```

Re-run with contaminant removal.
- Need to list each individual comtanimating ASV, ugh. Looked through `ASV2Taxonomy/results-revamp-2021-Elas02_asvTaxonomyTable.txt` and using Excel filtered to see ASV# of known contaminants: the genera: Homo, Sus, Bos, and Canis, as well as class: Ave. 
- Re-run from blast step (I'm not sure where exacvtly it removes contaminants). First modify config file to indicate where remove_contaminants file is.

---
Next, try on 2023 data, also starting from dada2 step. 

Worked, just generating a mninor error but runs through whole things and generates all figures.

```
Writing results-revamp-2021-Elas02_master_krona.html...
Writing results-revamp-2021-Elas02_wholeKRONA.html...
Writing results-revamp-2021-Elas02_IGNORE_master_krona.html...
Illegal division by zero at /Users/admin/software/REVAMP/assets/merge_on_taxonomy.pl line 163.
Illegal division by zero at /Users/admin/software/REVAMP/assets/stats.pl line 162.
```

**7/11/24 STOPPED HERE**
check for why/ if contaminants are fully removed...
Meanwhile over night run dada2 step for 2023:

`revamp.sh -p 01_config_file_Elas02-2023.txt -f 02_figure_config_file_Elas02-2023.txt -s 03_sample_metadata_Elas02-2023.txt -r raw_data/2023-Elas02 -o results-revamp-2023-Elas02/`

dada2 output

```
Trim and filter in DADA2...

DADA2 Filtering results:
Sample	% Reads Passing
MP_T2Blank_S3_L002_R1_trimmed.fq.gz 67.1394
MP_T2Positive_S3_L002_R1_trimmed.fq.gz 52.958
MP_T2S1_S3_L002_R1_trimmed.fq.gz 85.5486
MP_T2S2_S3_L002_R1_trimmed.fq.gz 93.2072
MP_T2S3_S3_L002_R1_trimmed.fq.gz 54.0067
MP_T2S4_S3_L002_R1_trimmed.fq.gz 96.1668
MP_T2S5_S3_L002_R1_trimmed.fq.gz 96.702
MP_T2S6_S3_L002_R1_trimmed.fq.gz 96.1617
MP_T2S7_S3_L002_R1_trimmed.fq.gz 76.995
MP_T2S8_S3_L002_R1_trimmed.fq.gz 94.5073
MP_T2S9_S3_L002_R1_trimmed.fq.gz 93.6656
MP_T2S10_S3_L002_R1_trimmed.fq.gz 96.5096
MP_T2S11_S3_L002_R1_trimmed.fq.gz 95.057
MP_T2WC_S3_L002_R1_trimmed.fq.gz 76.6731
MP_T2Tiana_S3_L002_R1_trimmed.fq.gz 96.9345
MP_T3Positive_S3_L002_R1_trimmed.fq.gz 94.9768
MP_T3S1_S3_L002_R1_trimmed.fq.gz 92.2444
MP_T3S2_S3_L002_R1_trimmed.fq.gz 69.9572
MP_T3S3_S3_L002_R1_trimmed.fq.gz 82.025
MP_T3S4_S3_L002_R1_trimmed.fq.gz 95.4963
MP_T3S5_S3_L002_R1_trimmed.fq.gz 97.2781
MP_T3S6_S3_L002_R1_trimmed.fq.gz 96.6724
MP_T3S7_S3_L002_R1_trimmed.fq.gz 96.8397
MP_T3S8_S3_L002_R1_trimmed.fq.gz 94.7183
MP_T3S9_S3_L002_R1_trimmed.fq.gz 97.1442
MP_T3S10_S3_L002_R1_trimmed.fq.gz 96.3609
MP_T3S11_S3_L002_R1_trimmed.fq.gz 74.8434
MP_T3WC_S3_L002_R1_trimmed.fq.gz 86.6107
MP_T3Tiana_S3_L002_R1_trimmed.fq.gz 96.2322
MP_T5Blank_S4_L002_R1_trimmed.fq.gz 7.05995
MP_T5Positive_S4_L002_R1_trimmed.fq.gz 75.6288
MP_T5S1_S3_L002_R1_trimmed.fq.gz 72.0014
MP_T5S2_S3_L002_R1_trimmed.fq.gz 96.2324
MP_T5S3_S3_L002_R1_trimmed.fq.gz 96.4217
MP_T5S4_S3_L002_R1_trimmed.fq.gz 97.2773
MP_T5S5_S3_L002_R1_trimmed.fq.gz 96.9424
MP_T5S6_S3_L002_R1_trimmed.fq.gz 95.5649
MP_T5S7_S3_L002_R1_trimmed.fq.gz 96.0383
MP_T5S8_S3_L002_R1_trimmed.fq.gz 92.2304
MP_T5S9_S3_L002_R1_trimmed.fq.gz 96.4615
MP_T5S10_S3_L002_R1_trimmed.fq.gz 96.93
MP_T5S11_S3_L002_R1_trimmed.fq.gz 90.2133
MP_T5WC_S4_L002_R1_trimmed.fq.gz 61.463
MP_T5Tiana_S4_L002_R1_trimmed.fq.gz 95.0937
MP_A_Blank_S4_L002_R1_trimmed.fq.gz 1.81721
MP_A_Positive_S4_L002_R1_trimmed.fq.gz 3.59355
MP_AC4_S4_L002_R1_trimmed.fq.gz 78.1504
MP_AC5_S4_L002_R1_trimmed.fq.gz 94.0466
MP_AS1_S4_L002_R1_trimmed.fq.gz 8.87243
MP_AS3_S4_L002_R1_trimmed.fq.gz 80.2422
MP_AS6_S4_L002_R1_trimmed.fq.gz 69.6223
MP_AS9_S4_L002_R1_trimmed.fq.gz 87.7206
MP_J_Blank_S4_L002_R1_trimmed.fq.gz 10.9474
MP_J_Positive_S4_L002_R1_trimmed.fq.gz 1.85616
MP_JC4_S4_L002_R1_trimmed.fq.gz 73.9964
MP_JC5_S4_L002_R1_trimmed.fq.gz 94.9202
MP_JS1_S4_L002_R1_trimmed.fq.gz 79.0478
MP_JS3_S4_L002_R1_trimmed.fq.gz 89.0374
MP_JS6_S4_L002_R1_trimmed.fq.gz 81.1188
MP_JS9_S4_L002_R1_trimmed.fq.gz 94.1241
MP_S_Blank_S4_L002_R1_trimmed.fq.gz 1.74221
MP_S_Positive_S4_L002_R1_trimmed.fq.gz 83.7473
MP_SC4_S4_L002_R1_trimmed.fq.gz 61.8869
MP_SC5_S4_L002_R1_trimmed.fq.gz 75.8959
MP_SS1_S4_L002_R1_trimmed.fq.gz 50.7576
MP_SS3_S4_L002_R1_trimmed.fq.gz 85.7413
MP_SS6_S4_L002_R1_trimmed.fq.gz 76.7066
MP_SS9_S4_L002_R1_trimmed.fq.gz 66.5553

Parameters to modify:
minLen,rm.phix,truncQ,maxEE-primer1,maxEE-primer2,trimRight,trimLeft
Current settings:
100,TRUE,2,2,2,75,0
Please check DADA2 filtering success. Proceed? [y/n/m]
y
Continuing!

Learning error, Dereplication, Merge, and ASVs in DADA2...
Please be patient, may take a while. Messages printed to Rscript log.


FINAL DADA2 STATS
Note: Please check for a failed merge of forward/reverse sequences
Sample	%Reads Retained
MP_T2Blank_S3_L002 62.5
MP_T2Positive_S3_L002 50.6
MP_T2S1_S3_L002 77.6
MP_T2S2_S3_L002 88.5
MP_T2S3_S3_L002 47.8
MP_T2S4_S3_L002 90.6
MP_T2S5_S3_L002 92.2
MP_T2S6_S3_L002 91.9
MP_T2S7_S3_L002 70.9
MP_T2S8_S3_L002 90.7
MP_T2S9_S3_L002 90.2
MP_T2S10_S3_L002 91.3
MP_T2S11_S3_L002 88.1
MP_T2WC_S3_L002 73.8
MP_T2Tiana_S3_L002 94.1
MP_T3Positive_S3_L002 86.1
MP_T3S1_S3_L002 89.3
MP_T3S2_S3_L002 66.2
MP_T3S3_S3_L002 76.9
MP_T3S4_S3_L002 91.6
MP_T3S5_S3_L002 94.4
MP_T3S6_S3_L002 91.2
MP_T3S7_S3_L002 92.6
MP_T3S8_S3_L002 91.7
MP_T3S9_S3_L002 92.6
MP_T3S10_S3_L002 92.4
MP_T3S11_S3_L002 72.2
MP_T3WC_S3_L002 76.9
MP_T3Tiana_S3_L002 92.2
MP_T5Blank_S4_L002 6.5
MP_T5Positive_S4_L002 71.7
MP_T5S1_S3_L002 68
MP_T5S2_S3_L002 93.1
MP_T5S3_S3_L002 92.8
MP_T5S4_S3_L002 91.1
MP_T5S5_S3_L002 94
MP_T5S6_S3_L002 92.7
MP_T5S7_S3_L002 92.6
MP_T5S8_S3_L002 88.8
MP_T5S9_S3_L002 93.5
MP_T5S10_S3_L002 92.7
MP_T5S11_S3_L002 86.5
MP_T5WC_S4_L002 56.5
MP_T5Tiana_S4_L002 90
MP_A_Blank_S4_L002 1.6
MP_A_Positive_S4_L002 3.3
MP_AC4_S4_L002 65.5
MP_AC5_S4_L002 91.7
MP_AS1_S4_L002 7.7
MP_AS3_S4_L002 73.6
MP_AS6_S4_L002 62.9
MP_AS9_S4_L002 81.8
MP_J_Blank_S4_L002 4.2
MP_J_Positive_S4_L002 1.7
MP_JC4_S4_L002 65.7
MP_JC5_S4_L002 89.6
MP_JS1_S4_L002 70.5
MP_JS3_S4_L002 78.4
MP_JS6_S4_L002 74.4
MP_JS9_S4_L002 83.4
MP_S_Blank_S4_L002 1.6
MP_S_Positive_S4_L002 81
MP_SC4_S4_L002 56.2
MP_SC5_S4_L002 69
MP_SS1_S4_L002 42.8
MP_SS3_S4_L002 76.9
MP_SS6_S4_L002 64.3
MP_SS9_S4_L002 59.7

```

- For both 2021 and 2023 runs, when prompted:

```
Running ASV-2-Taxonomy Script: Mon Jul 22 08:53:55 EDT 2024

Reformatted taxon strings created. Options:
Continue without changes [c]
Manually edit file and replace in same location with identical file structure [m]
    (Make choice when file is modified and you are ready to proceed)
Automatically fill gaps in reformatted taxonkit hierarchy [a]
```

select `a` for automatic

- I manually checked some of the high abundance unknowns that get removed in blastn: ASV_2 and _3 seems like diatoms


Minor errors that didn't allow it to do any of the ordinations, networks, look into:

```

There is no results-revamp-2023-Elas02/processed_tables/ASVs_counts_NOUNKNOWNS_collapsedOnTaxonomy_percentabund.tsv file!!

cat: /Volumes/easystore/eDNA/SHIRP/results-revamp-2023-Elas02/processed_tables/sample_metadata*: No such file or directory


NADA results-revamp-2023-Elas02/processed_tables/ASVs_counts_NOUNKNOWNS_collapsedOnTaxonomy_controlsRemoved.tsv file!!



NADA results-revamp-2023-Elas02/processed_tables/ASVs_counts_NOUNKNOWNS_collapsedOnTaxonomy_controlsRemoved.tsv file!!

```

- also figure out contamination removal


---

**7/16/24**

- I tried containation removal using the `remove_contaminants.txt` file but I think it's not going to work without re-running dada2 step (?) so just rerun and leave out that part. I can remove in R myself later for bubble plots, etc.


- I think this error:

```
Illegal division by zero at /Users/admin/software/REVAMP/assets/merge_on_taxonomy.pl line 163.
Illegal division by zero at /Users/admin/software/REVAMP/assets/stats.pl line 162.
```

is due to there being no reads left in a couple of files after quality filtering (happened for some of the blanks)

- I think this error:

```
There is no results-revamp-2023-Elas02/processed_tables/ASVs_counts_NOUNKNOWNS_collapsedOnTaxonomy_percentabund.tsv file!!

cat: /Volumes/easystore/eDNA/shirp-edna/results-revamp-2023-Elas02/processed_tables/sample_metadata*: No such file or directory


NADA results-revamp-2023-Elas02/processed_tables/ASVs_counts_NOUNKNOWNS_collapsedOnTaxonomy_controlsRemoved.tsv file!!


NADA results-revamp-2023-Elas02/processed_tables/ASVs_counts_NOUNKNOWNS_collapsedOnTaxonomy_controlsRemoved.tsv file!!

```


L784 `merge_on_taxonomy.pl` not working, not able to write the "merged_taxonomy" files


try to run independently

from revamp.sh:

```
    perl ${revampdir}/assets/merge_on_taxonomy.pl 
    -a ${outdirectory}/dada2/ASVs_counts.tsv 
    -t ${outdirectory}/ASV2Taxonomy/${outdirectory}_asvTaxonomyTable.txt 
    -o ${outdirectory}/ASV2Taxonomy > ${outdirectory}/ASV2Taxonomy/ASVs_counts_mergedOnTaxonomy.tsv
```

my mods:

```
perl /Users/admin/software/REVAMP/assets/merge_on_taxonomy.pl -a /Volumes/easystore/eDNA/shirp-edna/results-revamp-2023-Elas02/dada2/ASVs_counts.tsv -t /Volumes/easystore/eDNA/shirp-edna/results-revamp-2023-Elas02/ASV2Taxonomy/results-revamp-2023-Elas02_asvTaxonomyTable.txt -o /Volumes/easystore/eDNA/shirp-edna/results-revamp-2023-Elas02/ASV2Taxonomy/TEST.tsv

```



It's a `print() on closed filehandle OUT ` error which is a permissions error according to internet. But I can't figure out why- and it's weird that this worked fine for the 2021 and test directories.


Instead wasting too much time on this, I can do the collapsed taxonomy myself in R using phyloseq. Move to R, `plots.Rmd` notebook. Things to do:

- Remove low abundance ASVs (1000 read cutoff?) bc I have evidence that pos controls are bleeding into other samples at low abundance
	- Alternatively use decontam?
- remove contaminants (Homo sapiens, other mammals, etc)
- calculate merged taxonomy
- generate bubble plots
- pie chart
- sned dataset highlighting cownose ray and sand tiger shark for GIS analysis
- update methods section
- upload elas02 database
