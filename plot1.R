### Exploratory Data Analysis: Assignment 4:Course Project

### Question: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
### Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the 
### years 1999, 2002, 2005, and 2008.

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


### To answer the first question, we have to find the yearly total emissions of United States and using a suitable
### plot to show if emissions have increased over the 5 years of data available.

### To do this, we can plot the total emissions by year and see if it has increased or decreased over the years.

### Total emissions by year

emmagg<- aggregate(NEI$Emissions,by=list(NEI$year),FUN=sum)

### Now to represent the yearly total emissions, we can use a barplot

png("C:\\Users\\das90\\OneDrive\\Coursera courses\\John Hopkins\\R Codes and Files\\Exploratory Data Analysis\\Data-Science-Specialization-with-R-Exploratory-Data-Analysis\\plot1.png")

barplot(height = emmagg$x,names.arg = emmagg$Group.1,col = emmagg$Group.1, xlab = "Years", ylab = "Total Emissions", main = "Total Emissions by Year")
