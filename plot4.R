### Exploratory Data Analysis: Assignment 4:Course Project

### Question: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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

### Now we need to merge the two datasets, NEI and SCC. The common variable between the two datasets is SCC. So we
### need to merge the two datasets using that common variable SCC.

combined<- merge(NEI,SCC,by="SCC")

### Exploring the combined data

head(combined)
colnames(combined)
combined$Short.Name

### So the variable Short.Name is our variable of interest.

### We have to separate all the coal combustion related emissions using the variable Short.Name.

### First we need to separate the observations, which have the shortname coal. Using the grepl() command, we search 
### the datatset Combined and find all the emissions that occur due to coal combistions.

coal<- grepl("Coal", combined$Short.Name,ignore.case = TRUE)

### Next, we subset the dataset combined, using the newly created logical vector coal, so that we are left with only
### those observsations, which correspond to emissions from coal combustions.

subcombined<- combined[coal,]


### Now let us look at the subsetted data once:

head(subcombined)
dim(subcombined)

### So we have only 53400 observations now.

### Our first objective is to find the total yearly emissions that happen due to coal combustions.

yrtotal<- aggregate(subcombined$Emissions,by=list(subcombined$year), FUN=sum)
names(yrtotal)[names(yrtotal)=="x"]<-"Emissions"
names(yrtotal)[names(yrtotal)=="Group.1"]<-"Year"
head(yrtotal)

### Now we plot the yearly total using ggplot:

gdata<- ggplot(yrtotal,aes(factor(Year),Emissions),color="Year")

png("C:\\Users\\das90\\OneDrive\\Coursera courses\\John Hopkins\\R Codes and Files\\Exploratory Data Analysis\\Data-Science-Specialization-with-R-Exploratory-Data-Analysis\\plot4.png")

gdata + geom_bar(stat = "identity") + xlab("Years") +  ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle("Total Emissions due to Coal Combustion")

dev.off()