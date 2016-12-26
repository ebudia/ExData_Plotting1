# Ernesto Budia Sanchez
# 26/12/2016
# E/xploratory Data Analysis - Course Project 1 
# plot2.R
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
# Plot2.png
######################################################

dev.cur()
png(file="plot2.png")
with(df,plot(DateTime,Global_active_power,type = "l",
             ylab ="Global Active Power (kilowatts)"))

dev.off()
