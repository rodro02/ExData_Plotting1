# read ";" file
file <- "c:/Users/Owner/ExData_Plotting1/household_power_consumption.txt"
df_epc <- read.csv2(file, header = TRUE, sep = ";")

#selecting only 2007-02-01 & 02
df_date <- df_epc [as.Date(df_epc$Date,format='%d/%m/%Y')==as.Date('2007-02-01') | as.Date(df_epc$Date,format='%d/%m/%Y')==as.Date('2007-02-02'),]

#adding datetime column
df_date$datetime<-strptime(paste(df_date[,1],df_date[,2]),"%d/%m/%Y %H:%M:%S")

#convert to date
df_date$Date <- as.Date(df_date$Date,format='%d/%m/%Y')
#graph 3
plot(df_date$datetime ,df_date$Sub_metering_3,type="n",ylab="Energy sub metering",xlab="",ylim = c(0,40 ),
     yaxs="r")
lines(df_date$datetime ,df_date$Sub_metering_1)
lines(df_date$datetime ,df_date$Sub_metering_2,col = "red")
lines(df_date$datetime ,df_date$Sub_metering_3,col = "blue")
legend("topright", lty=1,cex=0.4, col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
#saving graph
dev.copy(png,filename="plot3.png",width=480,height=480);
dev.off ();
