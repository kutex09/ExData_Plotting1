#setwd("~/")
if(!file.exists("EDA-Project-Data")){
  dir.create("EDA-Project-Data")
}
#Download the dataset
downloadUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(downloadUrl,"./EDA-Project-Data/project1_EPC.zip")

if (!file.exists("EDA-Project-Data")) { 
  unzip("./EDA-Project-Data/project1_EPC.zip")
}

list.of.packages <- c("data.table")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
rm(list.of.packages,new.packages)

library(data.table)


hh_power_cons <- suppressWarnings(fread("household_power_consumption.txt")) 
hh_power_cons <- as.data.frame(hh_power_cons)


hh <- hh_power_cons[hh_power_cons$Date %in% c("1/2/2007","2/2/2007"), ]

hh <-cbind(hh[,1:2], rbind.data.frame(lapply(hh[,3:9], as.numeric)))
par(mfrow = c(1,1))
hh$Date_Time <- as.POSIXct(paste(hh$Date, hh$Time), format="%d/%m/%Y %H:%M:%S")
par(mfcol = c(2,2))
plot(hh$Date_Time,hh$Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)",xlab = "")

plot(hh$Date_Time,hh$Sub_metering_1,type = "l", ylab = "Energy sub metering",xlab = "")
lines(hh$Date_Time,hh$Sub_metering_2,type = "l",col = "red")
lines(hh$Date_Time,hh$Sub_metering_3,type = "l",col = "blue")
legend("topright",cex = 0.8, lty = c(1,1,1),col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")

plot(hh$Date_Time,hh$Voltage,type = "l", ylab = "Voltage",xlab = "datetime")

plot(hh$Date_Time,hh$Global_reactive_power,type = "l", ylab = "Global_reative_power",xlab = "datetime")
dev.copy(png,file="plot4.png",width = 480, height = 480)
dev.off()