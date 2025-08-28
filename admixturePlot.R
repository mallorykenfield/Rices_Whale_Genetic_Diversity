# Preprossessing was done in the terminal to thin VCFs and generate the .fam file

library(ggplot2)

#read in input file: 
data <- read.table("Species_and_Outgroups.fam")
#editing sample names
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

sampling<-data[,1]

#get list of input samples in order they appear
sampling

#set desired order of species names
desiredorderids<-c("Bric001","Bric002","Bric003","Bric004","Bric005","Bric007",
                   "Bric008","Bric011","Bric015","Bric016","Bric021","Bric022",
                   "Bric023","Bric024","Bric031","Bric033","Bric034","Bric035",
                   "Bric037","Bric039","Bric040","Bric042","Bric043","Bric044", 
                   "Bede7381","Bede5313","Bbry","Bbry9880","Bbry5034","Bbry6365",
                   "Bbor","Bphy8918","Bphy8919","Bmus")

#sort and read in log files
runs <- list()

#read in all runs and save each dataframe in a list
for (i in 1:8){
  tempdf <- read.table(paste0("Species_and_Outgroups.", i, ".Q"))
  temp <- as.data.frame(tempdf)
  
  # Add sample names
  temp$names <- sampling
  
  # Sort according to desiredorderids
  temp <- temp[order(match(temp$names, desiredorderids)), ]
  
  # Store sorted data frame in list
  runs[[i]] <- temp
}


#plot runs 1:8
par(mfrow=c(8,1), mar=c(0.3, 1.5, .3, 1), mgp=c(0, 1, 0)) 
cbPalette <- c('lightyellow',"#3232D6","#F5A623", "#7ED321" ,"#C493FA", "#EC87C0",'grey',"#56B4E9")

for (i in 2:8){
  if(i==8){
    barplot(t(as.matrix(runs[[i]])), col=cbPalette, ylab="K=8", border="black",
            names.arg=desiredorderids, las=2, cex.names=1, yaxt="n")
  }
  else{
    barplot(t(as.matrix(runs[[i]])), col=cbPalette, ylab=paste("K=", i, sep=""), border="black", yaxt="n")
  }
}
