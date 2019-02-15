# unzip the file
zipfile_data = "C:/Users/Asus/Desktop/DOST/exdata_data_NEI_data.zip"
  
unzip(zipfile_data,exdir="./data")


# Check if the files exist and read it
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# Check if the merged datasets exist; if not merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

install.packages("ggplot2")
library(ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# fetch all NEIxSCC records with Short.Name (SCC) Coal
coal_matches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subset_neiscc <- NEISCC[coal_matches, ]

agg_tot_yr <- aggregate(Emissions ~ year, subset_neiscc, sum)

png("plot4.png", width=640, height=480)
gplt <- ggplot(agg_tot_yr, aes(factor(year), Emissions))
gplt <- gplt + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(gplt)
dev.off()
