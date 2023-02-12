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


# ---------------------------------------------------------- #
#### PART 1.0: LEARNING THE FUNCTIONS                     ####
# ---------------------------------------------------------- #

# Let's go back to our dataset of water temperature in Calispell Creek and its tributaries
# from eastern Washington State.

# TASK: Read in the CalispellCreekandTributaryTemperatures.csv file and assign it to a dataframe
# named streamTemp.
# HINT: Check last week's assignment if you forget how to read data into R.


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


# QUESTION: How does this number compare to the number of observations listed by the dataframe
# in the R environment tab?


# QUESTION: Based on your previous answers, what do you think the length function does?


# It can be a bit tedious to type out all the column names and the length function
# multiple times. The across() function within the summarize() step can help us to 
# identify multiple columns to summarize the data for. Try running the following code:
streamTempLength <- streamTemp %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=length))

# TASK: Using comments in the code above, describe what each line is doing.


# We might also want to know some other statistics about our data, such as the max,
# min, and mean values. The across() function is useful for this too, by letting
# you set multiple functions to summarize each column by. Try running the following code:
streamTempSummary <- streamTemp %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=list(maximum=max, mean=mean, minimim=min)))

# TASK: Write code to view the column names of the streamTempSummary dataframe.


# QUESTION: How does R know what to name each column when we use the summarize function above?


# QUESTION: What values do you see for the columns when you open up the dataframe streamTempSummary?
# Why do you think this is?


# Recall that our data had a lot of missing values. R doesn't know how to find the mean, max,
# or min of a group of observations that include NAs.
# To fix this problem, we need to add a statement telling R to remove the NAs when calculating
# these summary stats. Run the following code:
streamTempSummary <- streamTemp %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=list(maximum=max, mean=mean, minimim=min),
                   na.rm=T))

# QUESTION: Now what values do you see for the columns when you open up the dataframe
# streamTempSummary? What line of the above code removed the NAs from our data?


# QUESTION: What happened to the column we created in the beginning called data_type?
# Where did the date and time columns go?


# RECOMMENDED: Take a look at the summarize help file, particularly the "Useful functions" section
# to see all of the different ways you can summarize your dataframe.


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


# TASK: Write code to create a new dataframe called streamTempJan that filters only
# rows where the month column is equal to 1 from the streamTempMDY dataframe.


# TASK: Write code that uses the summarize function to find the mean temperature for Calispell,
# Smalle, and Winchester streams in only January.


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


# QUESTION: In your own words, what do you think the group_by() function does when used
# before the summarize() function?


# We can also group by multiple columns. Try running the following code:
streamTempMeans <- streamTempMDY %>% 
  group_by(month, year) %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=mean,
                   na.rm=T)) %>% 
  ungroup()

# QUESTION: What columns did we group by to get our new means? What does the new dataframe show?


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


# QUESTION: Which airport should you avoid if you want the shortest delays?


# TASK: Write a pipeline to figure out which month of the year to avoid when flying to Raleigh 
# by taking the original flight dataframe (flightData) and performing the following tasks:
# (1) filter to keep only flights that have RDU as the destination (dest column);
# (2) groups the data by hour;
# (3) summarize to find the mean AND the maximum arrival delay (arr_delay column), 
#     remembering to remove NAs;
# (4) ungroup the dataframe;
# (5) assign the output to a dataframe named timeDelaySummary


# QUESTION: What is the earliest hour of the day that flights leave New York for Raleigh?


# QUESTION: Which hour of the day has the longest mean delay? What about the longest maximum delay?


# TASK: Write a pipeline to figure out which month of the year and airport to avoid when flying
# to Raleigh by taking the original flight dataframe (flightData) and performing the following tasks:
# (1) filter to keep only flights that have RDU as the destination (dest column);
# (2) groups the data by month AND origin;
# (3) summarize to find the mean arrival delay (arr_delay column), remembering to remove NAs;
# (4) ungroup the dataframe;
# (5) assign the output to a dataframe named monthlyDelaySummary


# QUESTION: Which month and airport has the longest mean delay?


# ---------------------------------------------------------- #
### PART 2.0: INTRO TO TIDY DATA                          ####
# ---------------------------------------------------------- #

# QUESTION: What are three characteristics of tidy data?


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
willow <- read_csv("Niwot_Salix_2014_WillowSeedlingSurvey.csv", skip = 10)

# QUESTION: What do you think the statement 'skip = 10' means in the code above?
# HINT: Compare the csv file on your computer and the dataframe that you loaded into R.


# ---------------------------------------------------------- #
### PART 2.1: FILL MISSING DATA                           ####
# ---------------------------------------------------------- #

# Sometimes when a data source has primarily been used for data entry, missing values indicate that the
# previous value should be carried forward.

# QUESTION: To clean up the willow dataframe, where do we want to fill in values? That is, which columns
# have lots of NAs.


# We can fix our missing value problem using the fill() function (try it by running the following code):
willowFill <- willow %>%
  fill(block:temp)

# QUESTION: What does the code 'block:temp' mean when passed to the fill() function above?


# QUESTION: Looking at the dataframe willowFill, describe what happened compared to our initial dataframe.


# ---------------------------------------------------------- #
### PART 2.2: PIVOT LONGER                                ####
# ---------------------------------------------------------- #

# Another common problem, the column headers are values instead of variable names!
# In this case, the columns w1 through wC are individual willow seedlings that were sampled repeatedly.

# TASK: Write code to indicate the sequence of columns from w1 through wC. 


# We can fix this problem using the pivot_longer() function. And while we're at it, let's get rid of the 'w' in front 
# of each willow individual number. Run the following code:
willowClean <- willowFill %>%
  pivot_longer(cols = w_1:w_C,
               names_to = "willow_id",
               values_to = "value") %>%
  separate(col = willow_id,
           into = c("remove", "willow_ID"),
           sep = "_") %>%
  select(-remove)

# TASK: Annotate (add comments) the code above to indicate what each line does.





# REMINDER: If you haven't already, make sure to commit and push your code to your branch in GitHub!
