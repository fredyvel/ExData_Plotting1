
dat<- read.table("exdata_data_household_power_consumption\\household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## change format string to date
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")

dat <- dat[complete.cases(dat),]

## filter data between correct date
dat <- subset(dat,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

dateTime <- paste(dat$Date, dat$Time)


dateTime <- setNames(dateTime, "DateTime")


## Remove Date and Time column
dat<- dat[ ,!(names(dat) %in% c("Date","Time"))]

## Add DateTime column
dat <- cbind(dateTime, dat)

## Format dateTime Column
dat$dateTime <- as.POSIXct(dateTime)



par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(dat$Global_active_power~dat$dateTime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
plot(dat$Voltage~dat$dateTime, type="l", 
     ylab="Voltage (volt)", xlab="")
plot(dat$Sub_metering_1~dat$dateTime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
lines(dat$Sub_metering_2~dat$dateTime,col='Red')
lines(dat$Sub_metering_3~dat$dateTime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(dat$Global_reactive_power~dat$dateTime, type="l", 
     ylab="Global Rective Power (kilowatts)",xlab="")

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()