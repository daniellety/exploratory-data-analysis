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

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# 24510 is Baltimore (see plot2.R) and 06037 is LA CA
# Searched for ON-ROAD type in NEI

subset_nei <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

agg_tot_yr_fips <- aggregate(Emissions ~ year + fips, subset_nei, sum)
agg_tot_yr_fips$fips[agg_tot_yr_fips$fips=="24510"] <- "Baltimore, MD"
agg_tot_yr_fips$fips[agg_tot_yr_fips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
gplt <- ggplot(agg_tot_yr_fips, aes(factor(year), Emissions))
gplt <- gplt + facet_grid(. ~ fips)
gplt <- gplt + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(gplt)
dev.off()
