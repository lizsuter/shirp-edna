#!/bin/bash

# Usage: ./automate_reblast.sh results-revamp-2024-CO1-expeditiona-test CO1_2024-expeditiona-test

set -e  # Exit on error

# Define input argument
RESULTS_DIR=$1
CONFIG_PREFIX=$2 # name used for config_file
BASE_DIR="/Volumes/easystore/eDNA/shirp-edna"
REVAMP_DIR="$BASE_DIR/$RESULTS_DIR"
DADA2_DIR="$REVAMP_DIR/dada2"
ASV2TAXONOMY_DIR="$REVAMP_DIR/ASV2Taxonomy"

# Dynamically name `Chordata_reBLAST` directory inside BASE_DIR
CHORDATA_BLAST_DIR="$BASE_DIR/${RESULTS_DIR}_Chordata_reBLAST"
DADA2_SUBSET_DIR="$CHORDATA_BLAST_DIR/dada2"
TEMP_MAPPING="$CHORDATA_BLAST_DIR/asv_temp_mapping.tsv"
BLAST_RESULTS_DIR="$CHORDATA_BLAST_DIR/blast_results"
BLAST_BTAB="$BLAST_RESULTS_DIR/ASV_blastn_nt.btab"
BLAST_FORMATTED="$BLAST_RESULTS_DIR/ASV_blastn_nt_formatted.txt"

# Step 1: Create `Chordata_reBLAST` directory inside `BASE_DIR`
mkdir -p "$CHORDATA_BLAST_DIR"
cd "$ASV2TAXONOMY_DIR"

# Write subsetted taxonomy table into `Chordata_reBLAST`
awk -F'\t' 'NR==1 || $3 == "Chordata"' "${RESULTS_DIR}_asvTaxonomyTable.txt" > "$CHORDATA_BLAST_DIR/asvTaxonomyTable-filtered.txt"

# Step 2: Copy relevant files to `Chordata_reBLAST`, excluding large fastq files and PDFs
mkdir -p "$DADA2_SUBSET_DIR"
rsync -av --exclude='*.fastq.gz' --exclude='*.fq.gz' --exclude='*.pdf' "$DADA2_DIR/" "$DADA2_SUBSET_DIR/"

# Step 3: Generate a temporary ASV mapping file and rename ASVs to sequential numbers
awk 'BEGIN {count=1} NR>1 {print $1, "ASV_"count; count++}' "$CHORDATA_BLAST_DIR/asvTaxonomyTable-filtered.txt" > "$TEMP_MAPPING"

# Step 4a: Filter and rename ASVs in the FASTA file correctly
awk 'NR==FNR {map[$1]=$2; next} 
     /^>/ {header=$1; sub(/^>/,"",header); if (header in map) {print ">"map[header]; keep=1} else {keep=0}} 
     !/^>/ {if (keep) print}' "$TEMP_MAPPING" "$DADA2_DIR/ASVs.fa" > "$DADA2_SUBSET_DIR/ASVs.fa"

# Ensure no empty lines in FASTA
awk 'NF' "$DADA2_SUBSET_DIR/ASVs.fa" > "$DADA2_SUBSET_DIR/ASVs_cleaned.fa" && mv "$DADA2_SUBSET_DIR/ASVs_cleaned.fa" "$DADA2_SUBSET_DIR/ASVs.fa"

# Step 4b: Sort ASVs in sequential order (header + sequence pairs)
awk 'NR%2==1 {header=$0; getline; seq=$0; print header, seq}' "$DADA2_SUBSET_DIR/ASVs.fa" | sort -k1,1V | tr ' ' '\n' > "$DADA2_SUBSET_DIR/ASVs_sorted.fa"

# Replace the original file with the sorted version
mv "$DADA2_SUBSET_DIR/ASVs_sorted.fa" "$DADA2_SUBSET_DIR/ASVs.fa"

# Step 4c: Filter `ASVs_counts.tsv` to include only subset ASVs
awk 'NR==FNR {asvs[$2]; next} 
     FNR==1 || ($1 in asvs)' "$TEMP_MAPPING" "$DADA2_DIR/ASVs_counts.tsv" > "$DADA2_SUBSET_DIR/ASVs_counts.tsv"

# Step 5: Fix ASV names in `asvTaxonomyTable-filtered.txt` before running REVAMP
echo "🔹 Updating ASV names in asvTaxonomyTable-filtered.txt..."
awk 'NR==FNR {map[$1]=$2; next} 
     {if ($1 in map) $1=map[$1]; print}' "$TEMP_MAPPING" "$CHORDATA_BLAST_DIR/asvTaxonomyTable-filtered.txt" > "$CHORDATA_BLAST_DIR/asvTaxonomyTable-filtered_updated.txt"

mv "$CHORDATA_BLAST_DIR/asvTaxonomyTable-filtered_updated.txt" "$CHORDATA_BLAST_DIR/asvTaxonomyTable-filtered.txt"

# Step 6: Ensure required directories exist
mkdir -p "$BLAST_RESULTS_DIR" "$CHORDATA_BLAST_DIR/ASV2Taxonomy"

# Step 7: Change to `BASE_DIR` to ensure config files are found
cd "$BASE_DIR"

# Define config file names
CONFIG_FILE="01_config_file_${CONFIG_PREFIX}-reblast.txt"
FIGURE_CONFIG="02_figure_config_file_${CONFIG_PREFIX}.txt"
SAMPLE_METADATA="03_sample_metadata_${CONFIG_PREFIX}.txt"

# Step 7b: Copy config files to CHORDATA_BLAST_DIR with standard names
cp "$CONFIG_FILE" "$CHORDATA_BLAST_DIR/config_file.txt"
cp "$FIGURE_CONFIG" "$CHORDATA_BLAST_DIR/figure_config_file.txt"
cp "$SAMPLE_METADATA" "$CHORDATA_BLAST_DIR/sample_metadata.txt"

# Step 8a: Indicate that cutadapt and dada2 are already complete so REVAMP starts at BLAST
{
  echo "cutadaptFinished=TRUE"
  echo "dada2_Finished=TRUE"
  [[ -f "$BLAST_BTAB" ]] && echo "blastFinished=TRUE"
} > "$CHORDATA_BLAST_DIR/progress.txt"

# Step 8b: Run REVAMP with corrected paths and relative output
echo "🔹 Running REVAMP with corrected paths..."
if [[ -f "$BLAST_BTAB" ]]; then
  revamp.sh -p "$CONFIG_FILE" \
            -f "$FIGURE_CONFIG" \
            -s "$SAMPLE_METADATA" \
            -b "$(realpath --relative-to="$BASE_DIR" "$BLAST_BTAB")" \
            -r "$(realpath --relative-to="$BASE_DIR" "$REVAMP_DIR")" \
            -o "$(realpath --relative-to="$BASE_DIR" "$CHORDATA_BLAST_DIR")"
else
  revamp.sh -p "$CONFIG_FILE" \
            -f "$FIGURE_CONFIG" \
            -s "$SAMPLE_METADATA" \
            -r "$(realpath --relative-to="$BASE_DIR" "$REVAMP_DIR")" \
            -o "$(realpath --relative-to="$BASE_DIR" "$CHORDATA_BLAST_DIR")"
fi

# 🚀 Ensure REVAMP has fully completed before moving on
wait  

# Step 9: ✅ Now that REVAMP is done, merge reBLAST taxonomy back into MIDORI results

echo "🔹 Merging reBLAST taxonomy into original MIDORI results..."

# Define file paths with correct ASV2Taxonomy directory
MIDORI_ORIGINAL="$ASV2TAXONOMY_DIR/${RESULTS_DIR}_asvTaxonomyTable_NOUNKNOWNS.txt"
REBLASTED_TAXONOMY="$CHORDATA_BLAST_DIR/ASV2Taxonomy/${RESULTS_DIR}_Chordata_reBLAST_asvTaxonomyTable_NOUNKNOWNS.txt"
FINAL_COMBINED_TABLE="$CHORDATA_BLAST_DIR/${RESULTS_DIR}_Updated_asvTaxonomyTable.txt"

# Ensure necessary files exist
if [[ ! -f "$MIDORI_ORIGINAL" || ! -f "$REBLASTED_TAXONOMY" ]]; then
    echo "⚠️ ERROR: One or more required taxonomy files are missing!"
    exit 1
fi

# Restore original ASV names in the reBLASTed taxonomy and format to 8 tab-delimited columns
echo "🔹 Restoring original ASV names in reBLASTed taxonomy..."
awk 'BEGIN {OFS="\t"} NR==FNR {map[$2]=$1; next} {
  if (NR==1 || $1 in map) {
    if ($1 in map) $1 = map[$1];
    if (NF > 8) {
      $8 = $(NF-1) " " $NF;
      NF = 8
    }
    print
  }
}' "$TEMP_MAPPING" "$REBLASTED_TAXONOMY" > "$CHORDATA_BLAST_DIR/asvTaxonomyTable_reformatted.txt"

# Merge the reBLAST taxonomy into the original MIDORI table
echo "🔹 Integrating new taxonomy into original MIDORI results..."
awk '
    NR==FNR {new_tax[$1]=$0; next} 
    FNR==1 || !($1 in new_tax) {print} 
    $1 in new_tax {print new_tax[$1]}
' "$CHORDATA_BLAST_DIR/asvTaxonomyTable_reformatted.txt" "$MIDORI_ORIGINAL" > "$FINAL_COMBINED_TABLE"

echo "✅ Taxonomy integration complete! Updated table saved to:"
echo "   $FINAL_COMBINED_TABLE"
