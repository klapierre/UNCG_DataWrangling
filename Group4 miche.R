## Arithmic with lubridate ####
## set up ##
## TASK: Load in the packages dplyr and lubridate
install.packages("dplyr")
install.packages("lubridate")
library(dplyr)
library(lubridate)
## Next, lets load in our data set and do some clean up ##
## TASK: load in beneficials_unified.csv and rename it data_set
data_set <-read.csv("beneficials_unified.csv")
## Now we will clean the data set to only contain data with time 
clean_time_data <- data_set %>% ## keep in assignmet 
  select(-(1:26), -(38:43)) ## keep in assignment 
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
# it helps break down the data into usable pieces that we can manipulate
# adds new columns and breaks them down in the data set to make it easier to use 

# Okay, now that we have cleaned up our data we are ready for the math!
## lubridate can help you calculate time in the past and present--

# lets add 6 days to our start_datetime column in clean_time_data2
clean_time_data2 <- clean_time_data2 %>%
  mutate(start_plus_7 = start_datetime + days(7))
## Task- check the data set which column changed ? 
start_day 
##  question why would this be helpful ? 
#  it can help us predict future dates and can help us compare a time window 
## TASK: Subtract month from clean_time_data2 
clean_time_data2 <- clean_time_data2 %>%
  mutate(start_minus_1month = start_datetime - months(1))
## TASK: View the dataset clean_time_data2- what do you see?
# 2 new columns with infromation
## why is this useful ?
# in order to see the change in the values and compare them to the orginal one
## lets us check the difference between the end and start 
clean_time_data2 <- clean_time_data %>%
       mutate(
       duration_calc = end_datetime - start_datetime
         )
## what is the differnece in column one #hint look at the end last column in the
# dataset 

## okay lets work with real time, time first we are gonna look at the todays date
today_date <- today ()
## now create a new dataset called my_birthday and include your own birthday. 
## if your birthday as already passed use another date- 
## hint ymd 
my_birthday <- ymd("2002-09-05")
# now we will create data set called my birthday this year 
my_birthday_this_year <- ymd(paste0(year(today_date), "-09-05"))
## create a dataset called birthday_time and subtract my_birthday_this_year and 
## today_data
birthday_time <- my_birthday_this_year - today_date
## TASK: View this dataset you just create ? what does this value mean?
View(birthday_time)
## Okay now lets figure out what day it is gonna be 60 days from now
# TASK - Add 30 days to today_date and rename the dataset to days_30
days_30 <- today_date + days(30)
# question: what is the day 30 days from now? 
## 2026-05-06
## Task: create another data set with today_date but subtract 30 days and rename
# to days_minus_30
days_minus_30 <- today_date - days(30)
## what is the date ?
#2026-03-07 
## question: How is lubridate and arithmetic useful? 
#Track time-based events 
#Clean messy date data
#Analyze trends over time







































































