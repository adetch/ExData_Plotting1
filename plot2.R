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
png(file="Plot2.png")
plot(x=twoDaysData$DateTime,
     y=twoDaysData$Global_active_power,
     ylab="Global Active Power (kilowatts)",
     xlab="",
     type="l"
)
dev.off()