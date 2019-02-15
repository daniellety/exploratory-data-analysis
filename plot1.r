setwd ("C:/Users/Asus/Desktop/DOST")

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

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

agg_tot_yr <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')
barplot(height=agg_tot_yr$Emissions, names.arg=agg_tot_yr$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()
