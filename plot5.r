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

library(ggplot2)

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# 24510 is Baltimore, see plot2.R
# Searched for ON-ROAD type in NEI

subset_nei <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

agg_tot_yr <- aggregate(Emissions ~ year, subset_nei, sum)

png("plot5.png", width=840, height=480)
gplt <- ggplot(agg_tot_yr, aes(factor(year), Emissions))
gplt <- gplt + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(gplt)
dev.off()
