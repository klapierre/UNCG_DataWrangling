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
# multiple times. We can simplify this as follows (try running the code):
streamTempLength <- streamTemp %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=length))

# TASK: Using comments in the code above, describe what each line is doing.


# We might want to know some other statistics about our data, such as the max,
# min, and mean values. Try running the following code:
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







# REMINDER: If you haven't already, make sure to commit and push your code to your branch in GitHub!
