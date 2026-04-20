# ---------------------------------------------------------- #
#### Group 4's Assignment: Lubridate!                     ####               
# ---------------------------------------------------------- #

## OBJECTIVE:
# 1. Using the lubridate package to parse, manipulate, and extract info from time and date data. 
# 2. Apply lubridate functions to datasets to analyze and transform time variables including time zones, rounding dates, and working with intervals and durations. 

# ---------------------------------------------------------- #
#### SET UP:                                              ####
# ---------------------------------------------------------- #

# Make sure you are starting with a clean environment by running "rm(list = ls())"

# Install the "lubridate" package and load it in your library. 
# HINT: look at past assignments to compete these steps.

# We will also have to do some other data cleaning, to do this load tidyverse as well.
library(tidyverse)
library(lubridate)
# ---------------------------------------------------------- #
### 1.0 CONVERTING DATES AND TIMES ####                                           
# ---------------------------------------------------------- #

# A Unix timestamp measures the number of seconds that have passed since January 1st, 1970 at 00:00:00 UTC; this is referred to as the 'Epoch'. This is useful for computing systems because it stores all time measurements as one large number, rather than more complex formats such as month/day/year. The date-times functions in lubridate allow users to quickly convert Unix measurements to more user-friendly formats.  

dt_practice <- as_datetime(946684860)

# QUESTION: Run the code above to convert the Unix measurement to ymd_hms format using the ‘as_datetime’ function. What date and time does the timestamp correspond to?
## It corresponds to January 1, 2000 at 1am UTC time.

# Unix timestamps are also measured in days since January 1st, 1970. The ‘as_date’ function can be used to convert these measurements to ymd format.
# QUESTION: What holiday does the 20392 Unix days timestamp correspond to? What year? HINT: Use the ‘as_date’ function to convert days to ymd format. 
## It corresponds to Halloween in 2025.
dt_holiday <- as_date(20392)


# Unix timestamps can also measure seconds passed since 00:00:00 (with no corresponding date or time zone). The ‘as_hms' function can be used to convert these measurements to hms format. 
# TASK: Run the following code to convert 10,000 seconds to hours. 

print(dt_time <- hms::as_hms(10000))

#QUESTION: How many hours are 86,400 seconds? HINT: Use the ‘as_hms’ function to convert seconds to hms format.

print(dt_time_86 <- hms::as_hms(86400))
## There's 24 hours.

# ----------------------------------- #
### 1.1 PARSING DATES AND TIMES ####                                           
# ----------------------------------- #

# Parsing is the process of converting strings or numbers to into standard date-time format (ymd_hms). This can be done one value at a time, or for an entire column. 
# You can parse date-times with several different functions, so it's important to use the function that corresponds to your input value!
# TASK: Run the following lines of code to view how lubridate converts different date-time formats.

ymd_hms("2026-04-14 14:00:00")
ydm_hms("2026-14-04 14:00:00")
mdy_hms("04/14/2026 14:00:00")
dmy_hms("14 Apr 2026 14:00:00")

# TIP: If your data only includes dates without a timestamsp, you can use the same functions by removing '_hms' from the function. 
#TASK: Run the following lines of code to convert these dates that lack time values.

ymd("20260414")
ydm("2026-14-04")
mdy("April 14th, 2026")
dmy("14th of April '26")

#TASK: Run the following line of code to convert "07-04-12" (July 4th, 2012) to standard date-time format. 

ydm("07-04-12")

# QUESTION: Is the output value correct? Why not? Rewrite the code with the same input using the correct function below. 
## The above output gave me December 4, 2007 because the numbers were in the wrong order.
mdy("07-04-12") 

#TASK: Use any of the parsing functions to convert your birthday into standard date format in the space below. 

mdy("October 4, 2003") #Example

# Parsing data is super convenient, but what if we want to parse an entire column at once?
#TASK: Load the nycflights13 dataset. Run the following code to "break" the dataset (turning the timestamps into strings) so we can practice parsing date-times.

install.packages("nycflights13")
library(nycflights13)

broken_flights <- flights %>%
  mutate(
    flight_date = format(time_hour, "%B %d, %Y"), 
    flight_time = format(time_hour, "%I: %M: %S %p")) %>% 
  select(flight, tailnum, origin, dest, flight_date, flight_time)

#TASK: Run the following code to convert flight times back to formal time objects in the flight_data_parsed dataframe.

flight_data_parsed <- broken_flights %>% mutate(flight_time = hms::as_hms(flight_time))

#TASK: In the same flight_data_parsed dataframe, parse the flight_date column. 
#HINT: Use the mutate function with the appropriate parsing function form the previous section.

flight_data_parsed <- flight_data_parsed %>% mutate(flight_date = mdy(flight_date)) #Example

# ---------------------------------------------------------- #
### 1.2 GETTING AND SETTING DATES AND TIMES ####                        
# ---------------------------------------------------------- #

# Before exploring more functions in lubridate, lets check out one more useful function for setting a date-time value.The 'now()' function allows us to find the date-time value for this exact moment in time. 
#TASK: Run the following code to create the 'todays_timestamp' object with the 'now()' function.

todays_timestamp <- now()

# Lubridate helpful for finding specific components of date-time data.
# TASK: Run the following lines of code to isolate specific components of the date-time value. 

date(todays_timestamp)
year(todays_timestamp)
month(todays_timestamp)
day(todays_timestamp)
hour(todays_timestamp)
minute(todays_timestamp)
second(todays_timestamp)

#QUESTION: Run the following lines of code. What do you think each function is finding?

week(todays_timestamp) 
wday(todays_timestamp)
## The first one is likely finding what week of the year it is while the second
## function finds the day number relative to this week.

#TASK: What if we wanted to create new column in our flights dataset listing the day of the week of the flight? Run the following code to create a flight_day column in our flight_data_parsed dataset.

flight_data_parsed <- flight_data_parsed %>% mutate(flight_day = wday(flight_date, label = TRUE, abbr = FALSE))

#QUESTION: What do 'label' and 'abbr' mean in the code above?
# HINT: Try running the code without the 'label' and 'abbr' arguments.
unlabeled_data <- flight_data_parsed %>% mutate(flight_day = wday(flight_date))
no_label <-flight_data_parsed %>% mutate(flight_day = wday(flight_date, abbr = FALSE))
no_abbr <-flight_data_parsed %>% mutate(flight_day = wday(flight_date, label = TRUE))
## The label argument labels the day with the word rather than the number.
## The abbr argument dictates whether or not the label is abbreviated or fully written out.

#TASK: Create a new column called 'flight_month' in the flight_data_parsed dataset that lists the names of the months that the flights took place. 
flight_data_parsed <- flight_data_parsed %>% mutate(flight_month = month(flight_date))


# ---------------------------------------------------------- #
### 1.3 ROUNDING DATES AND TIMES ####                                  
# ---------------------------------------------------------- #

# There might be times where you want to round your data. For example, what if you wanted to round to the nearest month? 

# TASK: The functions 'floor_date' and 'ceiling_date' will round down and up to the nearest unit, respectively. Run the following lines of code and take note of the output values.

floor_date(mdy("April 15 2026"), "month")
ceiling_date(mdy("April 15 2026"), "month")

# QUESTION: The 'round_date' function is a general rounding function. Run the following line of code. Does 'round_date' round up or down?
# HINT: April has 30 days. 
round_date(mdy("April 16 2026"), "month")
## It rounds up to May.

# QUESTION: Run the following line of code. What do you think the 'rollback' function does? What do you think the 'roll_to_first' and  'preserve_hms' arguments do?
# HINT: Try running the code with different 'roll_to_first' and  'preserve_hms' arguments.
rollback(todays_timestamp, roll_to_first = FALSE, preserve_hms = TRUE)
rollback(todays_timestamp, roll_to_first = TRUE, preserve_hms = TRUE)
rollback(todays_timestamp, roll_to_first = FALSE, preserve_hms = FALSE)
rollback(todays_timestamp, roll_to_first = TRUE, preserve_hms = FALSE)
## The function goes back to last month relative to the date in question.
## The  roll_to_first argument dictates whether to use the last day of the 
## previous month or the first day of the current month. The preserve_hms
## Argument dictates whether the exact timestamp is preserved or just
## the date.

# TASK: Create a dataframe named 'flight_data_rounded' from our 'flight_data_parsed' dataframe that includes a column named 'rounded_flight_date' that rounds the flight date to the nearest month. 
flight_data_rounder <-flight_data_parsed %>% mutate(rounded_flight_date = round_date(ymd(flight_date), "month"))

# ---------------------------------------------------------- #
#### Part 1.1: Duration & Intervals                       ####
# ---------------------------------------------------------- #

# Durations and intervals are both ways to measure spans of time in lubridate.
# In this section, we will practice creating durations, adding durations to times, creating intervals, and measuring how long an interval lasts.

# TASK: Create a smaller dataframe called 'flight_timespans'using the first 20 rows of flights.
flight_timespans <- head(flights, 20)

# The time_hour column already contains a date-time value.
# We will use this as a simple starting time for each flight.
# TASK: Create a new column called departure_time from the time_hour column.
flight_timespans <- flight_timespans %>% 
  mutate(time_hour = force_tz(time_hour, "EST")) %>% 
  mutate(departure_time = ymd_hms(time_hour))

# A duration is an exact amount of time.
# Lubridate creates durations with functions like dseconds(), dminutes(), dhours(), and ddays().
# Question: What does the "d' stand for in these functions? 
## Duration?

# TASK: Run the following examples.
dseconds(30)
dminutes(10)
dhours(2)
ddays(1)

# In our flights data, air_time is measured in minutes.
# We can convert those minute values into durations with dminutes().
# EXAMPLE: Run this line to turn air_time into a duration.
flight_timespans <- flight_timespans %>%
  mutate(flight_duration = dminutes(air_time))

# TASK: Look at only the air_time and flight_duration columns.

# QUESTION: What does dminutes(air_time) do?
## It specifies that the given duration is in minutes.

# Since durations are exact spans of time, we can add them to a date-time.
# For example, adding 2 hours to a date-time moves it forward by exactly 2 hours.
# EXAMPLE: Run the following lines.
departure_time_example <- dmy_hms("01-01-2013 05:00:00")

departure_time_example + dhours(2)

# TASK: Add 1 hour to departure_time_example.
departure_time_example + dhours(1)

# TASK: Add 90 minutes to departure_time_example.
departure_time_example + dminutes(90)

# We can do the same thing with the flight data.
# If we add flight_duration to departure_time, we get an estimated arrival time.

# EXAMPLE: Run the following code to create arrival_time_estimate.
flight_timespans <- flight_timespans %>%
  mutate(arrival_time_estimate = departure_time + flight_duration)

# TASK: View just these columns (carrier, flight, departure_time, flight_duration, arrival_time_estimate).

# QUESTION: What happens when we add flight_duration to departure_time?
## It gives us the time thingy in seconds.

# TASK: Which flight in this data has the longest duration?
# Only view these columns (carrier, flight, origin, dest, air_time).
# HINT: Arrange the table from largest to smallest air_time.
## Flight 1124 has the longest duration.

# An interval is different from a duration.
# A duration is only a length of time.
# An interval stores both a starting date-time and an ending date-time.
# We create an interval with interval(start, end).

# EXAMPLE: Run the following code.
practice_interval <- interval(dmy_hms("01-01-2013 08:00:00"),
                              dmy_hms("01-01-2013 11:30:00"))

# QUESTION: What two things do you need to make an interval?
## A start and an end time.

# We can also check the start and end of an interval with int_start() and int_end().
# EXAMPLE: Run the following lines.
int_start(practice_interval)
int_end(practice_interval)

# TASK: Create an interval from 2:00 PM to 4:50 PM on April 13th, 2026. Use 24-hour (military) time with dmy_hms(). Name the dataframe 'class_interval'.
class_interval <- interval(dmy_hms("13-04-2026 14:00:00", tz = "America/New_York"), dmy_hms("13-04-2026 16:50:00", tz = "America/New_York"))

# TASK: Check the start and end of class_interval.
int_start(class_interval)
int_end(class_interval)

# Now let us make intervals for our flight data.
# We already have a departure_time and an arrival_time_estimate.
# That means we can create an interval for each flight.
# EXAMPLE: Run the following code.
flight_timespans <- flight_timespans %>%
  mutate(flight_interval = interval(departure_time, arrival_time_estimate))

# TASK: View only the interval-related columns (carrier, flight, departure_time, arrival_time_estimate, flight_interval).

# QUESTION: What does flight_interval represent?
## It represents the start and end time estimates for the flights.

# We can measure the length of an interval by converting it to a duration.
# Then we can use time_length() to look at that duration in hours or minutes.
# EXAMPLE: Run the following lines on practice_interval.
time_length(as.duration(practice_interval), "hour")

time_length(as.duration(practice_interval), "minute")

# TASK: Find the length of class_interval in hours.

# TASK: Find the length of class_interval in minutes.

# We can do the same thing for every flight in our dataframe.
# EXAMPLE: Run the following code to measure each flight interval.
flight_timespans <- flight_timespans %>%
  mutate(duration_hours = time_length(as.duration(flight_interval), "hour"),
         duration_minutes = time_length(as.duration(flight_interval), "minute"))

# TASK: View the most useful columns to compare flight times.
flight_timespans %>%
  select(carrier, flight, origin, dest, air_time, duration_minutes, duration_hours)

# QUESTION: Why are the columns air_time and duration_minutes the same?
## It's because they both measure how long the plane is in the air in minutes.

# TASK: Find the longest flight interval in this dataframe.
## It's flight 1124.

# TASK: Create a new column called short_or_long.
# Label a flight as "long" if duration_minutes is 180 or more. Otherwise label it "short".
# Hint: Use the if_else() function to create values based on a condition. 
flight_timespans <- mutate("short_or_long" = if_else("duration_minutes" >= 180, "long", "short"))

# TASK: Count how many flights are short and how many are long.
## 7 long, 13 short

# QUESTION: What is the difference between a duration and an interval?
## Duration is an amount of time elapsed and interval is two timestamps.

# QUESTION: Explain why intervals are useful.
## Intervals can be useful for things like scheduling.

# ---------------------------------------------------------- #
#### Part 1.2: Date Arithmetic                            ####
# ---------------------------------------------------------- #

## TASK: load in beneficials_unified.csv and rename it data_set
data_set <-read.csv("beneficials_unified.xlsx.pdf")
## Now we will clean the data set to only contain data with time 
clean_time_data <- data_set %>% ## keep in assignmet 
  select(-(1:26), -(38:43)) ## keep in assignment 
## https://youtu.be/MJdAgKV-tt8
## now we will create a start datetime ##
clean_time_data <- clean_time_data %>%
  mutate(
    start_datetime = make_datetime(
      year = startYear,
      month = startMonth,
      day = startDay,
      hour = startHour,
      min = startMinute
    )
  )
## TASK: create a end datetime ##
clean_time_data <- clean_time_data %>%
  mutate(
    end_datetime = make_datetime(
      year = endYear,
      month = endMonth,
      day = endDay,
      hour = endHour,
      min = endMinute
    )
  )
## TASK: check each new dataset what do you see? ##
#there should be a new column added in the end of the data set with the year,
#month, day, hour and minute together. 
## Type in the following code below --
clean_time_data2 <- clean_time_data %>%
  mutate(
    start_year = year(start_datetime),
    start_month = month(start_datetime),
    start_day = day(start_datetime),
    start_weekday = wday(start_datetime, label = TRUE)
  )
## Question: why did we do this step? 
## It adds ub the start year, month, day, and weekday columns.

# Okay, now that we have cleaned up our data we are ready for the math!
## lubridate can help you calculate time in the past and present--

# lets add 6 days to our start_datetime column in clean_time_data2
clean_time_data2 <- clean_time_data2 %>%
  mutate(start_plus_7 = start_datetime + days(7))
## Task- check the data set which column changed ? 
start_day 
## Probably the start_datetime column.

##  question why would this be helpful ? 
## Allows us to change the dates.

#  it can help us predict future dates and can help us compare a time window 
## TASK: Subtract month from clean_time_data2 
clean_time_data2 <- clean_time_data2 %>%
  mutate(start_minus_1month = start_datetime - months(1))
## TASK: View the dataset clean_time_data2- what do you see?
## Theoretically, there's a new column that's the same as the start date, 
## except it's a month earlier.

# 2 new columns with information
## why is this useful ?
## Gives us new dates related to the ones we started with..?

## lets us check the difference between the end and start 
clean_time_data2 <- clean_time_data %>%
  mutate(
    duration_calc = end_datetime - start_datetime
  )
## what is the difference in column one #hint look at the end last column in the
# dataset 
## It's the duration between the end date and the start date.

## okay lets work with real time, first we are gonna look at the today's date
today_date <- today ()
## now create a new dataset called my_birthday and include your own birthday. 
## if your birthday as already passed use another date- 
## hint ymd 
my_birthday <- ymd("2003-10-04")
# now we will create data set called my birthday this year 
my_birthday_this_year <- ymd(paste0(year(today_date), "-10-04"))
## create a dataset called birthday_time and subtract my_birthday_this_year and 
## today_data
birthday_time <- my_birthday_this_year - today_date
## TASK: View this dataset you just create ? what does this value mean?
birthday_time
## It says how many days there are before my birthday this year.

## Okay now lets figure out what day it is gonna be 60 days from now
# TASK - Add 30 days to today_date and rename the dataset to days_30
days_30 <- today_date + days(30)
# question: what is the day 30 days from now? 
days_30
## May 18, 2026

## Task: create another data set with today_date but subtract 30 days and rename
# to days_minus_30
days_minus_30 <- today_date - days(30)
## what is the date ?
days_minus_30
## March 19, 2026

## question: How is lubridate and arithmetic useful? 
## Allows us to adjust dates.

# ---------------------------------------------------------- #
#### Part 1.3: Time Zones                                 ####
# ---------------------------------------------------------- #

## Knowledge of time zones is important as the same clock time can have different meanings globally.
## Lubridate provides tools for checking, assigning, and converting time zones.
## In this section, we'll practice
## 1) Using tz() to check a time zone ## 2) Converting a time with with_tz() ## 3) Assigning a zone with force_tz() ## 4) Extracting date time elements  
## 5: Using Time Zones in NYC Flights13 dataset


## First, we'll produce a date time object in UTC.
## UTC is a standard world time that is widely used in datasets and computers.

time_utc <- ymd_hms("2026-04-14 18:00:00", tz = "UTC")
time_utc

## QUESTION: What does the 'tz' argument produce?
## It sets the timezone for the timestamp.

## TASK: Determine the time zone of 
tz(time_utc)
## UTC

## The with_tz() function shows the exact same moment in a different timezone.
time_ny <- with_tz(time_utc, tzone = "America/New_York")
time_ny

## QUESTION: Has the actual moment in time changed?
## No

##TASK: Convert time_UTC to Los Angeles time.
time_la <- with_tz(time_utc, tzone = "America/Los_Angeles")
time_la

## TASK: Convert time_UTC to Chicago time.
time_chicago <- with_tz(time_utc, tzone = "America/Chicago")
time_chicago

## TASK: Convert time_UTC to Tokyo time.
time_tokyo <- with_tz(time_utc, tzone = "Asia/Tokyo")
time_tokyo

## TASK: Print all converted times.
time_chicago
time_la
time_ny
time_tokyo
time_utc

##QUESTION: Why do the shown clock times appear different?
## They're converted to whatever time zone they're meant to be.

##QUESTION: Are these different moments?
## No

## Force_tz() is a handy function.
## With_tz() keeps the current moment in time.
## force_tz() maintains the same clock time while changing the attached zone.
## Force_tz() is a handy function.
time_with_tz <- with_tz(time_utc, tzone = "America/New_York")
time_force_tz <- force_tz(time_utc, tzone = "America/New_York")

## TASK: Run the two objects below.
time_with_tz
time_force_tz

## QUESTION: What's the main difference between with_tz() and force_tz()?
## The former has the same timestamp converted to a different timezone while
## the latter sets the timezone of a timestamp to the specified timezone.

##TASK: Determine the time zone for both items.
tz(time_with_tz)
tz(time_force_tz)
## They're both America/New York.

## Time zones are helpful for meetings, flights, and scheduling.
## Let us create a short array of meeting times in UTC.
meeting_times_utc <- ymd_hms(c("2026-04-14 13:00:00",
                               "2026-04-14 16:30:00",
                               "2026-04-14 20:45:00"), tz = "UTC")
meeting_times_utc

## TASK: Convert the meeting times to New York time.
meeting_times_ny <- with_tz(meeting_times_utc, tzone = "America/New_York")
meeting_times_ny

## TASK: Add the meeting timings to a dataframe.
meeting_data <- data.frame(
  meeting_id = 1:3,
  utc_time = meeting_times_utc,
  ny_time = meeting_times_ny)
meeting_data

## TASK: Determine the hour and weekday of the New York meeting times.
meeting_data <- meeting_data %>%
  mutate(ny_hour = hour(ny_time),
         ny_day = wday(ny_time, label = TRUE, abbr = FALSE))

meeting_data
## 9am Tuesday, 12pm Tuesday, and 4pm Tuesday.

## QUESTION: How is this useful?
## It makes it easier to set up international meetings.

## The nycflights13 dataset includes flight data from New York City flights.

## Lubridate can be used to create date time columns and practice time zones.

## TASK: Review the first few rows of the flights dataset.

## TASK: Create a smaller practice dataframe by selecting flight columns.
flight_timezones <- flights %>%
  select(year, month, day, hour, minute, carrier, flight, origin, dest) %>%
  slice(1:10)

flight_timezones

## Because these flights depart from New York, the mentioned times are New York local time.
## TASK: Add a New York departure time column.
flight_timezones <- flight_timezones %>%
  mutate(dep_time_ny = make_datetime(year, month, day, hour, minute,
                                     tz = "America/New_York"))

flight_timezones
## TASK: Convert dep_time_ny into UTC and Los Angeles time.
flight_timezones <- flight_timezones %>%
  mutate(dep_time_utc = with_tz(dep_time_ny, tzone = "UTC"),
         dep_time_la = with_tz(dep_time_ny, tzone = "America/Los_Angeles"))

flight_timezones



## QUESTION: Why do dep_time_ny, dep_time_utc, and dep_time_la display different hours?
## It's because they're across different timezones.

## TASK: Determine the departure hour and weekday in New York Time.
flight_timezones <- flight_timezones %>%
  mutate(dep_hour_ny = hour(dep_time_ny),
         dep_day_ny = wday(dep_time_ny, label = TRUE, abbr = FALSE))

flight_timezones

## TASK: Determine how many of these practice flights depart during the course of each New York hour.
flight_timezones %>%
  count(dep_hour_ny)
## 5 are at 5am and 5 at 6am (I think, it's slightly confusing to read).

## QUESTION: Why is local time better than UTC for human scheduling?
## It's because the time at UTC is not the same time for the majority of other regions.

##QUESTION: In one sentence, explain time zone conversion in lubridate.
## It just converts a given timestamp to the same time in a different timezone.

# ---------------------------------------------------------- #
#### Part 2.0: Practicing your skills                       ####
# ---------------------------------------------------------- 

# Great! Now that you have learned many of the functions that lubridate has to offer, let's put your skills to the test!

# We will be using a the beneficials_united.csv dataset for this section. 
# Remember to save the file where your working directory is. 
# HINT: use "getwd()" to check your working directory to determine where to save the file. 

# We will need to tidy this data before we can start practicing with lubridate.

#TASK: You will notice that this data has a lot of redundant observations. Load the "beneficials_unified.csv" into R using the read.csv function and name the dataframe "beneficials".
install.packages("readxls")
library(readxl)
beneficials <-read_excel("beneficials_unified.xlsx")

# TASK: Using the same workflow, lets make a dataframe of only the data that we will be using for lubridate. 
# (1) name the new dataframe "arthropods" and use the beneficials data
arthropods <- beneficials

# (2) there is a lot of redundant data and again, we want to make a dataframe that only has the data we will need. For this dataframe, we will only be using the columns "arthOrder" through "deployedhours". Use the select function to select all columns between (and including) "arthOrder" and "deployedhours". Hint: you should have a total of 27 columns after this is done. Revisit previous assignments to select for large chunks without having to type all the column names you wish to include. 
arthropods <- mutate(select(arthropods, 1:27))
## From this point and beyond I have no way of testing the code since the data
## is glitched somehow to only be one column.

# (3) unite the genus and species names and name this new column "species". Separate the obsevations with a single space (" ")
arthropods <- unite("species", "genus", "species", sep = " ")

# (4) using the select function, remove "family", "genus", "subgenus", "longTrap", "latTrap", and "elevTrap"
arthropods <- select(arthropods, -c("family", "genus", "subgenus", "longTrap", "latTrap", "elevTrap"))

# (5) rename "arthOrder" to "order"
arthropods <- rename(arthropods, "order" = "arth0rder")

#QUESTION: How many variables does the "arthropods" dataset have? Why does this number differ from the "beneficials" dataset? 
## It likely has less variables than the beneficials dataset due to
## theoretically removing columns.

#Great! Now we can start using the lubridate package!

#TASK: Parse out the data 
# (1) make a new dataframe and label it "arthropods_clean" from the arthropods data. 
arthropods_clean <- arthropods

# (2) using the mutate function make a two new columns called "start_datetime" and "end_datetime". Use the "make_datetime()" function to do this. Add the startYear, startMonth, startDay, startHour, startMinute to make the "start_datetime". Add the endYear, endMonth, endDay, endHour, endMinute to make the "end_datetime".
arthropods_clean <- mutate(arthropods_clean, "start_datetime" = make_datetime(year = "startYear", month = "startMonth", day = "startDay", hour = "startHour", minute = "startMinute"), "end_datetime" = make_datetime(year = "endYear", month = "endMonth", day = "endDay", hour = "endHour", minute = "endMinute"))


# Great! Now we want to parse out the columns that we just made. 

# TASK: First in order to do this, we will need to mess up the columns then put them back together. This dataset was already cleaned before it was uploaded. We We will "mess" up the data, so we can clean it again. By using "format(start_datetime, "%B %d, %Y")" and "format(start_datetime, "%I:%M:%S %p")" we are purposefully changing the clean data so we can practice more!
# (1) using the arthropods_clean data, call this new dataframe "arthropods_broken"
arthropods_broken <- arthropods_clean
# (2) use the format function on the "start_datetime" and make new columns for "start_date". "start_time", "end_date" and "end_time" and format the dates using " = format(x, "%B %d, %Y")" and for the times use " = format(x, "%I:%M:%S %p")"
arthropods_broken <- mutate(arthropods_broken, "start_date" = str_split_i("start_datetime", " ", 1), "start_time" = str_split_i("start_datetime", " ", 2)) %>%  
  mutate("end_date" = str_split_i("end_datetime", " ", 1), "end_time" = str_split_i("end_datetime", " ", 2)) %>% 
  format(arthropods_broken, "start_date" = "%B %d, %Y") %>% 
  format(arthropods_broken, "end_date" = "%B %d, %Y") %>% 
  format(arthropods_broken, "start_time" = "%I:%M:%S %p") %>% 
  format(arthropods_broken, "end_time" = "%I:%M:%S %p")

#HINT: Example of part of the code: new data name <- arthropod_clean %>% mutate(start_date = format(start_datetime, "%B %d, %Y"))...



# TASK: Now we want to parse them back together.
# (1) call this new dataframe "arthropods_parsed" but pull data from the arthropods_broken dataframe. 
arthropods_parsed <- arthropods_broken %>% 
# (2) make two new columns using the mutate function. Name these new columns "start_datetime_parsed" and "end_datetime_parsed"
  mutate(arthropods_parsed, "start_datetime_parsed" = NA, "end_datetime_parsed" = NA) %>% 
# (3) mutate the columns to parse out the data in the mdy_hms format using "mdy_hms()" 
  mutate(arthropods_parsed, "start_datetime_parsed" = mdy_hms(paste(c("start_date", "start_time")))) %>% 
  mutate(arthropods_parsed, "end_datetime_parsed" = mdy_hms(paste(c("end_date", "end_time"))))
# HINT: you will need yo use "paste()" within the mdy_hms() function. 


#TASK: Let's determine how my months each Order of insect was trapped for. Annotate each line of the code below to describe what we are telling R to do. 

total_trap_time <- arthropods %>% 
  ## Creates new dataframe from the arthropods dataframe.
  mutate(start_datetime = make_datetime(startYear, startMonth, startDay, startHour, startMinute),
         ## Makes a new column that combines other columns into a date and time.
    end_datetime   = make_datetime(endYear, endMonth, endDay, endHour, endMinute)) %>%
  ## Does the same thing as the previous line, but with different columns.
  group_by(order) %>%
  ## Basically sorts the data based on order.
  summarize(first_trap = min(start_datetime, na.rm = TRUE),
            ## Creates a new dataframe based on grouping variables.
    last_trap  = max(end_datetime, na.rm = TRUE), 
    ## Same as last line, but a different column.
    time_trapped = interval(first_trap, last_trap) %/% months(1)) %>% # HINT: "%/% months(1)" is counting whole months
  ## Finds the interval between the first and last trap by month.
  ungroup()
## Ungroups the data.

#QUESTION: How many months were the traps set for each order?
## Original file is still broken. :(

#TASK: Plot the total_trap time for each order using geom_col. Color fill the bars by order. Label each axis, use theme_bw(), and position the legend on the bottom right of the graph. 
ggplot() +
  geom_sf(data = total_trap_time, 
          aes(fill = richness),  color = "black") +
  scale_fill_viridis_c(option = "inferno", na.value = "gray90") +
  theme_bw() +
  theme(legend.position = "left") +
  labs(title = "Trap Time Intervals",
       fill = "order",
       x = "Order of Insects",
       y = "Total Trap Time")
