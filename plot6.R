### Exploratory Data Analysis: Assignment 4:Course Project

### Question: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
### in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips == "06037"). Which city has seen greater 
### changes over time in motor vehicle emissions?

### Answer:

### Setting working directory

setwd("C:\\Users\\das90\\OneDrive\\Coursera courses\\John Hopkins\\R Codes and Files\\Exploratory Data Analysis\\Data-Science-Specialization-with-R-Exploratory-Data-Analysis")


### Reading the data into R

NEI<- as.data.frame(readRDS("C:\\Users\\das90\\OneDrive\\Coursera courses\\John Hopkins\\R Codes and Files\\Exploratory Data Analysis\\Data-Science-Specialization-with-R-Exploratory-Data-Analysis\\exdata_data_NEI_data\\summarySCC_PM25.rds"))
SCC<- as.data.frame(readRDS("C:\\Users\\das90\\OneDrive\\Coursera courses\\John Hopkins\R Codes and Files\\Exploratory Data Analysis\\Data-Science-Specialization-with-R-Exploratory-Data-Analysis\\exdata_data_NEI_data\\Source_Classification_Code.rds"))


### Exploring the data

dim(NEI)
str(NEI)
names(NEI)

### So NEI has 6497651 observations and 6 columns: The columns names are fips,SCC,Pollutant, Emissions,type,Year

dim(SCC)
str(SCC)
colnames(SCC)


### Here we neeed to focus on Baltimore and Los-Angeles and look at emissions due to vehicles. So we need to subset 
### the data by setting fips==24510 for Baltimore and fips == "06037" for Los Angeles and type=="ON-ROAD" as the
### type of emissions.

### Subsetting

subdata<- subset(NEI,(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD")
head(subdata)


### Now we need to find the total emissions by year and by location:

totalemission<- aggregate(subdata$Emissions,by=list(subdata$year,subdata$fips),FUN=sum)
names(totalemission)[names(totalemission)=="Group.1"]<- "Year"
names(totalemission)[names(totalemission)=="Group.2"]<- "Location"
names(totalemission)[names(totalemission)=="x"]<- "Emission"
totalemission$Location[totalemission$Location=="06037"]<- "Los Angeles,CA"
totalemission$Location[totalemission$Location=="24510"]<- "Baltimore,MD"
head(totalemission)


### Now we plot the emissions for the two locations by year using ggplot:

library(ggplot2)

gdata<- ggplot(totalemission,aes(factor(Year),Emission))


png("C:\\Users\\das90\\OneDrive\\Coursera courses\\John Hopkins\\R Codes and Files\\Exploratory Data Analysis\\Data-Science-Specialization-with-R-Exploratory-Data-Analysis\\plot6.png")

gdata + facet_grid(.~Location) + geom_bar(stat = "identity") + xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle("Comparision of Total Emission due to Vehicles Between Baltimore and LA")

dev.off()