## Download Data
filename <- "exdata_data_household_power_consumption.zip"
myURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(filename)){
        fileURL <- myURL
        download.file(fileURL, filename, method="curl")
}  
## Unzip Data
if (!file.exists("household_power_consumption.txt")) { 
        unzip(filename) 
}
## Read Data for 1/2/2007 and 2/2/2007 only
datacolnames <- c("Date", "Time", "Global_active_power",
                  "Global_reactive_power","Voltage", "Global_intensity", 
                  "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data <- read.table(text = grep("^[1,2]/2/2007",
                               readLines("household_power_consumption.txt"),
                               value=TRUE),
                   sep = ';', col.names = datacolnames)
## Convert date to class = date
data$Date<- as.Date(data$Date, format = "%d/%m/%Y")
## Creates datetime column 
data$datetime <- as.POSIXct(paste(data$Date, data$Time))
## Builds plot3
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
## 1st plot
with(data, plot(datetime, Global_active_power, xlab = "",
                ylab = "Global Active Power", type = "l"))
## 2nd plot
with(data, plot(datetime, Voltage, type = "l"))
## 3rd plot
with(data, plot(datetime, Sub_metering_1, xlab = "",
                ylab = "Energy sub metering", type = "l", ))
with(data, lines(datetime, Sub_metering_2, col = "red" ))
with(data, lines(datetime, Sub_metering_3, col = "blue" ))
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
## 4th plot
with(data, plot(datetime, Global_reactive_power, type = "l"))
dev.off()
