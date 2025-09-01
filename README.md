# Rice’s Whale Genomics  
 
## Overview  
This repository contains scripts and supporting materials from a capstone research project on the population genomics of the Rice’s whale (*Balaenoptera ricei*). The Rice’s whale is a recently recognized and critically endangered baleen whale species endemic to the northern Gulf of Mexico, with fewer than 100 individuals remaining. This project applies whole-genome sequencing and comparative genomics to investigate genetic diversity, evolutionary history, and ancestry.  

The repository includes the scientific report (PDF) formatted as a research paper and scripts I created for **visualizing genome-wide diversity (Dxy), ADMIXTURE analysis, and whole-genome alignments**. Much of the project’s work involved **extensive preprocessing in Bash** (genome alignment, SNP calling, VCF thinning, windowing, etc.), but the scripts here represent the visualization components I developed to explore divergence, ancestry patterns, and genome alignment.  

> **Note**: This study is ongoing in the Lohmueller Laboratory at UCLA. In accordance with publication requirements, critical data and detailed results have been removed from this repository until the final manuscript is published.  

## Project Goals  
- Characterize the genetic diversity and evolutionary history of *B. ricei*  
- Compare Rice’s whale genomes to closely related baleen whale species and outgroups  
- Quantify divergence using window-based Dxy statistics  
- Infer population structure and ancestral proportions using ADMIXTURE  
- Visualize genome-wide alignments between Rice’s whales and related species  
- Contribute genomic insights toward conservation strategies for this critically endangered species  

## Features  
- **Genomic Report**: Full scientific manuscript with abstract, introduction, methods, results, discussion, and conclusion  
- **Genome Alignment Visualization**: Bash pipeline using MUMmer to compare and visualize whole-genome alignments  
- **Dxy Analysis**: R pipeline for calculating and plotting pairwise divergence (Dxy) across chromosomes  
- **ADMIXTURE Visualization**: Script to generate stacked barplots of ancestry proportions for multiple K values  

## Scripts  

### 1. `mummerAlignment.sh`  
**Purpose**: Perform whole-genome alignments between Rice’s whales and related baleen whale species using MUMmer  
  - Runs `nucmer` to align Rice’s whale genome to outgroup genomes  
  - Applies `delta-filter` for high-identity alignments  
  - Generates whole-genome alignment plots with `mummerplot`  

**Output**: Filtered delta files and alignment plots in `.png` format  

### 2. `Species-Outgroup_Dxy.R`  
**Purpose**: Calculate and plot Dxy (average nucleotide differences) between Rice’s whales and outgroup species across 1Mb genomic windows  
  - Loads SNP count files  
  - Computes genotype counts and Dxy values per window    
  - Produces genome-wide Dxy plots faceted by chromosome  

**Output**: Barplots of Dxy across chromosomes with mean divergence values annotated  

### 3. `admixturePlot.R`  
**Purpose**: Generate barplots of ADMIXTURE ancestry proportions for Rice’s whales and outgroups  
  - Reads `.fam` file and cleans sample names  
  - Reads `.Q` files from ADMIXTURE for K=2 through K=8  
  - Reorders samples into biologically meaningful order  
  - Produces stacked barplots of ancestry for each K  

**Output**: Comparative plots of genetic clustering across individuals and species  

### 4. `Capstone_Report.pdf`  
**Purpose**: Written scientific report documenting the study  
  - Includes abstract, introduction, methods, discussion, and conclusion  
  - Summarizes project goals, methods, and preliminary results  
  - Designed in the format of a peer-reviewed research paper  

## Methods  
- **Genomic Data**: Whole-genome sequencing and alignment of Rice’s whale samples and outgroups  
- **Analyses**:  
  - Genome-to-genome alignment with **BWA-MEM2** and **Picard**  
  - SNP calling and filtering with **bcftools**  
  - Windowing with **bedtools** and Bash scripts  
  - Dxy calculations and visualization in **R**  
  - Genome-wide alignment visualization with **MUMmer/nucmer** (`mummerAlignment.sh`)  
  - Ancestry inference with **ADMIXTURE**  
- **Tools & Frameworks**:  
  - Bash (data preprocessing, alignment, SNP calling)  
  - R (ggplot2, plyr) for visualization  
  - ADMIXTURE for population structure inference  
  - MUMmer for whole-genome alignment  

## Acknowledgements  
I would like to extend my deepest gratitude to **Dr. Kirk Lohmueller**, Principal Investigator of the Lohmueller Laboratory at UCLA, for providing me with the opportunity to conduct this research and for offering guidance, support, and expertise throughout the course of this project. I am especially grateful to **Dr. Diana Aguilar Gomez**, postdoctoral fellow in the Lohmueller Laboratory, for her mentorship, thoughtful feedback, and encouragement at every stage of this study.  
