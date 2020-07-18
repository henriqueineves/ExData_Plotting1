###Script for the course project form week 1
#Loading the zip package:

##install.packages(zip)
library(zip)

#Downloading the file and oppening it in a dataframe:
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "Dataplots.zip", method = "curl")
unzip("Dataplots.zip", exdir = "./")
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Since we will only be using the data from "2007-02-01 and 2007-02-02, lets subset the dataset?
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

#Changing the properties of data to allow graph design:
for (i in 3:9){data[,i] <- as.numeric(data[,i])}
#Open the device
png("plot1.png", width = 480, height = 480)

#Create the Plot
hist(data$Global_active_power, main = "Global Active Power", 
    xlab = "Global Active Power (killowatts)", col = "red")
#Close the Device
dev.off()
