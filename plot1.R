#get the url
fileurl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download zip file
download.file (fileurl,destfile="data/household_epc.zip",mode="wb")
#define temp directory
td=tempdir()
td <- "c:/Users/Owner/DataScientist/ExploratoryAnalysis/data"
tf= "c:\\Users\\Owner\\DataScientist\\ExploratoryAnalysis\\data\\household_epc.zip"

# get the names of the files in the zip file
fl_allnames=unzip(tf, list=TRUE)

fname1 <- fl_allnames[1,]
#unzip the file
unzip(tf, files=fname1[,1], exdir=td, overwrite=TRUE)
#define the path
fpath = file.path(td, fname1[,1])
# read ";" file
df_epc <- read.csv2(fpath, header = TRUE, sep = ";")
names(df_epc)
#adding datetime column
df_epc$datetime<-strptime(paste(df_epc[,1],df_epc[,2]),"%d/%m/%Y %H:%M:%S")
#selecting only 2007-02-01 & 02
df_date <- df_epc [as.Date(df_epc$Date,format='%d/%m/%Y')==as.Date('2007-02-01') | as.Date(df_epc$Date,format='%d/%m/%Y')==as.Date('2007-02-02'),]
#convert to date
df_date$Date <- as.Date(df_date$Date,format='%d/%m/%Y')
summary(df_date)

options(digits=4)
#histogram variable
ga<- as.numeric(as.character(df_date[,"Global_active_power"]))
str(ga)
#graph 1
hist(ga,  xlab="Global Active Power (Kilowats)"
     ,main="Global Active Power",col="red")
#saving graph1
dev.copy(png,filename="plot1.png");
dev.off ();


#graph 2
GAP<- data.frame(df_date$datetime,ga)
str(GAP)
plot(GAP,ylab="Global Active Power(kilowatts",type="n",xlab="")
lines(GAP)
dev.copy(png,filename="plot2.png");
dev.off ();

#graph 3
plot(df_date$datetime ,df_date$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(df_date$datetime ,df_date$Sub_metering_1)
lines(df_date$datetime ,df_date$Sub_metering_2,col = "orange")
lines(df_date$datetime ,df_date$Sub_metering_3,col = "blue")
legend("topright", pch = "-",cex=0.5, col = c("black","orange", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
#saving graph
dev.copy(png,filename="plot3.png");
dev.off ();


?pch
#graph 3
plot(df_date$datetime ,df_date$Voltage,type="n",ylab="Voltage",xlab="datetime")
lines(df_date$datetime ,df_date$Voltage)

#preparing grah 4
gr<- as.numeric(as.character(df_date[,"Global_reactive_power"]))
head(gr)
gi<- as.numeric(as.character(df_date[,"Global_intensity"]))
plot(df_date$datetime ,gr,type="n",ylab="Global_machine_power",xlab="datetime")
lines(df_date$datetime ,gr)
lines(df_date$datetime ,gi,col="blue",pch=3)

#final graph
par(mfrow = c(2,2),cex=0.3)
with(df_date,{
  plot(GAP,ylab="Global Active Power(kilowatts",type="n",xlab="")
  lines(GAP)
  
  plot(df_date$datetime ,df_date$Voltage,type="n",ylab="Voltage",xlab="datetime")
  lines(df_date$datetime ,df_date$Voltage)

  plot(df_date$datetime ,df_date$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
  lines(df_date$datetime ,df_date$Sub_metering_1)
  lines(df_date$datetime ,df_date$Sub_metering_2,col = "orange")
  lines(df_date$datetime ,df_date$Sub_metering_3,col = "blue")
  legend("topright", pch = "-", col = c("black","orange", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  
  plot(df_date$datetime ,gr,type="n",ylab="Global_machine_power",xlab="datetime")
  lines(df_date$datetime ,gr)
  lines(df_date$datetime ,gi,col="blue",pch=3)

})

dev.copy(png,filename="plot4.png");
dev.off ();
