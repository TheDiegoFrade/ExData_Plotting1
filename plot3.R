if(!file.exists("exdata_data_household_power_consumption.zip")){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,destfile='power_consumption.zip',method="curl",mode="wb")
  unzip(zipfile = "power_consumption.zip")    
}

if (!"sqldf" %in% installed.packages()) {
  warning("Package sqldf required for this script. Installing sqldf now.")
  install.packages("readr")
}
library(sqldf)

householdPowerConsumption <- read.csv.sql(file='household_power_consumption.txt',sep = ";",sql='SELECT * FROM file WHERE "Date" IN ("2/2/2007","1/2/2007")')
householdPowerConsumption$dateTime <- strptime(paste(householdPowerConsumption$Date,householdPowerConsumption$Time),
                                               format="%d/%m/%Y %H:%M:%S")

head(householdPowerConsumption)
png("plot3.png", width=480, height=480)
with(householdPowerConsumption, plot(dateTime,Sub_metering_1,type = "n",
                                     ylab="Energy sub metering)",
                                     xlab=""))
with(householdPowerConsumption,lines(dateTime,Sub_metering_1,col="black"))
with(householdPowerConsumption,lines(dateTime,Sub_metering_2,col="red"))
with(householdPowerConsumption,lines(dateTime,Sub_metering_3,col="blue"))
legend("topright",lty="solid",col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

