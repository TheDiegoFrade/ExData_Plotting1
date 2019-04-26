householdPowerConsumption <- read.csv.sql(file='household_power_consumption.txt',sep = ";",sql='SELECT * FROM file WHERE "Date" IN ("2/2/2007","1/2/2007")')
png("plot1.png", width=480, height=480)
hist(householdPowerConsumption$Global_active_power,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
dev.off()
