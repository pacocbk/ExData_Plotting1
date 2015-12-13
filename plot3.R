
## This .r file is used for constructing plot1 and create a png copy in the same directory
## In order to reproduce the plot, one need to install 'sqldf' package for reading the source file.
## And make sure the source file is in the same directory as the .r file

## Reading source file using 'sqldf'
library(sqldf)
mydata <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
	sql = "SELECT * FROM file WHERE Date IN  ('1/2/2007','2/2/2007')"
)
closeAllConnections()

## Checking missing values which are indicating by "?"
for (i in 7:9) {
	NonMissingRow <- mydata[,i] != "?"
	NonMissingSMR <- mydata[NonMissingRow,]
}

## Storing time value and the related values
myTimestamp <- as.POSIXct(paste(NonMissingSMR $Date, NonMissingSMR $Time), format = "%d/%m/%Y %H:%M:%S")
mySMR1 <- NonMissingSMR[,7]
mySMR2 <- NonMissingSMR[,8]
mySMR3 <- NonMissingSMR[,9]

## Plotting the chart using lines function
par(ps = 9)
plot(myTimestamp, mySMR1,
	type = "n",
	xlab = "",
	ylab = "Energy sub metering")
lines(myTimestamp, mySMR1, col = "black")
lines(myTimestamp, mySMR2, col = "red")
lines(myTimestamp, mySMR3, col = "blue")
legend("topright",
	lty=c(1,1),
	col = c("black", "red", "blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)


## Creating a png copy of the same polt
dev.copy(png, file = "plot3.png")
dev.off()
