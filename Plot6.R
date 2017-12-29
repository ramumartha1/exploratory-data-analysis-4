library(data.table)
library(plyr)
library(ggplot2)

## File Download to current working directory
    fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL,destfile="./dataset.zip",method="curl")
    unzip(zipfile = "./dataset.zip")
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")


## PM2.5 Emisson Levels due to Motor vehicles in Balitmore City & Los Angeles 
    Bsub <- subset(NEI, fips == "24510")
    vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
    vehiclesSCC <- SCC[vehicles,]$SCC
    vehicles_Balti <- Bsub[Bsub$SCC %in% vehiclesSCC,]
    
    LAsub <- subset(NEI, fips == "06037")
    vehicles_LA <- LAsub[LAsub$SCC %in% vehiclesSCC,]
    
    Two_City_Vehicles_PMs <- rbind (vehicles_Balti,vehicles_LA )
    
    g<-ggplot(Two_City_Vehicles_PMs,aes(year,Emissions,color=fips))
    g+geom_line(stat = "summary",fun.y="sum", size=1.5)+ 
        labs(title = "Emissions from motor vehicle for Los Angeles and Baltimore City",
             y="Total PM2.5 Emission due to Motor Vehicles (in tons)",x="Year")+
        scale_colour_discrete(name = "City",label = c("Los Angeles","Baltimore"))
    dev.copy(png,file="plot6.png",width =700, height =490)
    dev.off()