# ---------------------------------------------------------- #
#### Group 4's Assignment: Lubridate!                     ####               
# ---------------------------------------------------------- #

## OBJECTIVE:
# 1. 
# 2. 

# ---------------------------------------------------------- #
#### SET UP:                                              ####
# ---------------------------------------------------------- #

## KELLY'S SECTION






# ---------------------------------------------------------- #
#### Part 1.0: Parsing Time's & Dates                     ####
# ---------------------------------------------------------- #

## AMALIYA'S SECTION

# ---------------------------------------------------------- #
### 1.0 CONVERTING DATES AND TIMES ####                                           
# ---------------------------------------------------------- #

# A Unix timestamp measures the number of seconds that have passed since January 1st, 1970 at 00:00:00 UTC; this is referred to as the 'Epoch'. This is useful for computing systems because it stores all time measurements as one large number, rather than more complex formats such as month/day/year. The date-times functions in lubridate allow users to quickly convert Unix measurements to more user-friendly formats.  

dt_practice <- as_datetime(946684860)

# QUESTION: Run the code above to convert the Unix measurement to ymd_hms format using the ‘as_datetime’ function. What date and time does the timestamp correspond to?
# ANSWER: "2000-01-01 00:01:00 UTC"

# Unix timestamps are also measured in days since January 1st, 1970. The ‘as_date’ function can be used to convert these measurements to ymd format.
# QUESTION: What holiday does the 20392 Unix days timestamp correspond to? What year? HINT: Use the ‘as_date’ function to convert days to ymd format. 

dt_holiday <- as_date(20392)
# ANSWER: Halloween 2025. 

# Unix timestamps can also measure seconds passed since 00:00:00 (with no corresponding date or time zone). The ‘as_hms' function can be used to convert these measurements to hms format. 
# TASK: Run the following code to convert 10,000 seconds to hours. 

print(dt_time <- hms::as_hms(10000))

#QUESTION: How many hours are 86,400 seconds? HINT: Use the ‘as_hms’ function to convert seconds to hms format.

print(dt_time_86 <- hms::as_hms(86400))
# ANSWER: 24 hours.

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

mdy("07-04-12") #ANSWER: The output from 'ydm' is incorrect because the input is in mdy format. It can be corrected by using 'mdy' instead. 

#TASK: Use any of the parsing functions to convert your birthday into standard Unix format in the space below. 

mdy("November 22nd, 2001") #Example

# Parsing data is super convenient, but what if we want to parse an entire column at once?
#TASK: Load the nycflights13 dataset. This dataset already uses Unix format; run the following code to "break" the dataset so we can practice parsing date-times.

install.packages("nycflights13")
library(nycflights13)

broken_flights <- flights %>%
  mutate(
    flight_date = format(time_hour, "%B %d, %Y"), 
    flight_time = format(time_hour, "%I: %M: %S %p")) %>% 
  select(flight, tailnum, origin, dest, flight_date, flight_time)

#TASK: Run the following code to convert flight times back to Unix format in the flight_data_parsed dataframe.

flight_data_parsed <- broken_flights %>% mutate(flight_time = hms::as_hms(flight_time))

#TASK: In the same flight_data_parsed dataframe, parse the flight_date column. 
#HINT: Use the mutate function with the appropriate parsing function form the previous section.

flight_data_parsed <- broken_flights %>% mutate(flight_date = mdy(flight_date)) #Example

# ----------------------------------------------- #
### 1.2 GETTING AND SETTING DATES AND TIMES ####                        
# ----------------------------------------------- #

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

#ANSWER: week of the year and day of the week

#TASK: What if we wanted to create new column in our flights dataset listing the day of the week of the flight? Run the following code to create a flight_day column in our flight_data_parsed dataset.

flight_data_parsed <- flight_data_parsed %>% mutate(flight_day = wday(flight_date, label = TRUE, abbr = FALSE))

#QUESTION: What do 'label' and 'abbr' mean in the code above?
# HINT: Try running the code without the 'label' and 'abbr' arguments.
#ANSWER: Label = displaying the day of the week as a name (not number). Abbr = abbreviation.

#TASK: Create a new column called 'flight_month' in the flight_data_parsed dataset that lists the names of the months that the flights took place. 

flight_data_parsed <- flight_data_parsed %>% mutate(flight_month = month(flight_date, label = TRUE, abbr = FALSE)) #Answer

# ---------------------------------------------------------- #
### 1.3 ROUNDING DATES AND TIMES ####                                  
# ---------------------------------------------------------- #

# There might be times where you want to round your data. For example, what if you wanted to round to the nearest month? 

# TASK: The functions 'floor_date' and 'ceiling_date' will round down and up to the nearest unit, respectively. Run the following lines of code and take note of the output values.

floor_date(mdy("April 15 2026"), "month")
ceiling_date(mdy("April 15 2026"), "month")

# QUESTION: The 'round_date' function is a general rounding function. Run the following line of code. Does 'round_date' round up or down?
# HINT: April has 30 days. 
# ANSWER: 'round_date' rounds up by default. 

round_date(mdy("April 15 2026"), "month")

# QUESTION: Run the following line of code. What do you think the 'rollback' function does? What do you think the 'roll_to_first' and  'preserve_hms' arguments do?
# HINT: Try running the code with different 'roll_to_first' and  'preserve_hms' arguments.
# ANSWER: It rounds back to the last day of the previous month ('roll_to_first' = FALSE) or the first day of the current month ('roll_to_first' = TRUE).'preserve_hms' tells R whether or not to save the timestamp of the date-time value. 

rollback(todays_timestamp, roll_to_first = FALSE, preserve_hms = TRUE)

# TASK: Create a dataframe named 'flight_data_rounded' from our 'flight_data_parsed' dataframe that includes a column named 'rounded_flight_date' that rounds the flight date to the nearest month. 

flight_data_rounded <- flight_data_parsed %>% 
  mutate(rounded_flight_date = round_date(ymd(flight_date), "month")) # ANSWER

# ---------------------------------------------------------- #
#### Part 1.1: Duration & Intervals                       ####
# ---------------------------------------------------------- #

## CAROLINE'S SECTION






# ---------------------------------------------------------- #
#### Part 1.2: Date Arithmetic                            ####
# ---------------------------------------------------------- #

## MICHELLE'S SECTION






# ---------------------------------------------------------- #
#### Part 1.3: Time Zones                                 ####
# ---------------------------------------------------------- #

## MARK'S SECTION

## Knowledge of time zones is important as the same clock time can have different meanings globally.
## Lubridate provides tools for checking, assigning, and converting time zones.
## In this section, we'll practice
## 1) Using tz() to check a time zone ## 2) Converting a time with with_tz() ## 3) Assigning a zone with force_tz() ## 4) Extracting date time elements  
## 5: Using Time Zones in NYC Flights13 dataset

library(lubridate)
library(dplyr)
library(nycflights13)

## First, we'll produce a date time object in UTC.
## UTC is a standard world time that is widely used in datasets and computers.

time_utc <- ymd_hms("2026-04-14 18:00:00", tz = "UTC")
time_utc

## QUESTION: What does the 'tz' argument produce?

## TASK: Determine the time zone of 
tz(time_utc)

## The with_tz() function shows the exact same moment in a different timezone.
time_ny <- with_tz(time_utc, tzone = "America/New_York")
time_ny

## QUESTION: Has the actual moment in time changed?

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
time_utc
time_ny
time_la
time_chicago
time_tokyo

##QUESTION: Why do the shown clock times appear different?

##QUESTION: Are these different moments?

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

##TASK: Determine the time zone for both items.
tz(time_with_tz)
tz(time_force_tz)

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

## QUESTION: How is this useful?
# ---------------------------------------------------------- #
#### Part 2.0: Practing your skills                       ####
# ---------------------------------------------------------- #

## KELLY'S SECTION





