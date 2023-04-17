################################################################################
################################# Introduction #################################
###############################################################################

#Dates and Times are important and finicky pieces of data to work with. First, we have to set our working directory and run our packages. In this assignment, we will primarily be using these:
library(lubridate)
library(tidyverse)

#Let's start slow by generating some dates and learning what the lubridate package can do for you. There are several useful base commands in Lubridate. 

#TASK: comment beside the code what these commands do
lubridate::today() 
Sys.time() 
lubridate::now() 
lubridate::now(tzone = "UTC") 
lubridate::leap_year(today()) 

#Make an object containing today's date called today_date in year-month-day format. Use the exact same format R printed in the console when you used lubridate::today()
today_date <- 2023-04-17 

#Call today_date and write what happened. Is it what we wanted? 
today_date
 

#Check the class of today_date
class(today_date)
#Class was "numeric"

#Our date was saved as a numeral, so R went through operations and gave us 2002. This is, to say the least, not ideal for our purposes of storing a date. Let's try writing the date we want in quotes. 
today_date <- "2023-04-17"
class(today_date)

#Question: What is the class of the data now? Is this what we want?
#Now the date is stored as "character". No, we want this to be recognized as a date.

#Storing our date as a character will still not give us what we want because R processes dates differently. Check the class of Sys.Date() and now(). Write what each of the classes print as. 
class(Sys.Date())
class(lubridate::now())

#There are three different classes that R stores dates in. 
#Date: represents calendar dates - use when there is no time component
#POSIX: Portable Operating System Interface - a standard used to maintaining compatibility between different operating systems
#POSIXct: represents the number of seconds since 1970 UTC (Why? I have no idea, I did not look up why.) - use when dealing with time and time zones
#POSIXlt: represents the following in a list: seconds, minutes, hour, day of the month, month, year, day of the week, day of year, daylight saving time flag, time zone, and offset in seconds from GMT

#You can use the as.Date() function to save as a date
today_date <- as.Date("2023-04-17")
class(today_date)

#Say you're planning an event, but need to change the dates. We want to be able to shift those dates around. We can do that with some simple commands.
event_start <- as_date('2022-05-12')
event_end <- as_date('2022-05-21')
event_duration <- event_end - event_start
event_duration

#We can mess around with the dates we added and add additional days to our imputed dates. 
event_start + days(2)
event_start + weeks(3)
event_start + years(1)

#Now that we know the basics, let's look at this with a bit more context. Take note of what order the dates are listed. The following csv is a record of payments. 
invoice <- readr::read_csv('https://raw.githubusercontent.com/rsquaredacademy/datasets/master/transact.csv')

#Task: Make a new data frame titled invoice_delay. How many invoices were settled post the due date? 
invoice_delay <- invoice %>% 
  mutate(Delay = Payment - Due) %>% 
  filter(Delay > 0) %>%
  count(Delay)
print(nrow(invoice_delay))

#Great, now that we're got some of the basics for dates, lets detour to look at the basics of time. Below are some basic commands for times and a short example. Annotate by each what they do on each line. 

day() #Returns the current day of the month as a numeric value
year() #Returns the current year as a numeric value 
month() #Returns the current month as a numeric value
leap_year() #Returns TRUE if the current year is a leap year, and FALSE otherwise
month(12, label = TRUE) #Returns the abbreviated name of the month corresponding to the numeric value
ymd_hms() #Splits a character string into an object with year, month, day, hour, minute, and second information
hour() #Returns the current hour as a numeric value
second() #Returns the current second as a numeric value

#Run this code and observe the results
semester_start <- ymd_hms("2023-01-08 08:00:00") 
year(semester_start) 
month(semester_start, label = TRUE) 

#Let's go back to our invoice data. Let's say we're trying to know a bit more about our data. 

#TASK: Extract the day, month, and year from the Due column. Make a new data from called invoice_due with your extracted dates.  
invoice_due <- invoice %>% 
  mutate(due_date = day(Due), 
         due_month = month(Due), 
         due_year = year(Due))

#This new knowledge still isn't enough. We now want to know if a particular year is a leap year. 

#TASK: Make another new data frame called invoice_leap with the information you find out. Once you have extracted your dates, filter down and find out how many payments were conducted on February 29th? *Hint: the first part of this task is almost identical to what we did in the previous. 
invoice_leap <- invoice %>%
  mutate(
    due_day   = day(Due),
    due_month = month(Due),
    due_year  = year(Due),
    is_leap   = leap_year(due_year)
  ) %>%
  filter(due_month == 2 & due_day == 29) %>%
  select(Due, is_leap)
View(invoice_leap)


################################################################################
###############################Time Zones#######################################
################################################################################

#Time-zones: Are invisible boundaries created to differentiate time between geographical regions. Timezone Greenwich Mean Time (GMT) is also known as Zulu time, or the Coordinated Universal Time (UTC). This is where the rest of the time-zones moving east and west are based off of. Moving Westward moves time in the negative direction from -1 to -12, and oppositely eastward time moves in the positive direction from +1 to +12. 
# tzdir
# Sys.timezone is a function that shows time-zones of your dates and time. This is important because researchers across the world fall under time-zones. For our data set we have research points from four different time-zones. date_time_untidy has four different time-zones. 
# Now lets try out the function!

# First step load these packages up!


library(ggplot2)
library(tidyverse)
library(lubridate)
library(nycflights13)

# R can predict the time-zone you are in right now! How cool. Now run the following code and lets see if R.studio is right.

Sys.timezone()
# Another way to do the same thing is with using this code.

Sys.timezone(location = TRUE)

# Just incase you need informatio regarding time-zones lets give you a helpful code that will populate all the time-zone codes and the regions they are associated with!

OlsonNames(tzdir = NULL)

# To add a time-zone is pretty simple:') so lets give it a try!

ymd(20170131, tz = "UTC")

ymd(20230417, tz= "GMT")

# For this code we added a date and the time-zone which is UTC which is our referenced Zulu time!

# Question: Why would we want to have a standardized/coordinated time?
#To keep the coherence within the data set, that way there is no ambiguity on the timeline


# Task! So for the first task lets get you populating some time-zones. First copy the code above and add in your own time-zone code of choice! ie. gmt, roc, ect.
ymd(20230417, tz= "Brazil/East") 


# Next we are going to cover converting time-zones.

# First lets create a time 
Important_stuff <- "2009-06-03 19:30"

# convert it to R object for London time zone.

Important_stuff <- as.POSIXct(Important_stuff, tz="Europe/London")

# Now lets convert it to PDT time zone.

format(Important_stuff, tz="America/Los_Angeles",usetz=TRUE)


# This process can also be done for many date at once! 


E <- c("2009-03-07 12:00", "2009-03-08 12:00", "2009-03-28 12:00", "2009-03-29 12:00", "2009-10-24 12:00", "2009-10-25 12:00", "2009-10-31 12:00", "2009-11-01 12:00")

time_1 <- as.POSIXct(E,"America/Los_Angeles")
cbind(US=format(time_1),UK=format(t1,tz="Europe/London"))

# Question: What would be useful about being able to convert time-zones?
#Having a standard for your dataset is especially important when you have colaborators worldwide. That way there is no confusion about the data collected, no distortion in the timeline and the accuracy of any reports will be higher.

# Task Time:)
# Create and name some dates and times named happy_time it should look similar to the E<- that is above!
# Once that is done pick some dates and times of your choice ex. US/Alaska time, GMT, PRC, ect. If you need help just remember we have a code that will pull-up all the time-zones:) OlsonNames(tzdir = NULL).
# This should look very similar to the second code named time_1
hora <- "2009-06-03 19:30"
hora <- as.POSIXct(hora, tz="US/Aleutian")
format(hora, tz="Australia/Perth",usetz=TRUE)

happy_time <- c("2009-09-06 17:00", "2012-10-29 16:45", "1978-09-22 09:02", "1953-02-15 23:00", "1954-10-22 02:00", "1976-02-12 08:00")

happy_time <- as.POSIXct(hora,"US/Aleutian")
cbind(US=format(hora),AUS=format(happy_time,tz="Australia/Perth"))

###################################################################################
##################################### Converting Dates ############################
################################################################################


library(tidyverse)

#For large-scale projects like multi-continental or global experiments, they ften involve working with scientists internationally to collect data. This is especially true if the research requires sampling many times a year.

#In these cases, it is often vital to understand how time plays a role in these interactions.

#Different places around the world will have different ways of portraying times and dates. Let's take a look at the date_times dataset.


#Load the 'date_time_very_untidy.csv'
date_time_untidy <-read.csv("date_time_very_untidy.csv")


#Let's run this data!
ggplot(date_time_untidy, aes(x = Time.Recorded, y = Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values")

#Hmmm...It runs, but its understanding of times are misconstrued
#Take a close look
#Lets try and run these individually. Maybe its our formatting?

Unt_Keogh <- date_time_untidy %>%
  filter(Site=="Fort Keogh")

Unt_Kreuger <- date_time_untidy %>%
  filter(Site=="Kreuger National Park")

Unt_Lincoln <- date_time_untidy %>%
  filter(Site=="Lincoln National Research Station")

Unt_NZeal <- date_time_untidy %>%
  filter(Site=="New Zealand Research Federation")

#Seems like its confusing am and pm. I don't think we can combine everything yet.
#Let's try and break this down

#Task: Research the popular date/time formats for all our locations
Unt_USA <- date_time_untidy %>%
  filter(Location=="USA")

Unt_NZeal <- date_time_untidy %>%
  filter(Location== "New Zealand")

Unt_SA <- date_time_untidy %>%
  filter(Location== "South Africa")


#So it seems that Fort Keogh and Lincoln share a format, and so do Krueger and New Zealand
#Lets divide them up so we can put them back together
Unt_Merge <- full_join(Unt_SA, Unt_NZeal)

#Now, let's recombine our dates. First, you need to split the dates apart
#One way to do this is to use the function str_split_fixed. For example:

#Task: Create the correct function to split the dates of the international data
Unt_USA[c('Month','Day', 'Year')]<-str_split_fixed(Unt_USA$Date, '/', 3)
Unt_Merge[c('Day','Month', 'Year')]<-str_split_fixed(Unt_Merge$Date, '/', 3)


#Question: Why does this even matter?
#Splitting the elements of the date gives you more flexibility to filter your data. It is useful to sort out data by individual years, months, weeks, or days.


#Task: Decide what format you want to put the dates into. Hint:The paste() function may be useful here
Unt_USA<-Unt_USA %>%
  mutate(format12=paste(Unt_USA$Year,Unt_USA$Month,Unt_USA$Day, sep='-')) %>%
  mutate(format24=paste(Unt_USA$Month,Unt_USA$Day,Unt_USA$Year, sep='/'))
view(Unt_USA)

#Great! Now, we need to format our times. Let's start with the 12-hour format. We can use this formula to change the 12-hour format to the 24-hour. Now from 24 hours to 12-hour format


#Task: Do the same for the International data
tidy_USA<- Unt_USA %>%
  mutate(Time24=format(strptime(tidy_USA$Time.Recorded, "%I_%M %p"), format="%H:%M:%S")) %>% 
  mutate(format24=paste(Unt_USA$Day,Unt_USA$Month,Unt_USA$Year, sep='/'))

tidy_Merge<- Unt_Merge %>%
  mutate(Time24=format(strptime(tidy_Merge$Time.Recorded, "%I_%M"), format="%H:%M:%S")) %>%
  mutate(format24=paste(Unt_Merge$Day,Unt_Merge$Month,Unt_Merge$Year, sep='/'))

#Now, let's put it all together in your chosen formats!
tidy_USA<- Unt_USA %>%
  mutate(Time24=format(strptime(tidy_USA$Time.Recorded, "%I_%M %p"), format="%H:%M:%S"))

#Lets plot them all using ggplot!
tidy_fullMerge<-full_join(tidy_USA, tidy_Merge) %>%
  select(Site, Location, Luz.Values, format24, Time24)

Keogh<- tidy_fullMerge %>%
  filter(Site=="Fort Keogh")

Lincoln<- tidy_fullMerge %>%
  filter(Site=="Lincoln National Research Station")

Krueger<- tidy_fullMerge %>%
  filter(Site=="Kreuger National Park")

NewZeal<- tidy_fullMerge %>%
  filter(Site=="New Zealand Research Federation")
  

ggplot(tidy_fullMerge, aes(x=Time24, y=Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values") +
  labs(color="Site:")


ggplot(Keogh, aes(x=Time24, y=Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values") +
  labs(color="Site:")


ggplot(Lincoln, aes(x=Time24, y=Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values") +
  labs(color="Site:")


ggplot(Krueger, aes(x=Time24, y=Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values") +
  labs(color="Site:")


ggplot(NewZeal, aes(x = Time24, y = Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values") +
  labs(color="Site:")
##






