## plot1.R
## creates histogram of Global_active_power for specified date range

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

## Plot histogram
par(cex=0.8)
hist(truncData$Global_active_power, 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red")  ## Histogram

# Direct a copy to png file

dev.copy(png, file = "plot1.png")
dev.off()
