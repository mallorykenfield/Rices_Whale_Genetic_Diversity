#!/bin/bash

# --------------------------------------------
# Whole-genome alignment script using MUMmer4
# Aligns Rice’s whale genome to outgroup whale genomes
# Generates filtered alignment and plots
# --------------------------------------------

# Path to Rice’s whale genome
genome1=/path/to/file/rices.fna

# Paths to outgroup genomes
genome2=/path/to/file/sei.fasta    # Sei whale
genome2=/path/to/file/brydes.fa    # Bryde’s whale

# Output file suffixes for different alignments
suffix=Rices-Sei
suffix=Rices-Brydes

# --------------------------------------------
# Step 1: Align genomes using nucmer
# -t 10 : use 10 threads
# -c 4000 : minimum cluster length of 4000 bp
# -p $suffix : prefix for output files
# --------------------------------------------
/u/home/m/mkenfiel/bin/mummer-4.0.0rc1/nucmer -t 10 -c 4000 -p $suffix $genome1 $genome2

# --------------------------------------------
# Step 2: Filter alignments using delta-filter
# -1 : report only 1-to-1 alignments
# -i 99 : minimum 99% identity
# -l 30000 : minimum alignment length of 30 kb
# Output redirected to filtered delta file
# --------------------------------------------
/u/home/m/mkenfiel/bin/mummer-4.0.0rc1/delta-filter -1 -i 99 -l 30000 $suffix.delta > $suffix.filter95.l10.delta

# --------------------------------------------
# Step 3: Generate alignment plots using mummerplot
# --png : output plot as PNG
# --large : use large font and size for better readability
# -p $suffix.99.l30 : prefix for plot files
# --layout : use layout mode for large-scale genome visualization
# --------------------------------------------
/u/home/m/mkenfiel/bin/mummer-4.0.0rc1/mummerplot --png --large -p $suffix.95.l10 $suffix.filter99.l30.delta --layout
