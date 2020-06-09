### Exploratory Data Analysis: Assignment 4:Course Project

### Question: Of the four types of sources indicated by the 
### \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources 
### have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions 
### from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.


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

### SCC has 11717 observations with 15 columns.

### To answer this question, we only need to focus on one city, the city of Baltimore which has the fips==24510.

### So we just subset the NEI data by setting fips==24510.

### Subsetting

baltimore<- subset(NEI,NEI$fips=="24510")
head(baltimore)

### Now we find the total yearly emissions for all the counties that fall under Baltimore:

totalbaltimore<- aggregate(baltimore$Emissions,by=list(baltimore$year,baltimore$type),FUN=sum)
head(totalbaltimore)
names(totalbaltimore)[names(totalbaltimore)=="Group.1"]<- "Years"
names(totalbaltimore)[names(totalbaltimore)=="Group.2"]<- "Type"
names(totalbaltimore)[names(totalbaltimore)=="x"]<- "Emissions"
head(totalbaltimore)


### Now we have to plot the total emissions due to each type by year.We can use the geom_line() to show for each type 
### over the years.

library(ggplot2)
gdata<- ggplot(totalbaltimore, aes(Years,Emissions,color=Type))

png("C:\\Users\\das90\\OneDrive\\Coursera courses\\John Hopkins\\R Codes and Files\\Exploratory Data Analysis\\Data-Science-Specialization-with-R-Exploratory-Data-Analysis\\plot3.png")

gdata + geom_line(aes(size=2)) + xlab("Years") +  ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle("Total Emissions in Baltimore City by type, over the Years") 

dev.off()