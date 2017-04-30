library(RColorBrewer)

# Download the data file
filepath <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(filepath, "data.zip", method = "curl")
unzip("data.zip")

# Load the datatable
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the sum of the emissions
sumEmissionsForYear <- tapply(NEI$Emissions, NEI$year, sum)

# Draw the graph and save a png file
png(file="plot1.png")
barplot(sumEmissionsForYear/1000000, main = "Total PM2.5 emissions in the United State", ylab = "Emissions (in milion of tons)", xlab = "Years", col=brewer.pal(4,"Set2"))
dev.off()