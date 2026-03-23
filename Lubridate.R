library(tidyverse)


# SET UP

bee_data <- read.csv("beneficials_unified.csv")

#SECTION 1: Date-times. 

# A date-time is a point on the timeline, stored as the number of seconds since a certain date and time.

dt_practice <- as_datetime(1) #??

# QUESTION: Run the code above. What date and time does the as_datetime function refer to? Does it include a time zone?
#ANS: Jan 1 1970, 00:00:00 UTC

# A date is a day stored as the number of days since 1970-01-01.
#TASK: Which holiday is 184 days after Jan 1 1970?

dt_holiday <- as_date(184)

# An hms is a time stored as the number of seconds since 00:00:00. The hms function converts seconds to hms. 
#TASK: How many days are 172800 seconds?

hms_practice <- hms::as_hms(172800)
print(hms_practice)

#SECTION 2: Parse Date-Times


