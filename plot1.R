## plot1.R

## create histogram of Global_active_power

startday <- as.Date("2007-02-01")
endday <- as.Date("2007-02-02")

## read full data file

# fullData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
#           na.strings = "?")
# DateTime <- strptime(paste(fullData$Date,fullData$Time,sep=" "), "%d/%m/%Y %H:%M:%S")


## read truncated data file

index1 <- 66637
index2 <- 69516

cnames <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
              "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
truncData <- read.table("household_power_consumption.txt", header = FALSE, sep = ";",
                     na.strings = "?", skip = index1, nrows = index2-index1)
colnames(truncData) <- cnames
DateTime <- strptime(paste(truncData$Date,truncData$Time,sep=" "), "%d/%m/%Y %H:%M:%S")

indices <- which(as.Date(DateTime) >= startday & as.Date(DateTime) <= endday)