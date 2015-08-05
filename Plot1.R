## Estimate the size of the file

#Read first 1000 rows and check the size of of those.
ThousandLineSize <- object.size(read.table("household_power_consumption.txt", nrow=1000,header = T,sep = ","))
OneLineSize= as.numeric(ThousandLineSize)/1000

#Data Set Information:
        
#This archive contains 2075259 measurements gathered between December 2006 and November 2010 (47 months). 
# Since the data set meta data is aying the file contains 2075259 measurements and then the total file
#size is 2075259 * OneLineSize.

TotalFileSizeInmemory <- OneLineSize*2075259

#convert this to GB to make sure it is less than system memory

TotalFileSizeInmemory <- TotalFileSizeInmemory/ (2^20)

#we do not want R to consume more than 10% of system memory limit
# check the usage
AlreadyUsing<-memory.size()


if (!((AlreadyUsing+TotalFileSizeInmemory) < (memory.limit() /10)))
{
       #If there is sufficient memory and not taking more than  
       #Read the file using Fread and get a data table.
        library(data.table)
        dat <- fread(
                "household_power_consumption.txt"
                , header = TRUE
                ,stringsAsFactors=FALSE
                ,sep = ";"
                )
  
        #filter the dates from the whole data set.
        
        library(dplyr)
        RequiredData<- filter(dat,Date %in% (c("1/2/2007","2/2/2007")))
        globalActivePower <- as.numeric(RequiredData$Global_active_power)
        png("plot1.png", width=480, height=480)
        hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
        dev.off() 
        
        
        
}


