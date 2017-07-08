getwd()
if(!file.exists('data.zip')){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "data.zip")
}
unzip("data.zip") 

data<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")

names(data)
lapply(data, class)
data$DateTime<-paste(data$Date, data$Time)
?strptime
head(data)
str(data)

data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

finalData <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
head(finalData)
SetTime <-strptime(paste(finalData$Date, finalData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
head(SetTime)
finalData <- cbind(SetTime, finalData)


#plot3
columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(finalData$SetTime, finalData$Sub_metering_1, type="l", col=columnlines[1], xlab="", ylab="Energy sub metering")
lines(finalData$SetTime, finalData$Sub_metering_2, col=columnlines[2])
lines(finalData$SetTime, finalData$Sub_metering_3, col=columnlines[3])
legend("topright", legend=labels, col=columnlines, lty="solid")

