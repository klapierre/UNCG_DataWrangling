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
## After reading it in without the argument it's clear that it translates strings/groups
## of values into functional dates/times.


# TASK: Let's learn a little more about our data. Run the following line of code.
str(streamTemp)

# QUESTION: What does it look like the str() function does?
# How many rows does it have? How many columns? What class of data is in each column?
## str() provides basic information on the dataset, such as columns, # of obs, 
## and a subset of the first 10 values for each col.


# ---------------------------------------------------------- #
### PART 1.1: RENAMING COLUMNS                            ####
# ---------------------------------------------------------- #

# Let's assign some more useable column names! We do this using the rename() function.
# TASK: Open the file you downloaded from Canvas on your computer (e.g., using 
# excel. Then, run the following line of code.
colnames(streamTemp)


# QUESTION: What output do you get in the console? Why is this useful?
## You get all of the column names, so that you can correctly refer to them later
## on if need be.

# QUESTION: What happened to the column title Calispell Cr Temp C) when it was loaded
# into R?
# HINT: What happened to the spaces and ) in the R column names?
## They were automatically converted into periods.

# TASK: Run the following line of code. Note the alignment of the code components.
streamTempRename <- rename(.data=streamTemp,
                           calispell_temp=Calispell.Cr.Temp.C.,
                           Smalle_temp=Smalle.Cr.Temp.C.,
                           Winchester_temp=Winchester.Cr.Temp..C.)


# TASK: Write your own code to find the column names of our new dataframe (streamTempRename). 
colnames(streamTempRename)

# QUESTION: What differences do you notice from before? In your own words, what did each line
# from the rename function do? Why might this function be useful for wrangling data?
# In this code, does the new column name come before or after the =?
## Each line changed the base column name to the new name present before the "=",
## which is convenient if you have long colnames and need to shorten them or make
## them easier to refer to/make more sense.

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

## Only the values temp, date and time are present, and they are in a different 
## order than they were originally.


# A nice thing to notice about this code. We didn't have to type 'streamTemp$date'
# etc to indicate each column as we would outside of the tidyverse. The select()
# function knows we are referring to streamTemp because the dataframe is our first
# argument to the function.


# TASK: Recall that in R, the `:` operator is a compact way to create a sequence of
# numbers. For example, write the code below to generate a sequence from 1 to 3.
# HINT: Look back to assignment #1 or the swirl tutorial for help (or google!).
sequence<-c(1:3)


# Normally this notation is just for numbers, but the select() function allows you
# to specify a sequence of columns this way. This can save a bunch of typing!

#TASK: Create a new dataframe called calispellTemp2 and select the date, time, and
# calispell_temp columns using the sequence notation.
# HINT: Replace the code where each column was listed out with a sequence of column
# names. Be sure they are listed in the order they exist in the original dataframe.
calispellTemp2<-select(.data=calispellTemp,1:3)



# TASK: Write code to check your column names again to see what happened in your
# new dataframe.
colnames(calispellTemp2)

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


# TASK: Write code to check that these three new dataframes (calispellTemp3,  calispellTemp4, and calispellTemp5 are identical).
isTRUE(identical(calispellTemp3,calispellTemp4)==identical(calispellTemp4,calispellTemp5))

## I know there is a better way to do this but I'm tired and can't remember.

# ---------------------------------------------------------- #
### PART 1.3: FILTERING ROWS                              ####
# ---------------------------------------------------------- #

# Now that we've gone over how to select a subset of columns using THE select()
# function, a natural next question is “How do I select a subset of rows?” 
# That’s where the filter() function comes in! Isn't this fun!?

# Note that filter() is really, by definition, subsetting our data. But, base R
# has a subset() function already. So in the tidyverse world, we refer to this as
# filtering instead.

# We might be worried about high water temperatures. Let's filter the the Calispell
# dataframe to only include data where the Calispell Creek has temperature equal or
# greater than 15 C.

# QUESTION: If you remove all of the observations (rows) with temperatures lower
# than 15C, would you expect your new dataframe to have more, the same, or fewer
# observations than the original dataframe?
## Fewer observations.

# TASK: Run the following code to only keep the values greater than or equal to 15C.
calispellHighTemp <- filter(.data=calispellTemp,
                            calispell_temp >= 15)

# How do you know if it worked??
# TASK: Check the number of observations in your dataframe! You can either do 
# this using the str() function or by looking next to the dataframe name in the
# R environment tab.
## calispellHighTemp has only 7703 observations, while calispellTemp has 61100.
## That seems filtered to me.

# QUESTION: How many observations did the original dataframe (calispellTemp) have?
# How many does the new dataframe (calispellHighTemp) have?
## See above.

# REALLY IMPORTANT: Even if the function runs, R can do all kinds of bad things if
# you've accidentally coded something incorrectly. It is always really very 
# important to think about how many rows and columns you expect your new dataframe
# to have before you run your code and then check whether your new dataframe matches
# your expectation.


# We can also filter based on multiple conditions. For example, did the water get
# hot in both of the tributaries (Winchester and Smalle Creeks)?
# Note, we have to go back to our previous stream temperature data where these
# columns still exist.
highTempTributaries <- filter(.data=streamTempRename,
                              Smalle_temp >= 15, Winchester_temp >= 15)

# Alternatively,
highTempTributaries <- filter(.data=streamTempRename,
                              Smalle_temp >= 15 & Winchester_temp >= 15)


# We can also filter based on "or" - if any condition is true. For example, was
# water temp >=15 at any site?
highTempTributaries <- filter(.data=streamTempRename,
                              calispell_temp >= 15 | Smalle_temp >= 15 | Winchester_temp >= 15)


# Finally, we might want to only get the rows which do not have missing data. We can
# detect missing values with the is.na() function. Try it out:
is.na(c(3, 5, NA, 6))

# Now put an exclamation point (!) before is.na() to look for the opposite. This
# changes all of the TRUEs to FALSEs and FALSEs to TRUEs (i.e., tells us what is not
# an NA).
!is.na(c(3, 5, NA, 6))

# Time to put this all together! We can filter all of the rows of wtemp for which
# the value of calispell_temp is NOT NA.
calispellData <- filter(.data=calispellTemp,
                        !is.na(calispell_temp))

# QUESTION: How many observations are in the datafile calispellData? Write code to
# determine how many values of calispell_temp were NA.
## 52330 observations instead of 61100. Difference of 8770 (NA values).
61100-52330

# ---------------------------------------------------------- #
### PART 1.4: CREATING COLUMNS                            ####
# ---------------------------------------------------------- #

# It’s very common to need to create a new variable based on the value of one or
# more variables already in a dataset. The mutate() function does exactly this.

# TASK: Here, all of our temperature data are in Celsius. But what if we want to
# talk to a local school group about water temperature? We might want to convert
# it to a Fahrenheit column. Let's create a Fahrenheit column by running the
# following code:
calispellTempF <- mutate(.data=calispellTemp,
                         calispell_temp_F = calispell_temp*9/5 + 32)


# Take a look at the new dataframe to see if it worked by either opening 
# it from the R environment tab or running the following line of code.
head(calispellTempF) 


# We can also use mathematical functions on entire columns. Let's try it!

# TASK: Run the following code to create a new column that sums our two existing
# temperature columns.
calispellTempSum <- mutate(.data=calispellTempF,
                           sum=calispell_temp + calispell_temp_F)

# Check the dataframe to see if it worked.
View(calispellTempSum)

# TASK: The column we just created makes no sense. Write code below to remove it
# from the dataframe.
calispellTempSumRemoved <- select(.data=calispellTempSum, -sum)
View(calispellTempSumRemoved)

# QUESTION: We might also want to add a column that describes the dataset. What happens 
# when you run the following code?
calispellTempFaquatic <- mutate(.data=calispellTempF,
                                type='aquatic')

## It adds the characteristic "aquatic" in it's own column for each row.


# ---------------------------------------------------------- #
### PART 1.5: PASTING AND SEPARATING COLUMNS              ####
# ---------------------------------------------------------- #

# Sometimes it is nice to be able to combine columns. 

# TASK: Write code to create one more column named ecosystem in a new dataframe and 
# fill it with the word 'stream'.

calispellTempFaquaticEcosystem <- mutate(.data=calispellTempFaquatic,
                                         ecosystem='stream')


# Now we might want to create a new column that includes information from both of
# the columns we just created. We would do so by running the following lines of code:
calispellTempF4 <- unite(data=calispellTempF3,
                         col='type_ecosystem',
                         c('type', 'ecosystem'),
                         sep='::')

# QUESTION: Describe in your own words what the code above does. What part creates
# a new column? What part tells R which columns to combine? What does the sep= mean?
## The unite() function joins the columns together via the c() argument and using
## the col= argument to define the name. sep= is the separator character - this could
## be anything, like an "_" or "-", or even another num/value.


# Another very useful function is separate, which takes apart a column into two or
# more pieces.

# TASK: Run the following code:
calispellTempF5 <- separate(data=calispellTempF4,
                            col=type_ecosystem,
                            into=c('type', 'ecosystem'),
                            sep='::')

# QUESTION: Why isn't the column name in quotes this time?
## Because the column "type_ecosystem" already exists, we are just grabbing it.

# QUESTION: Describe in your own words what the code above does.
## It grabs the existing column "type_ecosystem" and splits it into two columns -
## type and ecosystem (via the into= argument), using the :: input as a separator -
## anything before the :: goes into the first col, anything after it goes into the 
## second.

# ---------------------------------------------------------- #
### PART 1.6: PIPES                                       ####
# ---------------------------------------------------------- #

# Take a look at your R environment tab (upper right of RStudio).
# Do you feel overwhelmed by how many files are there? I do!
# An amazing thing about tidyverse is that it can pass one function after another to
# a dataframe using an operator called a pipe. This allows you to perform a whole
# series of functions on one dataframe without having to create tons and tons of
# new dataframes.

# TASK: Click on the broom icon in your environment tab or run the following line of code
# to clear your R environment.
rm(list = ls())


# SHORTCUT: You can efficiently type the pipe icon '%>%' by using the pipe shortcut ctl+shift+m (windows) or cmd+shift+m (mac)! Try using the shortcut to create pipes whenever needed for the rest of the assignment.


# The pipe icon tells R to pass the dataframe it was just creating into another function.
# This is how we can get from one function to the next without creating and naming
# dozens of new dataframes. Hooray!

# TASK: We can start by creating our original dataframe, renaming the columns,
# selecting just the Calispell data, filtering to observations where the temperature
# was greater or equal to 15 C, and mutate a column to Farenheit temperatures. 
# Run the following lines of code and take a look at this new dataframe to see if R did
# everything we expect it to have done.
calispellHighTemp <- read.csv("CalispellCreekandTributaryTemperatures.csv", stringsAsFactors = TRUE) %>% 
  rename(calispell_temp=Calispell.Cr.Temp.C.,
         smalle_temp=Smalle.Cr.Temp.C.,
         winchester_temp=Winchester.Cr.Temp..C.) %>% 
  select(Date, Time, calispell_temp) %>% 
  filter(calispell_temp>=15) %>% 
  mutate(calispell_temp_F = calispell_temp*9/5 + 32)


# ---------------------------------------------------------- #
#### PART 2.0: USING YOUR NEW KNOWLEDGE                   ####
# ---------------------------------------------------------- #

# Put the functions you just learned to the test! We can use our skills to clean
# up a dataset of leaf carbon and nitrogen percentages from a nitrogen addition experiment
# in a grassland in Minnesota. We want to end up with nicely named variables, all the info
# we need about the experiment (but not too much info!), remove some observations that
# were collected a little differently than others, split apart a column into more
# functional parts, and ultimately calculate the C:N ratio (a useful number for
# understanding plant nutrient status).

# TASK: Perform the following steps in one workflow (i.e., using pipes):
# (1) Create a dataframe called cdr and load the .csv file 
# 'e001_Plant aboveground biomass carbon and nitrogen.csv' into it.
# (2) Add a column named 'Exp' and fill it with the text 'e001' so we know what 
# experiment we're working with.
# (3) Rename our last two columns that were originally '% Carbon' and '% Nitrogen' in
# our csv file. Make the new names 'C' and 'N', respectively.
# (4) Remove any observations that were not obtained from Strip 1.
# (5) Create a new column called NTrtInfo that include the information from both NTrt 
# and NAdd, separated by an underscore.
# (6) Split the Species column into two columns, one named 'genus' and one named 'species'.
# (7) Create a column called CN that contains the ratio of C to N for each observation.
# HINT: The ratio of C to N is calculated as C/N.
# (8) Keep only the following columns: Exp, Date, Plot, NTrtInfo, genus, species, 
# Field, C, N, and CN. 

cdr2 <- read.csv("C:\\Users\\leoiv\\Downloads\\e001_Plant aboveground biomass carbon and nitrogen.csv", stringsAsFactors = TRUE) %>%
  mutate(Exp='e001')%>%
  rename(C=X..Carbon, N=X..Nitrogen)%>%
  filter(Strip==1)%>%
  # mutate(NTrtInfo=paste(as.character(NTrt), as.character(NAdd), 
               # sep='_'))%>%
  unite(col="NTrtInfo",c("NTrt","NAdd"), sep="_")%>%
  separate(col=Species,
           into=c('Genus','Species'),
           sep=' ')%>%
  mutate(CN=C/N)%>%
  select(-NTrt, -NAdd, -NitrAdd, -NAtm.NAdd, -Strip)
  


# REMEMBER: Save and push your script when you're done with this assignment!