### Exploratory Data Analysis: Assignment 4:Course Project

### Question: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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


### To answer this question, we only need to focus on one city, the city of Baltimore which has the fips==24510 and 
### since we want to look at emissions from motor vechile sources, we need to only focus on the type=="ON-ROAD"

### So we just subset the NEI data by setting fips==24510 and type=="ON-ROAD"

### Subsetting

baltimore<- subset(NEI,NEI$fips=="24510" & NEI$type=="ON-ROAD")
head(baltimore)

### Now we have to aggregate the total emissions by year:

totalbaltimore<- aggregate(baltimore$Emissions,by=list(baltimore$year),FUN=sum)
names(totalbaltimore)[names(totalbaltimore)=="Group.1"]<- "Years"
names(totalbaltimore)[names(totalbaltimore)=="x"]<- "Emissions"

### We will use ggplot to plot the change in the emission due to vehicles for the city of Baltimore:

dev.off()

library(ggplot2)
gdata<- ggplot(totalbaltimore, aes(factor(Years),Emissions))

png("C:\\Users\\das90\\OneDrive\\Coursera courses\\John Hopkins\\R Codes and Files\\Exploratory Data Analysis\\Data-Science-Specialization-with-R-Exploratory-Data-Analysis\\plot5.png")


gdata + geom_bar(stat = "identity") + xlab("Years") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle("Total emissions in Baltimore due to vehicles")

dev.off()


