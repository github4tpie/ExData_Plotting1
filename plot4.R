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

png("plot4.png")
split.screen(c(2, 2))

screen(1)
with(y, plot(Global_active_power ~ DT, type = "l", xlab = "", ylab = "Global Active Power"))

screen(2)
with(y, plot(Voltage ~ DT, type = "l", xlab = "datetime"))

screen(3)
with(y, plot(Sub_metering_1 ~ DT, type = "l", xlab = "", ylab = "Energy Sub Metering"))
lines(y$Sub_metering_2 ~ y$DT, col="red")
lines(y$Sub_metering_3 ~ y$DT, col="blue")
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(1,1,1),col=c("black","blue","red"), bty='n', cex=.75)

screen(4)

plot(Global_reactive_power ~ DT, y, type="l", xlab="datetime")

close.screen(all.screens = TRUE)
dev.off()
