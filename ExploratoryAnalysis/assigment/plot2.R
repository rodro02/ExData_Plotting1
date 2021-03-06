
# read ";" file
file <- "c:/Users/Owner/ExData_Plotting1/household_power_consumption.txt"
df_epc <- read.csv2(file, header = TRUE, sep = ";")

#selecting only 2007-02-01 & 02
df_date <- df_epc [as.Date(df_epc$Date,format='%d/%m/%Y')==as.Date('2007-02-01') | as.Date(df_epc$Date,format='%d/%m/%Y')==as.Date('2007-02-02'),]

#adding datetime column
df_date$datetime<-strptime(paste(df_date[,1],df_date[,2]),"%d/%m/%Y %H:%M:%S")

#convert to date
df_date$Date <- as.Date(df_date$Date,format='%d/%m/%Y')
#graph 2
GAP<- data.frame(df_date$datetime,ga)

plot(GAP,ylab="Global Active Power(kilowatts",type="n",xlab="")
lines(GAP)
#saving graph2
dev.copy(png,filename="plot2.png",width=480,height=480);
dev.off ();