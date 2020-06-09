### Exploratory Data Analysis: Assignment 4:Course Project

### Question: Have total emissions from PM2.5 decreased in the Baltimore City, 
### Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? 
### Use the base plotting system to make a plot answering this question.


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

totalbaltimore<- aggregate(Emissions~year,baltimore,FUN = sum)
head(totalbaltimore)

### Now we again, just like in the previous plot, plot boxplots to plot the yearly emissions:

png("C:\\Users\\das90\\OneDrive\\Coursera courses\\John Hopkins\\R Codes and Files\\Exploratory Data Analysis\\Data-Science-Specialization-with-R-Exploratory-Data-Analysis\\plot2.png")

barplot(height = totalbaltimore$Emissions, names.arg = totalbaltimore$year, col = totalbaltimore$year, xlab = "Years",  ylab = "Total Emissions",  main = "Total yearly emissions in the city of Baltimore ")

dev.off()

