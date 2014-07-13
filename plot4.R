## plot2.R
## creates plot of Global_active_power vs Day for specified date range

startday <- as.Date("2007-02-01")
endday <- as.Date("2007-02-02")

## read full data file
## (uncomment for the slow approach, but necessary when changing the
##  date range, at which point you may study the head and tail of
##  indices and update index1 and index2 in the faster section below)
##

# fullData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
#           na.strings = "?")
# DateTime <- strptime(paste(fullData$Date,fullData$Time,sep=" "), "%d/%m/%Y %H:%M:%S")
# indices <- which(as.Date(DateTime) >= startday & as.Date(DateTime) <= endday)
# truncData <- fullData[indices,]

## read truncated data file
## (speedier method, but need to make sure that index1 and index2 are
##  correctly specified for the date range you wish to study
##  comment out whole region if you happen to be using the above method)

index1 <- 66637
index2 <- 69516

cnames <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
              "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
truncData <- read.table("household_power_consumption.txt", header = FALSE, sep = ";",
                     na.strings = "?", skip = index1, nrows = index2-index1+1)
colnames(truncData) <- cnames
DateTime <- strptime(paste(truncData$Date,truncData$Time,sep=" "), "%d/%m/%Y %H:%M:%S")

## assign data types to columns in data frame

truncData$Date <- as.Date(truncData$Date, format = "%d/%m/%Y")

## Multiple plots

par(mfrow = c(2,2))
par(mar = c(5.1,4.1,1.1,1.1))
par(ann=FALSE)
## plot1
plot(DateTime, truncData$Global_active_power,
     type = "l")
title(ylab = "Global Active Power")

## plot2
plot(DateTime, truncData$Voltage,
     type = "l")
title(xlab = "datetime",  ylab = "Voltage" )

## plot3
plot(DateTime, truncData$Sub_metering_1,
        type = "l", col = "black")
title(ylab = "Energy sub metering")
lines(DateTime, truncData$Sub_metering_2,
        col = "red")
lines(DateTime, truncData$Sub_metering_3,
        col = "blue")
legend("topright", title = NULL, lty="solid", col=c("black","red","blue"),
        text.width = strwidth("Sub_metering_XX"), bty="n",
        c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


## plot4
plot(DateTime, truncData$Global_reactive_power,
     type = "l")
title(xlab = "datetime", ylab = "Global_reactive_power" )

# Need to create plot directly on png device or legend gets clipped off

png("plot4.png")

        par(mfrow = c(2,2))
        par(mar = c(5.1,4.1,1.1,1.1))
        par(ann=FALSE)
        ## plot1
        plot(DateTime, truncData$Global_active_power,
                type = "l")
        title(ylab = "Global Active Power")

        ## plot2
        plot(DateTime, truncData$Voltage,
                type = "l")
        title(xlab = "datetime",  ylab = "Voltage" )

        ## plot3
        plot(DateTime, truncData$Sub_metering_1,
                type = "l", col = "black")
        title(ylab = "Energy sub metering")
        lines(DateTime, truncData$Sub_metering_2,
                col = "red")
        lines(DateTime, truncData$Sub_metering_3,
                col = "blue")
        legend("topright", title = NULL, lty="solid", col=c("black","red","blue"),
                text.width = strwidth("Sub_metering_XX"), bty="n",
                c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

        ## plot4
        plot(DateTime, truncData$Global_reactive_power,
                type = "l")
        title(xlab = "datetime", ylab = "Global_reactive_power" )

dev.off()
