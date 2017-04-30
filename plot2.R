library(RColorBrewer)
library(dplyr)

# Download the data file
filepath <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(filepath, "data.zip", method = "curl")
unzip("data.zip")

# Load the datatable
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the sum of the emissions in Baltimore City
baltimoreCityData = filter(NEI, fips == 24510)
baltimoreCitySumEmissionsForYear <- tapply(baltimoreCityData$Emissions, baltimoreCityData$year, sum)

# Draw the graph and save a png file
png(file="plot2.png")
barplot(baltimoreCitySumEmissionsForYear, main = "Total PM2.5 emissions in Baltimore City", ylab = "Emissions (in tons)", xlab = "Years", col=brewer.pal(4,"Set1"))
dev.off()