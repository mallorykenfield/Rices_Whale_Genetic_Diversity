# Preprocessing was done in the terminal to thin VCFs and generate the .fam file
# (this file just lists each sample/individual with some basic info)

library(ggplot2)

# Read in the sample information file (.fam)
data <- read.table("Species_and_Outgroups.fam")

# Clean up and shorten sample names to make them easier to read in plots
data[,1] <- gsub("Bede", "Bric", data[,1])
data[,1] <- gsub("bborealis", "Bbor", data[,1])
data[,1] <- gsub("bbryde", "Bbry", data[,1])
data[,1] <- gsub("bmusculus", "Bmus", data[,1])
data[,1] <- gsub("bphysalusF", "Bphy", data[,1])
data[,1] <- gsub("z0005313", "Bede5313", data[,1])
data[,1] <- gsub("z0017381", "Bede7381", data[,1])
data[,1] <- gsub("z0009880", "Bbry9880", data[,1])
data[,1] <- gsub("z0015034", "Bbry5034", data[,1])
data[,1] <- gsub("z0026365", "Bbry6365", data[,1])

# Store the cleaned sample names
sampling <- data[,1]

# Show the sample names (optional, just for checking)
sampling

# Define the order we want the samples/species to appear in the plots
desiredorderids <- c("Bric001","Bric002","Bric003","Bric004","Bric005","Bric007",
                     "Bric008","Bric011","Bric015","Bric016","Bric021","Bric022",
                     "Bric023","Bric024","Bric031","Bric033","Bric034","Bric035",
                     "Bric037","Bric039","Bric040","Bric042","Bric043","Bric044", 
                     "Bede7381","Bede5313","Bbry","Bbry9880","Bbry5034","Bbry6365",
                     "Bbor","Bphy8918","Bphy8919","Bmus")

# Create an empty list to store results from each run
runs <- list()

# Read in the ADMIXTURE output files (.Q), one for each K (number of clusters)
for (i in 1:8){
  # Read in ancestry proportion file for this run
  tempdf <- read.table(paste0("Species_and_Outgroups.", i, ".Q"))
  temp <- as.data.frame(tempdf)
  
  # Add the sample names to the ancestry proportions
  temp$names <- sampling
  
  # Reorder rows so samples match the order we defined above
  temp <- temp[order(match(temp$names, desiredorderids)), ]
  
  # Save this run into the list
  runs[[i]] <- temp
}

# Set up plotting area for 8 stacked plots
par(mfrow=c(8,1), mar=c(0.3, 1.5, .3, 1), mgp=c(0, 1, 0)) 

# Define color palette for different clusters
cbPalette <- c('lightyellow',"#3232D6","#F5A623", "#7ED321" ,"#C493FA", "#EC87C0",'grey',"#56B4E9")

# Make barplots of ancestry proportions for each run
for (i in 2:8){
  if(i==8){
    # Plot K=8 with sample names on the x-axis
    barplot(t(as.matrix(runs[[i]])), col=cbPalette, ylab="K=8", border="black",
            names.arg=desiredorderids, las=2, cex.names=1, yaxt="n")
  }
  else{
    # Plot K=2 through K=7 (without sample names to keep plots cleaner)
    barplot(t(as.matrix(runs[[i]])), col=cbPalette, ylab=paste("K=", i, sep=""), border="black", yaxt="n")
  }
}
  else{
    barplot(t(as.matrix(runs[[i]])), col=cbPalette, ylab=paste("K=", i, sep=""), border="black", yaxt="n")
  }
}
