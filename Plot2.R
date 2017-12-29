library(data.table)
library(plyr)
library(ggplot2)

## File Download to current working directory
    fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL,destfile="./dataset.zip",method="curl")
    unzip(zipfile = "./dataset.zip")
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    NEI$year <- as.factor(as.character(NEI$year))
    
    Bsub <- subset(NEI, fips == "24510")    
    Bsub$Emissions <- as.numeric(as.character(Bsub$Emissions))
    
## PM2.5 Emisson Levels due to different sorces at over period of time in Baltimore City    

    Bsub$type <- as.factor(as.character(Bsub$type))
    
    Baltimore_pm25 <- with(Bsub,tapply(Emissions,as.factor(year),sum,na.rm=TRUE))
    plot(Baltimore_pm25, x = rownames(Baltimore_pm25), type = "l", col ="blue",lwd =2,
         ylab = "Total PM2.5 Emission (in tons)", xlab = "Year", main=" Baltimore Total PM2.5 Emission Trend")
    dev.copy(png,file="Plot2.png",width =480, height =480)
    dev.off()
