# load sqldf package
library(sqldf)

power <- read.csv.sql("household_power_consumption.txt", sql = "select * from file", header = TRUE, sep = ";")
# Convert the Date and Global Active Power Columns with the appropriate format
power$Date <- as.Date(power$Date, "%d/%m/%Y")
#power$Global_active_power <- as.numeric(power$Global_active_power)
# Subset Dataframe to include only data between '2007-02-01 and '2007-02-02'
power <- subset(power,Date>='2007-02-01' & Date<='2007-02-02')
power$Time <- as.POSIXct(paste(as.character(power$Date),power$Time,sep=" "),tz="UTC")
png(filename = "plot3.png", width = 480, height = 480)
plot(power$Time,power$Sub_metering_1, type="n", main = "", xlab="", ylab="Energy sub metering") ## Create plot on screen device
lines(power$Time,power$Sub_metering_1, col="black") ## Create plot on screen device
lines(power$Time,power$Sub_metering_2, col="red") ## Create plot on screen device
lines(power$Time,power$Sub_metering_3, col="blue") ## Create plot on screen device
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1,1))
dev.off() ## close the PNG device!