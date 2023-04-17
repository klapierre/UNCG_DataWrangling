#Answer Key

################################################################################
################################# Introduction #################################
###############################################################################

#Dates and Times are important and finicky pieces of data to work with. First, we have to set our working directory and run our packages. In this assignment, we will primarily be using these:
library(lubridate)
library(tidyverse)

#Let's start slow by generating some dates and learning what the lubridate package can do for you. There are several useful base commands in Lubridate. 

#TASK: comment beside the code what these commands do
lubridate::today() #today's date
Sys.time() #system designated time
lubridate::now() #date, time, and timezone
lubridate::now(tzone = "UTC") #date, time in UTC timezone
lubridate::leap_year(today()) #this year is not a leap year

#Make an object containing today's date called0 today_date. Use the exact same format R printed in the console when you used lubridate::today()
today_date <- 2023-04-17

#Call today_date and write what happened. Is it what we wanted? 
today_date
#ANSWER: it gives us 2002. This is most definitely not what we want. 

#Check the class of today_date
class(today_date)

#Our date was saved as a numeral, so R went through operations and gave us 2002. This is, to say the least, not ideal for our purposes of storing a date. Let's try writing the date we want in quotes. 

#Question: What is the class of the data now? Is this what we want?
#ANSWER: Is now stored as a character - this is still not what we want

#Storing our date as a character will still not give us what we want because R processes dates differently. Check the class of Sys.Date() and now(). Write what each of the classes print as. 
class(Sys.Date())
class(lubridate::now())

#There are three different classes that R stores dates in. 
#Date: represents calendar dates - use when there is no time component
#POSIX: Portable Operating System Interface - a standard used to maintaining compatability between different operating systems
#POSIXct: represents the number of seconds since 1970 UTC (Why? I have no idea, I did not look up why.) - use when dealing with time and time zones
#POSIXlt: represents the following in a list: seconds, minutes, hour, day of the month, month, year, day of the week, day of year, daylight saving time flag, time zone, and offset in seconds from GMT

#You can use the as.Date() function to save as a date
today_date <- as.Date("2023-04-17")
class(today_date)

#Say you're planning an event, but need to change the dates. We want to be able to shift those dates around. We can do thake with some simple commands.
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

#Task: How many invoices were settled post the due date? 
invoice_delay <- invoice %>% 
  mutate(Delay = Payment - Due) %>% 
  filter(Delay > 0) %>%
  count(Delay)

#Great, now that we're got some of the basics for dates, lets detour to look at the basics of time. Below are some basic commands for times and a short example. Annotate by each what they do on each line. 
day() #extract day
year() #extracts year
month() #extracts month
leap_year() #extracts if leap year
month(12, label = TRUE) #give what month 12 is
ymd_hms() #will parse date-times and second components
hour() #gives hour
second() #extracts second

semester_start <- ymd_hms("2023-01-08 08:00:00") #set date and parse times
year(semester_start) #2023
month(semester_start, label = TRUE) #Jan

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

#ANSWER: four

##############################Time-zones################################ -E

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
#The reason to have a standard/ coordinated time is so people who are working with international partners can have a standard time-zone.




# Task! So for the first task lets get you populating some time-zones. First copy the code above and add in your own time-zone code of choice! ie. gmt, roc, ect.

ymd(20230417, tz= "XXX") 




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
#Being able to convert time-zones helps with creating a better understanding of data being collected across the globe.
# Task Time:)
# Create and name some dates and times named happy_time it should look similar to the E<- that is above!
# Once that is done pick some dates and times of your choice ex. US/Alaska time, GMT, PRC, ect. If you need help just remember we have a code that will pull-up all the time-zones:) OlsonNames(tzdir = NULL).
# This should look very similar to the second code named time_1

xxx <- "2009-06-03 19:30"
format(Important_stuff, tz="xxx/xxx ",usetz=TRUE)

xxx <- c("2009-03-07 12:00", "2009-03-08 12:00", "2009-03-28 12:00", "2009-03-29 12:00", "2009-10-24 12:00", "2009-10-25 12:00", "2009-10-31 12:00", "2009-11-01 12:00")

xxx <- as.POSIXct(E,"America/Los_Angeles")
cbind(US=format(time_1),UK=format(t1,tz="Europe/London"))


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

FK<- date_time_untidy %>%
  filter(Site=="Fort Keogh")

Kru<- date_time_untidy %>%
  filter(Site=="Kreuger National Park")


#Seems like its confusing am and pm. I don't think we can combine everything yet.
#Let's try and break this down

#Task: Research the popular date/time formats for all our locations

#SA and NZ: Day/Month/Year
#USA: Month/Day/Year

#So it seems that Fort Keogh and Lincoln share a format, and so do Krueger and New Zealand
#Lets divide them up so we can put them back together
USA_untidy<- date_time_untidy %>%
  filter(Location=="USA")

NZ_untidy<- date_time_untidy %>%
  filter(Location== "New Zealand")

SA_untidy<- date_time_untidy %>%
  filter(Location== "South Africa")

ITNL_untidy<- full_join(SA_untidy, NZ_untidy)

#Now, let's recombine our dates. First, you need to split the dates apart
#One way to do this is to use the function str_split_fixed. For example:

USA_untidy[c('Month','Day', 'Year')]<-str_split_fixed(USA_untidy$Date, '/', 3)

#Task: Create the correct function to split the dates of the international data

ITNL_untidy[c('Day','Month', 'Year')]<-str_split_fixed(ITNL_untidy$Date, '/', 3)


#Question: Why does this even matter?


#Task: Decide what format you want to put the dates into. Hint:The paste() function may be useful here

USA_untidy<-USA_untidy %>%
  mutate(format12=paste(USA_untidy$Month, USA_untidy$Day, USA_untidy$Year, sep='/')) %>%
  mutate(format24=paste(USA_untidy$Day, USA_untidy$Month, USA_untidy$Year, sep='/'))

#Great! Now, we need to format our times. Let's start with the 12-hour format. We can use this format to change to our required format


USA_tidy<- USA_untidy %>%
  mutate(Time24=format(strptime(USA_tidy$Time.Recorded, "%I_%M %p"), format="%H:%M:%S")) %>%
  mutate(Time12=format(strptime(USA_tidy$Time24, "%H:%M:%S"), format="%I:%M %p")) %>%
  mutate(format24=paste(USA_untidy$Day, USA_untidy$Month, USA_untidy$Year, sep='/'))

#Task: Do the same for the 24-hour format

ITNL_untidy<- full_join(SA_untidy, NZ_untidy) %>%
  mutate(format12=paste(ITNL_untidy$Month, ITNL_untidy$Day, ITNL_untidy$Year, sep='/')) %>%
  mutate(format24=paste(ITNL_untidy$Day, ITNL_untidy$Month, ITNL_untidy$Year, sep='/')) %>%
  mutate(Time24=format(strptime(ITNL_untidy$Time.Recorded, "%H_%M"), format="%H:%M:%S"))



#Now, let's put it all together in your chosen formats!

Combined_tidy<-full_join(USA_tidy, ITNL_untidy) %>%
  select(Site, Location, Luz.Values, format24, Time24)

FortK<- Combined_tidy %>%
  filter(Site=="Fort Keogh")

Lincoln<- Combined_tidy %>%
  filter(Site=="Lincoln National Research Station")

Krueger<- Combined_tidy %>%
  filter(Site=="Kreuger National Park")

NewZ<- Combined_tidy %>%
  filter(Site=="New Zealand Research Federation")


#Lets plot them all using ggplot!

ggplot(Combined_tidy, aes(x = Time24, y = Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values")


ggplot(FortK, aes(x = Time24, y = Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values")


ggplot(Lincoln, aes(x = Time24, y = Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values")


ggplot(Krueger, aes(x = Time24, y = Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values")


ggplot(NewZ, aes(x = Time24, y = Luz.Values)) + 
  geom_point(aes(color= as.factor(Site))) +
  xlab("Time") + 
  ylab("Luz Values")


##