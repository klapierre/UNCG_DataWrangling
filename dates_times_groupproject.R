#start of the dates and times

#Add working directory
setwd("/Users/rachaelbrenneman/Desktop/data_wrangle/UNCG_DataWrangling")
setwd("D:/School Stuff/Graduate Studd/Graduate Classes/Spring 2023/UNCG_DataWrangling")
##############################Tentative Outline################################
#intro to dates and times - R
#moving from 12hr to 24hr back and forth - W
#moving from month,day,year to day,month,year -W
##############################Time-zones################################ -E

#Time-zones: Are invisible boundaries created to differentiate time between geographical regions. Timezone Greenwich Mean Time (GMT) is also known as Zulu time. This is where the rest of the time-zones moving east and west are based off of. Moving Westward moves time in the negative direction from -1 to -12, and oppositely eastward time moves in the positive direction from +1 to +12. 
# tzdir
# Sys.timezone is a function that shows time-zones of your dates and time. This is important because researchers across the world fall under time-zones. For our data set we have research points from four different time-zones. date_time_untidy has four different time-zones. 
# Now lets try out the function!

Sys.timezone(date_time_untidy)

#chron is a library that would give date-times without time-zones information.
# Here is a example of how chron is used in R.
date_time_untidy = c("2002-06-09 12:45:40","2003-01-29 09:30:40",
           +            "2002-09-04 16:45:40","2002-11-13 20:00:40",
           +            "2002-07-07 17:30:40")
> dtparts = t(as.data.frame(strsplit(dtimes,' ')))
> row.names(dtparts) = NULL
> thetimes = chron(dates=dtparts[,1],times=dtparts[,2],
                   +                  format=c('y-m-d','h:m:s'))
# Chron values are stored as the fractional number of days from January 1, 1970. 
# The as.numeric function can be used to access the internal values.

#plotting with dates R


########################Possible Resources#####################################
https://rstudio-pubs-static.s3.amazonaws.com/704461_02220f30fffd427e9357c541024446a0.html
https://r4ds.had.co.nz/dates-and-times.html
https://www.r-bloggers.com/2020/04/a-comprehensive-introduction-to-handling-date-time-in-r/
  https://www.stat.berkeley.edu/~s133/dates.html#:~:text=Dates%20and%20Times%20in%20R%20R%20provides%20several,dates%20and%20times%20with%20control%20for%20time%20zones.


########## Untidy ITNL Data ##########

date_time_untidy <-read.csv("date_times_very_untidy.csv")

#SA and NZ: Day/Month/Year
#USA: Month/Day/Year

USA_untidy<- date_time_very_untidy %>%
  filter(Location=="USA")

NZ_untidy<- date_time_very_untidy %>%
  filter(Location== "New Zealand")

SA_untidy<- date_time_very_untidy %>%
  filter(Location== "South Africa")

ITNL_untidy<- full_join(SA_untidy, NZ_untidy)
ITNL_untidy[c('Day','Month', 'Year')]<-str_split_fixed(ITNL_untidy$Date, '/', 3)






##












