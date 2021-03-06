# reads file (file must be in your current working directory)

data = read.table("household_power_consumption.txt",sep=";",header=T,
                  stringsAsFactors = F)

# joins date and time into a new POSIXct variable
# drops redundant date and time cols

data$datetime = paste(data$Date,data$Time)
data$datetime = strptime(data$datetime,"%d/%m/%Y %H:%M:%S")
data$datetime = as.POSIXct(data$datetime)
data = data[,-c(1,2)]

# subsets data to relevant timeframe

data = subset(data,
              datetime>="2007-02-01 00:00:00" & datetime<"2007-02-03 00:00:00")

# converts measurement columns into numeric values

data[,1:7] = data.frame(sapply(data[,1:7],as.numeric))

# plots to png

png(filename="plot2.png",width=480,height=480,family="serif")

with(data,plot(datetime,Global_active_power,
               type ="l",
               xlab="",
               ylab="Global Active Power (kilowatts)",
               # excludes automatic labeling for x axis
               # non-English daynames could appear due to locale settings
               xaxt="n")  
)

# reticks and relabels x axis in English
axis(1,at=data$datetime[c(1,1440,2880)],labels=c("Thu","Fri","Sat"))

dev.off()