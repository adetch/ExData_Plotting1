zipFile = "./data/household_power_consumption.zip"
txtFile = "./data/household_power_consumption.txt"
if(!file.exists(txtFile)) {
  url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  file<-download.file(url, destfile = zipFile, method = "curl")
  unzip(zipFile,exdir="./data/")
}
df<-read.table(txtFile,sep=';',na.strings="?",header=TRUE)

twoDaysData<-df[df$Date=="1/2/2007"|df$Date=="2/2/2007",]
twoDaysData$DateTime<-as.POSIXct(strptime(paste(twoDaysData$Date,twoDaysData$Time),format='%d/%m/%Y %H:%M:%S'))
png(file="Plot4.png")
par(mfrow=c(2,2))
plot(x=twoDaysData$DateTime,
     y=twoDaysData$Global_active_power,
     ylab="Global Active Power",
     xlab="",
     type="l"
)
plot(x=twoDaysData$DateTime,
     y=twoDaysData$Voltage,
     ylab="Voltage",
     xlab="",
     type="l"
)
plot(x=twoDaysData$DateTime,
     y=twoDaysData$Sub_metering_1,
     ylab="Energy sub metering",
     xlab="",
     type="l",
     col="black"
)
lines(x=twoDaysData$DateTime,y=twoDaysData$Sub_metering_2,col='red')
lines(x=twoDaysData$DateTime,y=twoDaysData$Sub_metering_3,col='blue')
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c('black','red','blue'),
       lty=c(1,1)
)
plot(x=twoDaysData$DateTime,
     y=twoDaysData$Global_reactive_power,
     ylab="Global_reactive_power",
     xlab="",
     type="l"
)
dev.off()