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
install.packages("ggplot2")
library(ggplot2)

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# 24510 is Baltimore, see plot2.R
subset_nei <- NEI[NEI$fips=="24510", ]

agg_tot_yr_type <- aggregate(Emissions ~ year + type, subset_nei, sum)

png("plot3.png", width=640, height=480)
gplt <- ggplot(agg_tot_yr_type, aes(year, Emissions, color = type))
gplt <- gplt + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(gplt)
dev.off()
