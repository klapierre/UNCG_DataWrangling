# ---------------------------------------------------------- #
#### MODULE 2: Transform some data!                         ####               
# ---------------------------------------------------------- #

## OBJECTIVE:
# 1. To learn how to manipulate and transform data into a form usable for analysis and graphs.
# 2. To do this in a way that each step is traceable and reproducible.
# To this end we'll continue to familiarize ourselves with the dplyr package and dive into the tidyr package.


# ---------------------------------------------------------- #
#### SET UP:                                              ####
# ---------------------------------------------------------- #
# REMINDER: In RStudio, open the Rproject for our course (UNCG_DataWrangling), 
# pull any changes from GitHub, and navigate to the branch you created for 
# yourself (just a single branch for the whole semester) in RStudio's Git tab.
# Open this week's assignment in this new branch to complete and submit on GitHub.
# Ideally, you'll commit your answers a bit at a time as you work through
# this assignment, rather than committing all at once at the end.


# REMINDER: The dplyr and tidyr packages are nested within the tidyverse package
# (along with many others). Be sure to start by loading the tidyverse library.
# HINT: see the end of assignment #1 if you forgot how to load a package.
install.packages('dplyr')
library(dplyr)
install.packages("tidyr")
library(tidyr)
# ---------------------------------------------------------- #
#### PART 1.0: LEARNING THE FUNCTIONS                     ####
# ---------------------------------------------------------- #

# Let's go back to our dataset of water temperature in Calispell Creek and its tributaries
# from eastern Washington State.

# TASK: Read in the CalispellCreekandTributaryTemperatures.csv file and assign it to a dataframe
# named streamTemp.
# HINT: Check last week's assignment if you forget how to read data into R.
streamTemp <- read.csv('CalispellCreekandTributaryTemperatures.csv',stringsAsFactors =F) %>%
  rename(calispell=Calispell.Cr.Temp.C.,
         smalle=Smalle.Cr.Temp.C.,
         winchester=Winchester.Cr.Temp..C.) %>%
  mutate(data_type='temp_C')

# ---------------------------------------------------------- #
### PART 1.1: SUMMARIZING DATA                            ####
# ---------------------------------------------------------- #

# We can use the summarize() function to get a lot of quick stats on our data!
# Let's try out the length function by running the following code:
streamTempLength <- streamTemp %>% 
  summarize(calispell_length = length(calispell),
            smalle_length = length(smalle),
            winchester_length = length(winchester))

# QUESTION: When you open the streamTempLength dataframe, what value is in each column?
streamTempLength
#In each column there is a value of 61100.
# QUESTION: How does this number compare to the number of observations listed by the dataframe
# in the R environment tab?
#For the environment tab, it says there is only 1 observation compared to 
#61100 observations.

# QUESTION: Based on your previous answers, what do you think the length function does?
#I think the length function will tell me 3 because there are 3 values.
length(streamTempLength)
# It can be a bit tedious to type out all the column names and the length function
# multiple times. The across() function within the summarize() step can help us to 
# identify multiple columns to summarize the data for. Try running the following code:
streamTempLength <- streamTemp %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=length))

# TASK: Using comments in the code above, describe what each line is doing.
streamTempLength
streamTemp
#The summarize is combining the columns and the cols=c are labeling the columns
#calispell, smalle, and winchester

# We might also want to know some other statistics about our data, such as the max,
# min, and mean values. The across() function is useful for this too, by letting
# you set multiple functions to summarize each column by. Try running the following code:
streamTempSummary <- streamTemp %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=list(maximum=max, mean=mean, minimim=min)))

# TASK: Write code to view the column names of the streamTempSummary dataframe.
colnames(streamTempSummary)
# QUESTION: How does R know what to name each column when we use the summarize function above?
#By using the summarize function allows the columns to combine into one vector rather than being spaced out.

# QUESTION: What values do you see for the columns when you open up the dataframe streamTempSummary?
# Why do you think this is?
streamTempSummary
#All the column values are NA because we named the columns but did not assign any values for them.
# Recall that our data had a lot of missing values. R doesn't know how to find the mean, max,
# or min of a group of observations that include NAs.
# To fix this problem, we need to add a statement telling R to remove the NAs when calculating
# these summary stats. Run the following code:
streamTempSummary <- streamTemp %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=list(maximum=max, mean=mean, minimim=min),
                   na.rm=T))
library(tidyverse)
?summarize
# QUESTION: Now what values do you see for the columns when you open up the dataframe
#I see a max, mean, and min for each river.
# streamTempSummary? What line of the above code removed the NAs from our data?
streamTempSummary
#The names of the columns have and max, min, and mean following them.
#The line that removed the nas is na.rm=T
# QUESTION: What happened to the column we created in the beginning called data_type?
# Where did the date and time columns go?
streamTemp
#The column called data_type are not there in the dataframe streamTempSummary.
#The date and time columns were not in the summary file.
# RECOMMENDED: Take a look at the summarize help file, particularly the "Useful functions" section
# to see all of the different ways you can summarize your dataframe.
?summarize

# ---------------------------------------------------------- #
### PART 1.2: GROUPING DATA                               ####
# ---------------------------------------------------------- #

# Summarizing data is great, but it can be more useful to get summaries for particular 
# subsets of the data.

# TASK: Write code to do the following:
# (1) Separate the date column into columns named month, day, and year;
# (2) Mutate the year column to paste '20' to the front of each year value;
# (3) Call your new dataframe streamTempMDY.
# HINT: Check the help documentation for the separate(), mutate(), and paste() functions.
streamTempMDY <- streamTemp %>%
  separate(col = Date, into = c('month', 'day', 'year'), sep = '/')
streamTempMDY <- streamTempMDY %>%
  mutate(year = paste0("20", year))
                          
# TASK: Write code to create a new dataframe called streamTempJan that filters only
# rows where the month column is equal to 1 from the streamTempMDY dataframe.
streamTempJan <- streamTempMDY %>%
  filter(month == 1)

# TASK: Write code that uses the summarize function to find the mean temperature for Calispell,
# Smalle, and Winchester streams in only January.
streamTempJanMean <- streamTempJan %>%
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=(mean=mean), na.rm=T))

# Now imagine you had to repeat this set of steps (creating new filtered dataframes) for all 12 months!
# That would not only be tedious, but would also clutter up our R environment.
# Instead, we can use the handy group_by() function before the summarize() function to tell
# R that we want to get the summary stats for each of the groups we specify.
# Try running the following code:
streamTempMonthlyMean <- streamTempMDY %>% 
  group_by(month) %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=mean,
                   na.rm=T)) %>% 
  ungroup()

# NOTE: Whenever you group a dataframe, you should always ungroup after performing your function.
# Otherwise, R will consider that dataframe to be grouped forever, which can mess up future functions.


# QUESTION: When you look at the streamTempMonthlyMean dataframe, how many means do you see for 
# each stream?
streamTempMonthlyMean
#I see 9 means for each stream total
# QUESTION: In your own words, what do you think the group_by() function does when used
# before the summarize() function?
#The group_by() function sorts the dataframes based on different columns and summarizes it.

# We can also group by multiple columns. Try running the following code:
streamTempMeans <- streamTempMDY %>% 
  group_by(month, year) %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=mean,
                   na.rm=T)) %>% 
  ungroup()

# QUESTION: What columns did we group by to get our new means? What does the new dataframe show?
streamTempMeans
#We grouped the columns by the month. There are values that say NaN.

# ---------------------------------------------------------- #
### PART 1.3: PRACTICING THESE SKILLS                     ####
# ---------------------------------------------------------- #

# Let's return to our flight delays question from last week. Recall that we are interested 
# in avoiding flights with long delays. Load the data for New York City flights by running 
# the following code:
flightData <- nycflights13::flights

# TASK: Write a pipeline to figure out which airport of origin to avoid when flying to Raleigh 
# by taking the original flight dataframe (flightData) and performing the following tasks:
# (1) filter to keep only flights that have RDU as the destination (dest column);
# (2) groups the data by airport of origin (origin column);
# (3) summarize to find the mean arrival delay (arr_delay column) remembering to remove NAs;
# (4) ungroup the dataframe;
# (5) assign the output to a dataframe named airportDelaySummary.
airportDelaySummary <- flightData %>%
  filter(dest == "RDU") %>%
  group_by(origin) %>%
  summarize(meanArrivalDelay = mean(arr_delay, na.rm = TRUE)) %>%
  ungroup()
minDelayAirport <- airportDelaySummary[which.min(airportDelaySummary$meanArrivalDelay), "origin"]
print(paste("Avoid flying from", 'minDelayAirport', "to get the shortest delays"))

# QUESTION: Which airport should you avoid if you want the shortest delays?
airportDelaySummary
#Avoid LGA because it has the smallest value.
# TASK: Write a pipeline to figure out which month of the year to avoid when flying to Raleigh 
# by taking the original flight dataframe (flightData) and performing the following tasks:
# (1) filter to keep only flights that have RDU as the destination (dest column);
# (2) groups the data by hour;
# (3) summarize to find the mean AND the maximum arrival delay (arr_delay column), 
#     remembering to remove NAs;
# (4) ungroup the dataframe;
# (5) assign the output to a dataframe named timeDelaySummary
flightData <- nycflights13::flights

timeDelaySummary <- flightData %>%
  filter(dest == "RDU") %>%
  group_by(hour) %>%
  summarize(mean_arr_delay = mean(arr_delay, na.rm = TRUE),
            max_arr_delay = max(arr_delay, na.rm = TRUE)) %>%
  ungroup()
head(arrange(timeDelaySummary, hour), 1)
# QUESTION: What is the earliest hour of the day that flights leave New York for Raleigh?
flightData %>%
  filter(dest == "RDU") %>%
  summarize(earliest_dep_time = min(dep_time, na.rm = TRUE))
#2
# QUESTION: Which hour of the day has the longest mean delay? What about the longest maximum delay?
flightData <- nycflights13::flights
RDU_flights <- flightData %>%
  filter(dest == "RDU")
longest_delay <- max(RDU_flights$dep_delay, na.rm=TRUE)
longest_delay
#The hour of the day that has the longest mean delay is 4:20
# TASK: Write a pipeline to figure out which month of the year and airport to avoid when flying
# to Raleigh by taking the original flight dataframe (flightData) and performing the following tasks:
# (1) filter to keep only flights that have RDU as the destination (dest column);
# (2) groups the data by month AND origin;
# (3) summarize to find the mean arrival delay (arr_delay column), remembering to remove NAs;
# (4) ungroup the dataframe;
# (5) assign the output to a dataframe named monthlyDelaySummary

flightData <- nycflights13::flights
monthlyDelaySummary <- flightData %>%
  filter(dest == "RDU") %>%
  group_by(month, origin) %>%
  summarize(mean_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(mean_arr_delay)

bad_month_airport <- monthlyDelaySummary %>%
  filter(mean_arr_delay == max(mean_arr_delay)) %>%
  select(month, origin)
bad_month_airport
# QUESTION: Which month and airport has the longest mean delay?
#After the running the pipeline, EWR has the longeset mean delay.

# ---------------------------------------------------------- #
### PART 2.0: INTRO TO TIDY DATA                          ####
# ---------------------------------------------------------- #

# QUESTION: What are three characteristics of tidy data?
#In tidy data, each variable is a column, each observation is a row, and each type of observational unit is a table.

# There are five common problems associated with messy data:
# 1. Column headers are values, not variable names
# 2. Multiple variables are stored in one column
# 3. Variables are stored in both rows and columns
# 4. Multiple types of observational units are stored in the same table
# 5. A single observational unit is stored in multiple tables

# Here we will build a workflow to demonstrate how we can tidy up a dataset.
# Let's start by clearing our R environmnet and then bringing the Willow Seedling Survey data into R 
# by running the following line of code:
rm(list = ls())
willow <- read.csv('Niwot_Salix_2014_WillowSeedlingSurvey (1).csv', skip = 10)

# QUESTION: What do you think the statement 'skip = 10' means in the code above?
# HINT: Compare the csv file on your computer and the dataframe that you loaded into R.
#The statement 'skip = 10' means to skip the first 10 lines in the dataframe.

# ---------------------------------------------------------- #
### PART 2.1: FILL MISSING DATA                           ####
# ---------------------------------------------------------- #

# Sometimes when a data source has primarily been used for data entry, missing values indicate that the
# previous value should be carried forward.

# QUESTION: To clean up the willow dataframe, where do we want to fill in values? That is, which columns have lots of NAs.
willow
#The block column has a lot of NAs
# We can fix our missing value problem using the fill() function (try it by running the following code):
willowFill <- willow %>%
  fill(block:temp)

# QUESTION: What does the code 'block:temp' mean when passed to the fill() function above?
#'block:temp' function with the function fill() fills in the missing values from the end of block to the start of the temp columns.
willowFill
# QUESTION: Looking at the dataframe willowFill, describe what happened compared to our initial dataframe.
#The new dataframe willowFill is a bit more organized compared to the original. It is easier to read.

# ---------------------------------------------------------- #
### PART 2.2: PIVOT LONGER                                ####
# ---------------------------------------------------------- #

# Another common problem, the column headers are values instead of variable names!
# In this case, the columns w1 through wC are individual willow seedlings that were sampled repeatedly.

# TASK: Write code to indicate the sequence of columns from w1 through wC. 


# We can fix this problem using the pivot_longer() function. pivot_longer() takes multiple columns
# and condenses them into just two columns, one that indicates what column the data came from and the other
# that contains the data itself.
# And while we're at it, let's get rid of the 'w' in front of each willow individual number.
# Run the following code:
willowClean <- willowFill %>%
  pivot_longer(cols = w_1:w_C,
               names_to = "willow_id",
               values_to = "value") %>%
  separate(col = willow_id,
           into = c("remove", "willow_ID"),
           sep = "_") %>%
  select(-remove)


# TASK: Annotate (add comments) the code above to indicate what each line does.


# ---------------------------------------------------------- #
### PART 2.3: PIVOT WIDER                                 ####
# ---------------------------------------------------------- #

# Yikes, another common problem, the variables are stored in both rows and columns!

# QUESTION: What column contains the labels that tell us there are multiple variables stored
# in one column? What column contains the corresponding date for these variables?


# Good news, we can fix this problem with the complementary function to pivot_longer().
# This time we will use the pivot_wider() function to turn one column into multiple.
willowCleaner  <- willowClean %>%
  pivot_wider(names_from = variable,
              values_from = value)


# TASK: Take a look at our new dataframe. How does it differ from the previous?
# Annotate (add comments) the code above to indicate what each line does.


# ---------------------------------------------------------- #
### PART 2.4: IF ELSE                                     ####
# ---------------------------------------------------------- #

# Sigh, another major issue: multiple variables are stored in one column again!
# This occurs in the ht1 (height 1) column, where there is information about the plant status
# (whether it is dead or alive) AND the height for only the individuals that were alive.
# And then it is a problem again in the willow_ID column, which tells us information about when each 
# seedling was planted.

# TASK: Verbally describe how you would want to change this problem (i.e., pseudocode).


# ifelse() is a very powerful function that helps us with this problem!

# TASK: Look at the ifelse help file and describe in your own words the ordering of the syntax.
# logical statement, if the statement is TRUE then use the yes value provides, otherwise use the no value.

# We can nest the ifelse() function within a mutate() function to create a new column that contains
# one entry if the logical statement we provide is TRUE and another if the logical statement is FALSE.
# Run the following code to try it out to help fix our first problem (ht1 column has information on 
# both plant status and actual height values).
willowClean3 <- willowClean2 %>%
  mutate(status = ifelse(ht1 == 'dead', 'dead', 'alive')) %>% 
  mutate(ht1 = ifelse(status == 'dead', NA, ht1))

# TASK: Annotate the previous lines of code to indicate what each is doing.


# QUESTION: This is a good time to make sure the relevant columns are numeric. Run the str() function
# on this dataframe. What class is the ht1 column?


# Let's make the ht1 column numeric. And while we're at it, the columns ht2, cnpy1, and cnpy2 should also
# be made numeric. We can do so by running the following code:
willowClean4 <- willowClean3 %>% 
  mutate(ht1 = as.numeric(ht1),
         ht2 = as.numeric(ht2),
         cnpy1 = as.numeric(cnpy1),
         cnpy2 = as.numeric(cnpy1))

# TASK: Run the str() function again to view the classes for each column in willowClean4. Did we
# succeed in making the columns we wanted into numeric classes?


# %in% is another powerful function! With %in% we can use logical statements on a whole bunch of stuff at
# once, instead of making a billion ifelse statements. Let's try it out to fix our second problem,
# where willow_ID also contains info about when the seedling was planted. Run the following lines of code:
willowClean5 <- willowClean4 %>% 
  mutate(year = ifelse(willow_ID %in% c("A", "B", "C"), 2006, 2007))

# QUESTION: Based on the lines of code above, what can you conclude about willow seedlings with identifiers
# that were letters versus numbers? That is, what year were willow seedlings that were identified with letters
# planted? What year were willow seedlings that were identified with numbers planted?


# ---------------------------------------------------------- #
### PART 2.5: RELATIONAL DATA                             ####
# ---------------------------------------------------------- #]
# Final problem! Multiple types of observational units are stored in the same table. We have information
# about each plot's treatments AND information about willow growth in a single table.
# We'll fix this by making a relational database. To do so, we'll need to make two separate dataframes.
# We can call one plotInfo and the other willowData.

# QUESTION: What columns would go in each of our two relational databases?

# Let's do it! Run the following code:
plotInfo <- willowClean5 %>%
  select(block:temp) %>%
  unique()

willowData <- willowClean5 %>%
  select(block, plot, willow_ID:year)

# It might seem trivial to have this be a relational database, but it's super useful for larger
# and more complicated datasets.

# TASK: Write code to join these two dataframes back together into a new dataframe called willowDataTrt
# using the left_join() function.


# ON YOUR OWN: There are so many ways to join databases! Think through when you might want to use each type.
# We will practice more with joining data in the coming weeks.


# ---------------------------------------------------------- #
### PART 2.6: PRACTICING YOUR SKILLS                      ####
# ---------------------------------------------------------- #

# Let's go back to the data of leaf carbon and nitrogen percentages from a nitrogen addition experiment
# in a grassland in Minnesota.

# TASK: Perform the following steps in one workflow (i.e., using pipes):
# (1) Create a dataframe called cdr and load the .csv file 
# 'e001_Plant aboveground biomass carbon and nitrogen.csv' into it.
# (2) Rename our last two columns that were originally '% Carbon' and '% Nitrogen' in
# our csv file. Make the new names 'C' and 'N', respectively.
# (3) Remove any observations that were not obtained from Strips 1 or 2 using an %in% statement.
# (4) pivot_longer the C and N data so that there is one column called element that contains C or N
#     and another column called percentage that contains the values of either %C or %N.
# (5) group_by() Date, Plot, NTrt, Species, Field, and Strip and then use the summarize() function
#     to calculate the mean value of the percentage column for each group. Store the mean values
#     in a column called 'percentage_mean'. Don't forget to ungroup at the end!
# (6) pivot_wider so that the values of percentage_mean are contained in different columns


# ---------------------------------------------------------- #
### PART 3.0: SUBMIT YOUR WORK                            ####
# ---------------------------------------------------------- #

# REMINDER: If you haven't already, make sure to commit and push your code to your branch in GitHub!
