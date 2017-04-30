library(dplyr)
library(ggplot2)
library(RColorBrewer)

# Download the data file
filepath <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(filepath, "data.zip", method = "curl")
unzip("data.zip")

# Load the datatable
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### "Coal combustion-related sources" are taken from the data.frame SCC, where the column "EI.Sector" contains the word "Coal"
uniqueSector <- unique(SCC$EI.Sector)
coalSectorIndex <- grep("[Cc]oal",uniqueSector)

coalSector <- SCC$EI.Sector %in% uniqueSector[coalSectorIndex]
sccCode <- SCC[coalSector,]$SCC

selectedIndexNEI <- NEI$SCC %in% sccCode
selectedNEI <- NEI[selectedIndexNEI,]
# Calculate the total of emissions for year
selectedNEIForYear <- tapply(selectedNEI$Emissions, selectedNEI$year, sum)

# Draw the graph and save a png file
png(file="plot4.png")
barplot(selectedNEIForYear/1000, main = "Total emissions from coal combustion-related sources \n in the United States", ylab = "Emissions (in thousands of tons)", xlab = "Years", col=brewer.pal(4,"Set1"))
dev.off()