library(RColorBrewer)
library(dplyr)

# Download the data file
filepath <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(filepath, "data.zip", method = "curl")
unzip("data.zip")

# Load the datatable
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter the ON-ROAD emissions for Baltimore City
baltimoreCityData = filter(NEI, fips == "24510" & type == "ON-ROAD")
# Calculate the sum of the emissions for Baltimore City
baltimoreCitySumEmissionsForYear <- tapply(baltimoreCityData$Emissions, baltimoreCityData$year, sum)

# Filter the ON-ROAD emissions for Los Angeles
losAngelesData = filter(NEI, fips == "06037" & type == "ON-ROAD")
# Calculate the sum of the emissions for Los Angeles
losAngelesDataSumEmissionsForYear <- tapply(losAngelesData$Emissions, losAngelesData$year, sum)
data <- rbind(baltimoreCitySumEmissionsForYear,losAngelesDataSumEmissionsForYear)

# Draw the graph and save a png file
lim=1.2*max(data)
png(file="plot6.png")
barplot(data, ylim=c(0,lim), beside=T, col=c("blue" , "skyblue") , main = "Emissions from motor vehicle sources \nin Baltimore City and Los Angeles", ylab = "Emissions (in tons)", xlab = "Years")
legend("topright", legend = c("Baltimore City", "Los Angeles"), fill = c("blue", "skyblue"))
dev.off()