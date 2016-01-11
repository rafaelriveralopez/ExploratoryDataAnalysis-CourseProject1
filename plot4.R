
if(!file.exists("EPC.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "EPC.zip", method = "curl")
  unzip("EPC.zip")
}

txt <-"household_power_consumption.txt"
tab5rows <- read.table(txt, header = TRUE, sep=";", nrows = 5)
classes <- sapply(tab5rows, class)
tabAll <- read.table(txt, header = TRUE, sep=";", colClasses = classes,  na = "?")

newData <- tabAll[tabAll$Date == "1/2/2007" | tabAll$Date == "2/2/2007", ]

newData$Date <- as.Date(newData$Date, format="%d/%m/%Y")
newData$DateTime <- as.POSIXct(paste(as.Date(newData$Date), newData$Time))

png("plot4.png", width=480, height=480)
par(mfcol=c(2,2))

plot(newData$Global_active_power~newData$DateTime, type="l",
     ylab="Global Active Power", xlab="")

plot(newData$Sub_metering_1~newData$DateTime, type="l",
     ylab="Energy sub metering", xlab="")
lines(newData$DateTime, newData$Sub_metering_2, col = "red")
lines(newData$DateTime, newData$Sub_metering_3, col = "blue")
legend("topright", col=c("black", "red", "blue"), bty="n",lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(newData$Voltage~newData$DateTime, type="l", ylab="Voltage",xlab="datetime")


plot(newData$Global_reactive_power~newData$DateTime, type="l", 
     ylab="Global_reactive_power", xlab="datetime")

dev.off()