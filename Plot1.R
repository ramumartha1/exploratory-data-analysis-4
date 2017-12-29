library(data.table)
library(plyr)
library(ggplot2)

## File Download to current working directory
    fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL,destfile="./dataset.zip",method="curl")
    unzip(zipfile = "./dataset.zip")
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    NEI$Emissions <- as.numeric(as.character(NEI$Emissions))
    NEI$year <- as.factor(as.character(NEI$year))
    
    Total_pm25 <- with(NEI,tapply(Emissions,year,sum,na.rm=TRUE))
    
    plot(Total_pm25, x = rownames(Total_pm25), type = "l", col ="blue",lwd =2,
         ylab = "Total PM2.5 Emission (in tons)", xlab = "Year", main="Total PM2.5 Emission Trend for USA")
    dev.copy(png,file="Plot1.png",width =480, height =480)
    dev.off()