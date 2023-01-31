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
rawData <- read.csv("CalispellCreekandTributaryTemperatures.csv", stringsAsFactors = TRUE) 


# QUESTION: What do you think stringsAsFactors mean? Why would we want to make it false?
# Try reading your data in without this extra argument included. What is the difference?


# TASK: Let's learn a little more about our data. Run the following line of code.
str(rawData)

# QUESTION: What does it look like the str() function does?
# How many rows does it have? How many columns? What class of data is in each column?


# ---------------------------------------------------------- #
### PART 1.1: RENAMING COLUMNS                            ####
# ---------------------------------------------------------- #

# Let's assign some more useable column names! We do this using the rename() function.
# TASK: Open the file you downloaded from Canvas on your computer (e.g., using 
# excel. Then, run the following line of code.
colnames(rawData)

# QUESTION: What output do you get in the console? Why is this useful?

# QUESTION: What happened to the column title Calispell Cr Temp C) when it was loaded
# into R?
# HINT: What happened to the spaces and ) in the R column names?

# TASK: Run the following line of code.
rawDataRename <- rename(.data=rawData,
                        calispell_temp=Calispell.Cr.Temp.C.,
                        Smalle_temp=Smalle.Cr.Temp.C.,
                        Winchester_temp=Winchester.Cr.Temp..C.)

# TASK: Write your own code to find the column names of our new dataframe (rawDataRename). 
colnames(rawDataRename)

# QUESTION: What differences do you notice from before? In your own words, what did each line
# from the rename function do? Why might this function be useful for wrangling data?
