###Script for the course project form week 1
#Loading the zip package:

##install.packages(zip)
library(zip); library(dplyr)

#Downloading the file and oppening it in a dataframe:
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "Dataplots.zip", method = "curl")
unzip("Dataplots.zip", exdir = "./")
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Since we will only be using the data from "2007-02-01 and 2007-02-02, lets subset the dataset?
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

#Changing the properties of data to allow graph design:
for (i in 3:9){data[,i] <- as.numeric(data[,i])}
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")

#The lines bellow format the 'Time' column to be possible to work
data[1:1440, "Time"] <- format(data[1:1440, "Time"], "2007-02-01 %H:%M:%S")
data[1441:2880, "Time"] <- format(data[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

#Open the device
png("plot3.png", width = 480, height = 480)

#Create the Plot
with(data, plot(data$Time, data$Sub_metering_1, main = "", xlab = "", 
                ylab = "Energy Sub Metering", type = "n"))
with(data, points(data$Time, data$Sub_metering_1, type = "l"))
with(data, points(data$Time, data$Sub_metering_2, type = "l", col = "red"))
with(data, points(data$Time, data$Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

#Close the Device
dev.off()
