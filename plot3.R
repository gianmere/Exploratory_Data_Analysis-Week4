library(dplyr)
library(ggplot2)

# Download the data file
filepath <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(filepath, "data.zip", method = "curl")
unzip("data.zip")

# Load the datatable
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter the emissions for the Baltimore City
baltimoreCityData = filter(NEI, fips == 24510)

# Group the emissions for year and type, then calculate the total of emissions
emissionForYearAndType <- baltimoreCityData %>% group_by(year) %>% group_by(type, add=T) %>% summarize(emission_total = sum(Emissions))

# Set the year as factor
emissionForYearAndType$year <- as.factor(emissionForYearAndType$year)

# Draw the graph and save a png file
png(file="plot3.png", width = 640)
g <- ggplot(emissionForYearAndType, aes(year, emission_total))
p <- g + geom_col(aes(fill = year)) + facet_grid(. ~ type) + xlab("Years") + ylab("Emissions (in tons)") + ggtitle("Emissions from PM2.5 in Baltimore City for type")
print(p)
dev.off()