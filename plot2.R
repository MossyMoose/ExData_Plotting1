## Exploratory Data Analysis
## Plotting Assignment 1

## plot2.R -- create second plot

# Load packages
library(lubridate) # Use lubridate for working with date and time

# Load data set, downloading it if necessary
fileName<-"household_power_consumption.txt"
if(!file.exists(fileName)) {
  fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  fileZip<-"household_power_consumption.zip"
  download.file(fileUrl,destfile=fileZip,method="curl")
  unzip(fileZip)
  # Clean up
  rm(fileUrl)
  rm(fileZip)
}

# Check if I've already loaded and worked with data
# If I have skip to creating plot
if(!exists("hhData")) {
  
  # Read data set into hhDataFull
  hhDataFull<-read.table(fileName,header=TRUE,sep=";")
  
  # Convert date and time variable to single date/time variable
  hhDataFull$DT <- with(hhDataFull, dmy(Date) + hms(Time))
  
  # Subset dates 2007-02-01 and 2007-02-02 into hhData
  hhData<-subset(hhDataFull,date(DT)==as.Date("2007-02-01") | date(DT)==as.Date("2007-02-02"))
  
  # Convert character vectors to numeric
  hhData$Global_active_power<-as.numeric(hhData$Global_active_power)
  hhData$Global_reactive_power<-as.numeric(hhData$Global_reactive_power)
  hhData$Voltage<-as.numeric(hhData$Voltage)
  hhData$Global_intensity<-as.numeric(hhData$Global_intensity)
  hhData$Sub_metering_1<-as.numeric(hhData$Sub_metering_1)
  hhData$Sub_metering_2<-as.numeric(hhData$Sub_metering_2)
  
  # Clean up to free memory
  rm(fileName)
  rm(hhDataFull)
}

# Resume code here if I've already processed data

# Clean up
rm(fileName)

# Open PNG device
png(filename="plot2.png",width=480,height=480,units="px")

# Create plot
with(hhData, plot(x=DT, y=Global_active_power, type="l", xlab="",
                  ylab="Global Active Power (kilowatts)"))

# Close PNG device
dev.off()