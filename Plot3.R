library(data.table)
library(plyr)
library(ggplot2)

## File Download to current working directory
    fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL,destfile="./dataset.zip",method="curl")
    unzip(zipfile = "./dataset.zip")
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    

## PM2.5 Emisson Levels due to different sorces at over period of time in Baltimore City
    Bsub <- subset(NEI, fips == "24510")
    Baltimore_type_PM25 <- with(Bsub,tapply(Emissions,type,sum,na.rm=TRUE))
    g<-ggplot(Bsub,aes(year,Emissions,color=type))
    g+geom_line(stat = "summary",fun.y="sum", size=1.5)+ labs(y="Emissions for Baltimore City ",
                                                              x="Year (1999 - 2008)")
    
    dev.copy(png,file="Plot3.png",width =480, height =480)
    dev.off()
