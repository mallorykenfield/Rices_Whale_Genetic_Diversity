#Rices
genome1=/path/to/file/rices.fna
#Sei
genome2=/path/to/file/sei.fasta 
#Brydes
genome2=/path/to/file/brydes.fa 

#suffix for all of the output files
suffix=Rices-Sei
suffix=Rices-Brydes

/u/home/m/mkenfiel/bin/mummer-4.0.0rc1/nucmer -t 10 -c 4000 -p $suffix $genome1 $genome2
/u/home/m/mkenfiel/bin/mummer-4.0.0rc1/delta-filter -1 -i 99 -l 30000 $suffix.delta > $suffix.filter95.l10.delta

/u/home/m/mkenfiel/bin/mummer-4.0.0rc1/mummerplot --png --large -p $suffix.95.l10 $suffix.filter95.l10.delta --layout
