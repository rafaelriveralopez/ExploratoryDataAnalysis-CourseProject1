
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
png("plot1.png", width=480, height=480)
hist(newData$Global_active_power, 
     col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()