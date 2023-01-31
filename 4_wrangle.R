# ---------------------------------------------------------- #
#### MODULE 2: Wrangle some data!                         ####               
# ---------------------------------------------------------- #

## OBJECTIVE:
# 1. To learn how to manipulate and transform data into a form usable for analysis and graphs.
# 2. To do this in a way that each step is traceable and reproducible.
# To this end we'll be familiarizing ourselves with and diving into the dplyr package.


# ---------------------------------------------------------- #
#### SET UP:                                              ####
# ---------------------------------------------------------- #
# REMINDER: Create a new branch for this week through the GitHub website
# called yourLastName_week4. Open the Rproject for our course
# (UNCG_DataWrangling),pull any changes from GitHub, and navigate to the
# branch you created for this week in RStudio's Git tab. Open this week's
# assignment in this new branch to complete and submit on GitHub.
# Ideally, you'll commit your answers a bit at a time as you work through
# this assignment, rather than committing all at once at the end.


# The dplyr package is nested within the tidyverse package (along with many others).
# Install tidyverse and load the library. HINT: see the end of assignment #1 if you 
# forgot how to install and load a package.


# ---------------------------------------------------------- #
#### PART 1.0: LEARNING THE FUNCTIONS                     ####
# ---------------------------------------------------------- #

# We will use a dataset of water temperature in Calispell Creek and its tributaries
# from eastern Washington State. These type of data are great for scripted analysis 
# because their formats remain constant but graphs frequently need to be updated to 
# reflect new data.
# In case you're interested, Calispell is the main river, while Smalle and Winchester
# are tributaries.

# TASK: Download the data from the canvas website. Remember to save it to your working
# directory for this class! I have already added it to your .gitignore file for you.


# TASK: Read in the data by running the following line of code.
streamTemp <- read.csv("CalispellCreekandTributaryTemperatures.csv", stringsAsFactors = TRUE) 


# QUESTION: What do you think stringsAsFactors mean? Why would we want to make it false?
# Try reading your data in without this extra argument included. What is the difference?


# TASK: Let's learn a little more about our data. Run the following line of code.
str(streamTemp)

# QUESTION: What does it look like the str() function does?
# How many rows does it have? How many columns? What class of data is in each column?


# ---------------------------------------------------------- #
### PART 1.1: RENAMING COLUMNS                            ####
# ---------------------------------------------------------- #

# Let's assign some more useable column names! We do this using the rename() function.
# TASK: Open the file you downloaded from Canvas on your computer (e.g., using 
# excel. Then, run the following line of code.
colnames(streamTemp)


# QUESTION: What output do you get in the console? Why is this useful?


# QUESTION: What happened to the column title Calispell Cr Temp C) when it was loaded
# into R?
# HINT: What happened to the spaces and ) in the R column names?


# TASK: Run the following line of code. Note the alignment of the code components.
streamTempRename <- rename(.data=streamTemp,
                           calispell_temp=Calispell.Cr.Temp.C.,
                           Smalle_temp=Smalle.Cr.Temp.C.,
                           Winchester_temp=Winchester.Cr.Temp..C.)


# TASK: Write your own code to find the column names of our new dataframe (streamTempRename). 


# QUESTION: What differences do you notice from before? In your own words, what did each line
# from the rename function do? Why might this function be useful for wrangling data?
# In this code, does the new column name come before or after the =?


# ---------------------------------------------------------- #
### PART 1.2: SELECTING COLUMNS                           ####
# ---------------------------------------------------------- #

# The select() function allows you to pick columns by name. This can be helpful when
# you want to clean a larger dataset and focus on your variables of interest.
# 
# Let's imagine that we are only interested in the temperature at the Calispell 
# site.

# TASK: Look again at the columns you have in the streamTempRename dataframe by
# writing the necessary code below.


# TASK: Run the following line of code to select our columns of interest.
calispellTemp <- select(.data=streamTempRename,
                        calispell_temp, Date, Time)


# QUESTION: Take a look at the column names for our new dataframe (calispellTemp),
# by coding the appropriate R function of course. What do you notice about the 
# new dataframe? Which columns are present? Which are absent? Are they in the same 
# order as before?


# A nice thing to notice about this code. We didn't have to type 'streamTemp$date'
# etc to indicate each column as we would outside of the tidyverse. The select()
# function knows we are referring to streamTemp because the dataframe is our first
# argument to the function.


# TASK: Recall that in R, the `:` operator is a compact way to create a sequence of
# numbers. For example, write the code below to generate a sequence from 1 to 3.
# HINT: Look back to assignment #1 or the swirl tutorial for help (or google!).


# Normally this notation is just for numbers, but the select() function allows you
# to specify a sequence of columns this way. This can save a bunch of typing!

#TASK: Create a new dataframe called calispellTemp2 and select the date, time, and
# calispell_temp columns using the sequence notation.
# HINT: Replace the code where each column was listed out with a sequence of column
# names. Be sure they are listed in the order they exist in the original dataframe.


# TASK: Write code to check your column names again to see what happened in your
# new dataframe.


# We can also specify the columns that we want to discard by selecting them out.
# TASK: Run the following code to remove the Smalle_temp and Winchester_temp 
# columns. Note the use of the - sign to remove columns.
calispellTemp3 <- select(.data=streamTempRename,
                         -Smalle_temp, -Winchester_temp)

# The same thing can be accomplished by running the following code, which
# concatenates these columns together.
calispellTemp4 <- select(.data=streamTempRename,
                         -c(Smalle_temp, Winchester_temp))

# And the same thing can ALSO be accomplished by running the following code, which
# subtracts out a sequence of columns.
calispellTemp5 <- select(.data=streamTempRename,
                         -Smalle_temp:-Winchester_temp)


# TASK: Write code to check that these two new dataframes (calispellTemp3,  calispellTemp4, and calispellTemp5 are identical).


