# load sqldf package
library(sqldf)

power <- read.csv.sql("household_power_consumption.txt", sql = "select * from file", header = TRUE, sep = ";")
# Convert the Date and Global Active Power Columns with the appropriate format
power$Date <- as.Date(power$Date, "%d/%m/%Y")
#power$Global_active_power <- as.numeric(power$Global_active_power)
# Subset Dataframe to include only data between '2007-02-01 and '2007-02-02'
power <- subset(power,Date>='2007-02-01' & Date<='2007-02-02')
power$Time <- as.POSIXct(paste(as.character(power$Date),power$Time,sep=" "),tz="UTC")
png(filename = "plot2.png", width = 480, height = 480)
with(power, plot(power$Time,power$Global_active_power, type="l", main = "", xlab="", ylab="Global Active Power (kilowatts)")) ## Create plot on screen device
dev.off() ## close the PNG device!