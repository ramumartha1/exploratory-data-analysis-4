library(data.table)
library(plyr)
library(ggplot2)

## File Download to current working directory
    fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL,destfile="./dataset.zip",method="curl")
    unzip(zipfile = "./dataset.zip")
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")


## PM2.5 Emisson Levels due to Motor vehicles in Balitmore City
    Bsub <- subset(NEI, fips == "24510")
    vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
    vehiclesSCC <- SCC[vehicles,]$SCC
    vehicles_Balti <- Bsub[Bsub$SCC %in% vehiclesSCC,]
    
    Baltimore_motor_pm25 <- with(vehicles_Balti,tapply(Emissions,as.factor(year),sum,na.rm=TRUE))
    plot(Baltimore_motor_pm25, x = rownames(Baltimore_motor_pm25), type = "l", col ="blue",lwd =2,
         ylab = "Total PM2.5 Emission due to Motor Vehicles (in tons)", xlab = "Year", 
         main="Total PM2.5 Emission Levels Due to Motor Vehicles In Baltimore")
    dev.copy(png,file="Plot5.png",width =700, height =490)
    dev.off()