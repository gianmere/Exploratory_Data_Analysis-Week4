library(dplyr)
library(ggplot2)

# Download the data file
filepath <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(filepath, "data.zip", method = "curl")
unzip("data.zip")

# Load the datatable
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter the ON-ROAD emissions for the Baltimore City
baltimoreCityData = filter(NEI, fips == 24510 & type == "ON-ROAD")

# Group the emissions for year and calculate the total of emissions
emissionForYear <- baltimoreCityData %>% group_by(year) %>% summarize(emission_total = sum(Emissions))

# Set the year as factor
emissionForYear$year <- as.factor(emissionForYear$year)

# Draw the graph and save a png file
png(file="plot5.png", width = 640)
g <- ggplot(emissionForYear, aes(year, emission_total))
p <- g + geom_col(aes(fill = year)) + xlab("Years") + ylab("Emissions (in tons)") + ggtitle("Emissions from motor vehicle sources in Baltimore City")
print(p)
dev.off()