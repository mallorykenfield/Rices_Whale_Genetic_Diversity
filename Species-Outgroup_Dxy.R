# Load necessary libraries
library(ggplot2)
library(plyr)

# Define functions to read in SNP count files and calculate Dxy
Outgroup1 <- function(samplename) { 
  # Load SNP count file for Outgroup 1 (1Mb windows across the genome)
  originalFile <- read.delim(paste0("~/Path/to/File/", samplename, "_Outgroup1_Species_SNPcount_allChroms_1Mb.txt"), header=FALSE, sep='')
  
  # Add column names for readability
  data <- originalFile
  colnames(data) <- c('chrom','start','end',"het", "ref_homo", "alt_homo", "missing")
  
  # Calculate total number of genotype calls per window
  data$total_g <- rowSums(data[, c(4,5,6)], na.rm=TRUE)
  
  # Calculate Dxy: average number of nucleotide differences per site
  data$dxy <- with(data, (het + 2*alt_homo) / (2*total_g))
  
  return(data)
}

Outgroup2 <- function(samplename) { 
  # Same process as above but for Outgroup 2
  originalFile <- read.delim(paste0("~/Path/to/File/", samplename, "_Outgroup2_Species_SNPcount_allChroms_1Mb.txt"), header=FALSE, sep='')
  data <- originalFile
  colnames(data) <- c('chrom','start','end',"het", "ref_homo", "alt_homo", "missing")
  data$total_g <- rowSums(data[, c(4,5,6)], na.rm=TRUE)
  data$dxy <- with(data, (het + 2*alt_homo) / (2*total_g))
  return(data)
}

Outgroup3 <- function(samplename) { 
  # Same process as above but for Outgroup 3
  originalFile <- read.delim(paste0("~/Path/to/File/", samplename, "_Outgroup3_Species_SNPcount_allChroms_1Mb.txt"), header=FALSE, sep='')
  data <- originalFile
  colnames(data) <- c('chrom','start','end',"het", "ref_homo", "alt_homo", "missing")
  data$total_g <- rowSums(data[, c(4,5,6)], na.rm=TRUE)
  data$dxy <- with(data, (het + 2*alt_homo) / (2*total_g))
  return(data)
}

########################################################################################
# Load the data for a specific sample (replace XXX with your sample ID)

# Example: Outgroup 1
outgroup1_sampleXXX <- Outgroup1("outgroup1XXX")
data <- outgroup1_sampleXXX
title <- "outgroup1_sampleXXX"

# Example: Outgroup 2
outgroup2_sampleXXX <- Outgroup2("outgroup2XXX")
data <- outgroup2_sampleXXX
title <- "outgroup2_sampleXXX"

# Example: Outgroup 3
outgroup3_sampleXXX <- Outgroup3("outgroup3XXX")
data <- outgroup3_sampleXXX
title <- "outgroup3_sampleXXX"

########################################################################################
# Clean up data before plotting

# Replace missing values (NaN) with zeros
data$dxy[is.nan(data$dxy)] <- 0

# Format chromosome names so they plot in numerical order
data$chromosome <- gsub("chr", "", data$chrom)       # remove "chr" prefix
data$chrom_num <- as.numeric(data$chromosome)        # convert to numbers
data <- data[order(data$chrom_num), ]                # sort by chromosome number
data$chromosome <- factor(data$chromosome, levels = unique(data$chromosome)) 

########################################################################################
# Create the Dxy plot

# Define alternating colors for chromosomes (choose one set depending on outgroup)
colors <- c(rep(c("#F5A623", "darkorange3"), length.out = 21)) # Outgroup 1
colors <- c(rep(c("#7ED321", "forestgreen"), length.out = 21)) # Outgroup 2
colors <- c(rep(c("#56B4E9", "blue"), length.out = 21))        # Outgroup 3

ggplot(data, aes(x = start, y = dxy, color = chromosome, fill = chromosome)) + 
  geom_bar(stat = "identity") +  # plot Dxy values as bars
  labs(x = "Chromosome (1Mb windows)", y = "Dxy") +  
  theme_bw() +  # clean background
  scale_x_continuous(expand = c(0, 0)) +  
  scale_y_continuous(expand = c(0, 0)) +  
  scale_color_manual(values = colors) + 
  scale_fill_manual(values = colors) + 
  ylim(0,.01) +
  ggtitle(paste(title,"mean =",round(mean(data$dxy),6))) + # add sample name + mean Dxy
  facet_wrap(
    ~chromosome, 
    scales = "free_x", 
    ncol = 21, 
    strip.position = "bottom"  # plot each chromosome separately
  ) + 
  theme(
    axis.text.x = element_blank(),    # remove x-axis labels
    axis.ticks.x = element_blank(),   # remove x-axis ticks
    legend.position = "none", 
    panel.spacing = unit(0, "lines"), # no spacing between chromosomes
    panel.border = element_blank(),   
    panel.grid = element_blank(),     # remove grid
    strip.background = element_blank(),
    strip.text.x = element_text(size = 8)  # smaller chromosome labels
  )
