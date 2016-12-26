# Ernesto Budia Sanchez
# 26/12/2016
# Exploratory Data Analysis - Course Project 1 
# plot4.R
######################################################

#Install package data.table if required
if (!('data.table' %in% rownames(installed.packages()))){
  install.packages("data.table")}

#Install package lubridate if required
if (!('lubridate' %in% rownames(installed.packages()))){
  install.packages("lubridate")}

library(data.table)
library(lubridate)

#Download data if required
if (!file.exists('data.zip')){
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL,destfile = 'data.zip', method="curl")
}

#unzip data if required
if (!file.exists('household_power_consumption.txt')){
  unzip('data.zip') 
}

# Read data into df
df<-fread('household_power_consumption.txt',dec=".",na.strings="?")


# join Data and time to new variable called Datetime 
# and convert to POSIXct with dmy_hms function
df[,DateTime:=dmy_hms(paste(Date,Time))]

# Subseting df Between 2007-02-01 and 2007-02-02
date1<-ymd('2007-02-01')
date2<-ymd('2007-02-03')
df<-df[df$DateTime >= date1 & df$DateTime < date2]

######################################################
# Plot4.png
######################################################

dev.cur()

png(file="plot4.png")
par(mfrow=c(2,2))
with(df,plot(DateTime,Global_active_power,type = "l",
             ylab ="Global Active Power (kilowatts)"))

with(df,plot(DateTime,Voltage,type = "l",
             ylab ="Voltage"))

with(df, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime, col='Red')
  lines(Sub_metering_3~DateTime, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1,bty = "n", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(df,plot(DateTime,Global_reactive_power,type = "l"))

dev.off()
