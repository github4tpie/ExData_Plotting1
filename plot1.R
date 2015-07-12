library("lubridate")
library("graphics")
library("data.table")
library("plyr")
library("dplyr")

z <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = '?')
z$Date <- dmy(z$Date, tz="EST")
x <- z %>% filter(Date == ymd("2007-02-01", tz = "EST") | Date == ymd("2007-02-02", tz = "EST"))
x$Global_active_power <- as.numeric(x$Global_active_power)
##x$Global_reactive_power <- as.double(x$Global_reactive_power)
x$Sub_metering_1 <- as.numeric(x$Sub_metering_1)
x$Sub_metering_2 <- as.numeric(x$Sub_metering_2)
x$Sub_metering_3 <- as.numeric(x$Sub_metering_3)

# Create a datetime variable
y <- mutate(x, DT=as.POSIXct(paste(x$Date, x$Time), format="%Y-%m-%d %H:%M:%S"))

png("plot1.png")
hist(y$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
