
## This .r file is used for constructing plot1 and create a png copy in the same directory
## In order to reproduce the plot, one need to install 'sqldf' package for reading the source file.
## And make sure the source file is in the same directory as the .r file

#### Reading source file using 'sqldf'
library(sqldf)
mydata <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
	sql = "SELECT * FROM file WHERE Date IN  ('1/2/2007','2/2/2007')"
)
closeAllConnections()

#### Set up the plot to be 2 by 2
## Set the front size to be smaller in order to see the legend in the third chart when viewing in png
par(mfrow = c(2,2), ps = 11)


#### Plotting the first chart - Global Active Power
## Checking missing values
NonMissingRow <- mydata[,3] != "?"
NonMissingGAP <- mydata[NonMissingRow,]

## Storing time value and the related values
myTimestamp <- as.POSIXct(paste(NonMissingGAP$Date, NonMissingGAP$Time), format = "%d/%m/%Y %H:%M:%S")
myGAP <- NonMissingGAP[,3]

## Plotting the chart
plot(myTimestamp, myGAP, type = "n", xlab = "", ylab = "Global Active Power")
lines(myTimestamp, myGAP)


#### Plotting the second chart - Voltage
## Checking missing values
NonMissingRow <- mydata[,5] != "?"
NonMissingVTG <- mydata[NonMissingRow,]

## Storing time value and the related values
myTimestamp <- as.POSIXct(paste(NonMissingVTG$Date, NonMissingVTG$Time), format = "%d/%m/%Y %H:%M:%S")
myVTG <- NonMissingVTG[,5]

## Plotting the chart
plot(myTimestamp, myVTG, type = "n", xlab = "datetime", ylab = "Voltage")
lines(myTimestamp, myVTG)


#### Plotting the third chart - Energy sub metering
## Checking missing values
for (i in 7:9) {
	NonMissingRow <- mydata[,i] != "?"
	NonMissingSMR <- mydata[NonMissingRow,]
}

## Storing time value and the related values
myTimestamp <- as.POSIXct(paste(NonMissingSMR $Date, NonMissingSMR $Time), format = "%d/%m/%Y %H:%M:%S")
mySMR1 <- NonMissingSMR[,7]
mySMR2 <- NonMissingSMR[,8]
mySMR3 <- NonMissingSMR[,9]

## Plotting the chart
plot(myTimestamp, mySMR1,
	type = "n",
	xlab = "",
	ylab = "Energy sub metering")
lines(myTimestamp, mySMR1, col = "black")
lines(myTimestamp, mySMR2, col = "red")
lines(myTimestamp, mySMR3, col = "blue")
legend("topright",
	lty=c(1,1),
	bty = "n",
	col = c("black", "red", "blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)


#### Plotting the forth chart - Global Reactive Power
## Checking missing values
NonMissingRow <- mydata[,4] != "?"
NonMissingGRP <- mydata[NonMissingRow,]

## Storing time value and the related values
myTimestamp <- as.POSIXct(paste(NonMissingGRP$Date, NonMissingGRP$Time), format = "%d/%m/%Y %H:%M:%S")
myGRP <- NonMissingGRP[,4]

## Plotting the chart
plot(myTimestamp, myGRP, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(myTimestamp, myGRP)

#### Creating a png copy of the same polt
dev.copy(png, file = "plot4.png")
dev.off()
