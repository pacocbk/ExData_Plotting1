
## This .r file is used for constructing plot1 and create a png copy in the same directory
## In order to reproduce the plot, one need to install 'sqldf' package for reading the source file.
## And make sure the source file is in the same directory as the .r file

## Reading source file using 'sqldf'
library(sqldf)
mydata <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
	sql = "SELECT * FROM file WHERE Date IN  ('1/2/2007','2/2/2007')"
)
closeAllConnections()

## Excluding missing data which is indicating with '?'
NonMissingRow <- mydata[,3] != "?"
NonMissingGAP <- mydata[NonMissingRow,]

## Plotting the histogram using hist() function
hist(NonMissingGAP[,3],
	main = "Global Active Power",
	xlab = "Global Active Power (killowatts)", 
	col = "red"
)

## Creating a png copy of the same polt
dev.copy(png, file = "plot1.png")
dev.off()
