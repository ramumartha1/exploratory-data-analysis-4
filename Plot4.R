library(data.table)
library(plyr)
library(ggplot2)

## File Download to current working directory
    fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL,destfile="./dataset.zip",method="curl")
    unzip(zipfile = "./dataset.zip")
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
## PM2.5 Emisson Levels due toCoal Combustion-related Sources In USA
    NEI_coal<- NEI[which(NEI$SCC %in% SCC[grep("coal",SCC$Short.Name,ignore.case = TRUE),"SCC"]),]
    NEI_coal_pm25 <- with(NEI_coal,tapply(Emissions,as.factor(year),sum,na.rm=TRUE))
    plot(NEI_coal_pm25, x = rownames(NEI_coal_pm25), type = "l", col ="blue",lwd =2,
         ylab = "Total PM2.5 Emission due to Coal (in tons)", xlab = "Year", 
         main="Total PM2.5 Emissions Due to Coal Combustion-related Sources In USA")
    dev.copy(png,file="plot4.png",width =700, height =490)
    dev.off()