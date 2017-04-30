library(dplyr)
library(ggplot2)
library(RColorBrewer)

# Download the data file
#filepath <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(filepath, "data.zip", method = "curl")
#unzip("data.zip")

# Load the datatable
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### "Coal combustion-related sources" are taken from the data.frame SCC, where the column "EI.Sector" contains the word "Coal"

uniqueSector <- unique(SCC$EI.Sector)
coalSectorIndex <- grep("[Cc]oal",uniqueSector)

coalSector <- SCC$EI.Sector %in% uniqueSector[coalSectorIndex]
sccCode <- SCC[coalSector,]$SCC

selectedIndexNEI <- NEI$SCC %in% sccCode
selectedNEI <- NEI[selectetIndexNEI,]
#selectedNEI$fips <- as.factor(selectedNEI$fips)

boxplot(Emissions ~ year, selectedNEI) 

#selectedNEI1999 <- filter(selectedNEI, year == "1999")
#selectedNEI2002 <- filter(selectedNEI, year == "2002")
#selectedNEI2005 <- filter(selectedNEI, year == "2005")
#selectedNEI2008 <- filter(selectedNEI, year == "2008")

#colors <- brewer.pal(4,"Set3")

#par(mfrow = c(2, 2))

#with(selectedNEI1999,plot(fips, Emissions, type="n"))
#with(subset(selectedNEI1999, type == "POINT"), points(fips, Emissions, col = addalpha(colors[1],0.5)))


#plot(selectedNEI2002$fips, selectedNEI2002$Emissions)


#plot(selectedNEI2005$fips, selectedNEI2005$Emissions)


#plot(selectedNEI2008$fips, selectedNEI2008$Emissions)