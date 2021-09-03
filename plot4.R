## Exploratory Data Analysis
## Plotting Assignment 1

## plot4.R -- create fourth plot

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
  rm(hhDataFull)
}

# Resume code here if I've already processed data

# Clean up
rm(fileName)

# Open PNG device
png(filename="plot4.png",width=480,height=480,units="px")

# Create plots
# Four plots, in 2x2 layout
# Note: warning from R that type parameter is obsolete, but it still works
par(mfrow=c(2,2), type="n")

# Plot 1
with(hhData, plot(x=DT, y=Global_active_power, xlab = "",
                 ylab="Frequency", col="black", type="l"))

# Plot 2
with(hhData, plot(x=DT, y=Voltage, xlab="datetime", ylab="Voltage", type="l"))

# Plot 3 is similar to plot3.png, but without box around legend
# Again, huge legend coding thanks to https://r-coder.com/add-legend-r/
with(hhData, plot(x=DT, y=Sub_metering_1, type="l", xlab="",
                  ylab="Energy sub metering", col="black"))
with(hhData, lines(x=DT, y=Sub_metering_2, col="red"))
with(hhData, lines(x=DT, y=Sub_metering_3, col="blue"))
with(hhData, legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2",
                                           "Sub_metering_3"), lty = c(1, 1, 1),
                    col = c("black", "red", "blue"), bty="n"))

# Plot 4
with(hhData, plot(x=DT, y=Global_reactive_power, type="l", xlab="datetime",
                  ylab="Global_reactive_power", col="black"))

# Close PNG device
dev.off()