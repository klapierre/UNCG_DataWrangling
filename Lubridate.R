library(tidyverse)
library(lubridate)

# ---------------------------------------------------------- #
### CONVERTING DATES AND TIMES ####                                           
# ---------------------------------------------------------- #

# A Unix, or Epoch, timestamp measures the number of seconds that have passed since January 1st, 1970 at 00:00:00 UTC. The Unix system is useful for computing systems because it stores all time measurements as one large number, rather than more complex formats such as month/day/year. The date-times functions in lubridate allow users to quickly convert Unix measurements to more user-friendly formats.  

dt_practice <- as_datetime(946684800)

# QUESTION: Run the code above to convert the Unix measurement to ymd_hms format using the ‘as_datetime’ function. What date does the timestamp correspond to?
# ANSWER: "2000-01-01 UTC"

# Unix timestamps are also measured in days since January 1st, 1970. The ‘as_date’ function, like the ‘as_datetime’ function, can be used to convert these measurements to ymd format.

# QUESTION: What holiday does the 20392 Unix days timestamp correspond to? What year? HINT: Use the ‘as_date’ function to convert days to ymd format. 

dt_holiday <- as_date(20392)
# ANSWER: Halloween 2025. 

# Unix timestamps can also measure seconds passed since 00:00:00 (with no corresponding date or time zone). The ‘as_hms' function can be used to convert these measurements to hms format. 

# TASK: Run the following code to convert 10,000 seconds to hours. 

print(dt_time <- hms::as_hms(10000))

# QUESTION: How many hours are 86,400 seconds? HINT: Use the ‘as_hms’ function to convert seconds to hms format.

print(dt_time_86 <- hms::as_hms(86400))
# ANSWER: 24 hours.

# ---------------------------------------------------------- #
### PARSING DATES AND TIMES ####                                           
# ---------------------------------------------------------- #

# Parsing is the process of converting strings or numbers to into standard date-time format (ymd_hms). This can be done one value at a time, or for an entire column. 

# You can parse date-times with several different functions, so it's important to use the function that corresponds to the order of your data!

# TASK: Run the following lines of codes to view several functions for parsing date and time.

ymd_hms("2026-04-14 14:00:00")
ydm_hms("2026-14-04 14:00:00")
mdy_hms("04/14/2026 14:00:00")
dmy_hms("14 Apr 2026 14:00:00")

# TIP: If your data doesn’t include certain values, you can use the same functions by removing the corresponding parts of the function. 

#TASK: Run the following lines of code to convert these dates that lack time values.

ymd("20260414")
ydm("2026-14-04")
mdy("April 14th, 2026")
dmy("14th of April '26")

#TASK: Run the following line of code to convert "07-04-12" (July 4th, 2012) to standard date-time format. 

ydm("07-04-12")

# QUESTION: Is the output value correct? Why not? Rewrite the code with the same input using the correct function below. 

mdy("07-04-12") #Answer

#TASK: Use a parsing function to convert your birthday into standard date-time format in the space below. 

mdy("November 22nd, 2001") #Example

