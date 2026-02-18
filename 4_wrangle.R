# ---------------------------------------------------------- #
#### MODULE 2: Wrangle some data!                         ####               
# ---------------------------------------------------------- #

## OBJECTIVE:
# 1. To learn how to manipulate and transform data into a form usable for 
# analysis and graphs.
# 2. To do this in a way that each step is traceable and reproducible.
# To this end we'll be familiarizing ourselves with and diving into the dplyr 
# package.


# ---------------------------------------------------------- #
#### SET UP:                                              ####
# ---------------------------------------------------------- #
# REMINDER: Be sure you are working in YOUR branch of our repository for all 
# commits related to this assignment.
# (1) Open the Rproject for our course (UNCG_DataWrangling), navigate to the 
# 'main' branch, and pull any changes from GitHub.
# (2) Navigate to the branch YOU created in RStudio's Git tab.
# (3) Only once you are in your branch, go to the terminal (tab next to console),
# and run the following code:
# git rebase main
# (4) Open this week's assignment in your branch to complete and submit on GitHub.

# Ideally, you'll commit your answers a bit at a time (like you were prompted to
# do last week) as you work through this assignment, rather than committing all 
# at once at the end.


# The dplyr package is nested within the tidyverse package (along with many 
# others).

# TASK: Install tidyverse and load the library. HINT: see the end of the week 1 
# assignment if you forget how to install and load a package.


# ---------------------------------------------------------- #
#### PART 1.0: LEARNING THE FUNCTIONS                     ####
# ---------------------------------------------------------- #

# We will use a dataset of water temperature in Calispell Creek and its 
# tributaries from eastern Washington State. These type of data are great for 
# scripted analysis because their formats remain constant but graphs frequently 
# need to be updated to reflect new data.
# In case you're interested, Calispell is the main river, while Smalle and 
# Winchester are tributaries.

# TASK: Download the data from the Canvas website. Remember to save it to your 
# working directory for this class! I have already added it to your .gitignore 
# file for you.


# TASK: Read in the data by running the following line of code.
streamTemp <- read.csv("CalispellCreekandTributaryTemperatures.csv", 
                       stringsAsFactors = TRUE) 


# QUESTION: What do you think stringsAsFactors mean?

## I'm not entirely sure, but I think "stringsAsFactors" means turning character strings into number strings. Usually when I think of strings, it's with a character string. So, a string of factors, seems to be more numerical.



# TASK: Let's learn a little more about our data. Run the following line of code.
str(streamTemp)

# QUESTION: What does it look like the str() function does?

## It looks like the str() function gives a list of each string of factors within the data frame, each containing observations and variables. In other words, it also seems to give an overview of what's inside the data frame.



# QUESTION: How many rows does our dataframe have? How many columns? 
# What class of data is in each column?

## There are 61,100 rows (observations) and 5 columns (variables). The classes of each data in each of the columns are "Date", "Time", "Calispell.Cr.Temp.C", "Smalle.Cr.Temp.C", and "Winchester.Cr.Temp.C".



# TASK: Try reading your data in without the stringsAsFactors argument included.


# QUESTION: What is the difference? (HINT: rerun the str function to check).
# When would we want to set the stringsAsFactors argument to true?  When would 
# it be better to make it false?

## The difference is that without "stringsAsFactors" our observations are character strings, instead of numerical/factorial strings. When using str() on both versions, it seems that the version with "stringsAsFactors" is more specific to tell me how many observations carry the same type of observation, whereas the version without "stringsAsFactors" just lists the observations without any sorting. We would want this to be set to TRUE if we have many observations, many of which that could be repeating values for the sake of pure data collection. This allows us to consolidate data into a repeating pattern or make updated data based on each unique instance. It could also be helpful when we know the observations are statistical. We would want this to be set to FALSE when we want each observation listed, without trying to sort between repeating values. This would help with a general data visualization without changing anything about the data. It would also be beneficial when we know the observations are not statistical (more based around words.)



# ---------------------------------------------------------- #
### PART 1.1: RENAMING COLUMNS                            ####
# ---------------------------------------------------------- #

# Let's assign some more useable column names! We do this using the rename() function.
# TASK: Open the file you downloaded from Canvas on your computer (e.g., using 
# excel. Then, run the following line of code.
colnames(streamTemp)


# QUESTION: What output do you get in the console? Why is this useful?

colnames(streamTemp)
[1] "Date"                   "Time"                   "Calispell.Cr.Temp.C."  
[4] "Smalle.Cr.Temp.C."      "Winchester.Cr.Temp..C."

## This is useful because it can quickly tell us the column names without us having to check the file itself. Also, if we change the names, we can run the same code to see if the code did what we wanted it to do.



# QUESTION: What happened to the title of the third column when it was loaded
# into R?
# HINT: What happened to the spaces and parenthesis in the R column names?

## In R, the spaces and parentheses are turned into "." because spaces and parentheses aren't wanted in this format.



# TASK: Run the following line of code. Note the alignment of the code components.
streamTempRename <- rename(.data=streamTemp,
                           calispell_temp=Calispell.Cr.Temp.C.,
                           smalle_temp=Smalle.Cr.Temp.C.,
                           winchester_temp=Winchester.Cr.Temp..C.)


# TASK: Write your own code to find the column names of our new dataframe 
# (streamTempRename). 

colnames(streamTempRename)
[1] "Date"            "Time"            "calispell_temp"  "smalle_temp"    
[5] "winchester_temp"



# QUESTION: What differences do you notice from before? In your own words, what
# did each line from the rename function do? Why might this function be useful 
# for wrangling data? In the rename code above, does the new column name come 
# before or after the =?

## First of all, the names did indeed change to what we wanted them to be changed to. The top line told us the new data frame we wanted to make out of the old data frame, using the rename function. The following lines are the renaming processes, each line representing a singular rename of a certain column.



# ---------------------------------------------------------- #
### PART 1.2: SELECTING COLUMNS                           ####
# ---------------------------------------------------------- #

# The select() function allows you to pick columns by name. This can be helpful
# when you want to clean a larger dataset and focus on your variables of 
# interest.

# Let's imagine that we are only interested in the temperature at the Calispell
# site.

# TASK: Look again at the columns you have in the streamTempRename dataframe by
# writing the necessary code below.

colnames(streamTempRename)
[1] "Date"            "Time"            "calispell_temp"  "smalle_temp"    
[5] "winchester_temp"



# TASK: Run the following line of code to select our columns of interest.
calispellTemp <- select(.data=streamTempRename,
                        calispell_temp, Date, Time)


# QUESTION: Take a look at the column names for our new dataframe (calispellTemp),
# by coding the appropriate R function of course. What do you notice about the 
# new dataframe? Which columns are present? Which are absent? Are they in the same 
# order as before?

## The only columns present in the data frame "calispellTemp" are "calispell_temp", "Date", and "Time". This means that the columns absent are "smalle_temp" and "winchester_temp". The columns remaining are not in the same order as before. They are ordered in the data frame the same way we ordered them in the code.

colnames(calispellTemp)
[1] "calispell_temp" "Date"           "Time"



# A nice thing to notice about this code. We didn't have to type 'streamTemp$date'
# etc to indicate each column as we would outside of the tidyverse. The select()
# function knows we are referring to streamTemp because the dataframe is our first
# argument to the function.


# TASK: Recall that in R, the `:` operator is a compact way to create a sequence 
# of numbers. For example, write code below to generate a sequence from 1 to 3.
# HINT: Look back to assignment #1 or the swirl tutorial for help (or google!).

seq(1:3)
[1] 1 2 3



# Normally this notation is just for numbers, but the select() function allows 
# you to specify a sequence of columns this way. This can save a bunch of typing!

#TASK: Create a new dataframe called calispellTemp2 and select the date, time, 
# and calispell_temp columns using the sequence notation.
# HINT: Replace the code where each column was listed out with a sequence of 
# column names. Be sure they are listed in the order they exist in the original
# dataframe.

calispellTemp2 <- select(.data=calispellTemp, 1:3)
calispellTemp2_again <- select(.data=streamTempRename, 3, 1:2)

## I was unsure of which "original data frame" you meant, so I did two versions, with one using "calispellTemp" and another using "streamTempRename". Although, I believe you meant for me to use "streamTempRename".



# TASK: Write code to check your column names again to see what happened in your
# new dataframe.

colnames(calispellTemp2)
[1] "calispell_temp" "Date"           "Time"

colnames(calispellTemp2_again)
[1] "calispell_temp" "Date"           "Time"



# We can also specify the columns that we want to discard by selecting them out.
# TASK: Run the following code to remove the Smalle_temp and Winchester_temp 
# columns. Note the use of the - sign to remove columns.
calispellTemp3 <- select(.data=streamTempRename,
                         -smalle_temp, -winchester_temp)

# The same thing can be accomplished by running the following code, which
# concatenates these columns together.
calispellTemp4 <- select(.data=streamTempRename,
                         -c(smalle_temp, winchester_temp))

# And the same thing can ALSO be accomplished by running the following code, which
# subtracts out a sequence of columns.
calispellTemp5 <- select(.data=streamTempRename,
                         -smalle_temp:-winchester_temp)


# TASK: Write code to check that these three new dataframes (calispellTemp3,
# calispellTemp4, and calispellTemp5) are identical.

# HINT: Unless you want to try to get very fancy with your code, you'll have to
# check dataframes two at a time. But you can always google to try to find sample
# code to do all three at once!

identical(calispellTemp3, calispellTemp4) & identical(calispellTemp3, calispellTemp5)
[1] TRUE



# ---------------------------------------------------------- #
### PART 1.3: FILTERING ROWS                              ####
# ---------------------------------------------------------- #

# Now that we've gone over how to select a subset of columns using the select()
# function, a natural next question is “How do I select a subset of rows?” 
# That’s where the filter() function comes in! Hooray!

# Note that filter() is really, by definition, subsetting our data. But, base R
# has a subset() function already. So in the tidyverse world, we refer to this as
# filtering instead.

# We might be worried about high water temperatures. Let's filter the the 
# Calispell dataframe to only include data where the Calispell Creek has 
# temperature equal or greater than 15 C.

filter(.data = calispellTemp, calispell_temp >= 15)



# QUESTION: If you remove all of the observations (rows) with temperatures lower
# than 15 C, would you expect your new dataframe to have more, the same, or fewer
# observations than the original dataframe?

##You would have fewer observations, as you would be removing observations that are less than 15 C.



# TASK: Run the following code to only keep the values greater than or equal to 15C.
calispellHighTemp <- filter(.data=calispellTemp,
                            calispell_temp >= 15)

# How do you know if it worked??
# TASK: Check the number of observations in your dataframe! You can either do 
# this using the str() function or by looking next to the dataframe name in the
# R environment tab.

str(calispellHighTemp)
'data.frame':	7703 obs. of  3 variables:
  $ calispell_temp: num  15.1 15.1 15.1 15.1 16.5 ...
$ Date          : Factor w/ 1821 levels "1/1/09","1/1/10",..: 1182 1182 1182 1217 1222 1222 1222 1222 1222 1222 ...
$ Time          : Factor w/ 288 levels "1:01:00 AM","1:01:00 PM",..: 104 128 152 104 6 78 102 126 150 174 ...



# QUESTION: How many observations did the original dataframe (calispellTemp) 
# have? How many does the new dataframe (calispellHighTemp) have?

## "calispellTemp" had 61,100 observations, while "calispellHighTemp" had 7,703 observations.



# REALLY IMPORTANT: Even if the function runs, R can do all kinds of bad things 
# if you've accidentally coded something incorrectly. It is always very, very 
# important to think about how many rows and columns you expect your new 
# dataframe to have before you run your code and then check whether your new
# dataframe matches your expectations.


# We can also filter based on multiple conditions. For example, did the water get
# hot in both of the tributaries (Winchester and Smalle Creeks)?
# Note, we have to go back to our previous stream temperature data where these
# columns still exist.
highTempTributaries <- filter(.data=streamTempRename,
                              smalle_temp >= 15, winchester_temp >= 15)

# Alternatively,
highTempTributaries <- filter(.data=streamTempRename,
                              smalle_temp >= 15 & winchester_temp >= 15)


# We can also filter based on "or" - if any condition is true. For example, was
# water temp >=15 at any site?
highTempTributaries <- filter(.data=streamTempRename,
                              calispell_temp >= 15 | smalle_temp >= 15 | winchester_temp >= 15)


# Finally, we might want to only get the rows that do not have missing data. We 
# can detect missing values with the is.na() function. Try it out:
is.na(c(3, 5, NA, 6))

# Now put an exclamation point (!) before is.na() to look for the opposite. This
# changes all of the TRUEs to FALSEs and FALSEs to TRUEs (i.e., tells us what is 
# not an NA).
!is.na(c(3, 5, NA, 6))

# Time to put this all together! We can filter all of the rows of calispellTemp 
# for which the value of calispell_temp is NOT NA.
calispellData <- filter(.data=calispellTemp,
                        !is.na(calispell_temp))

# QUESTION: How many observations are in the datafile calispellData? Write code
# to determine how many values of calispell_temp were NA.

calispell_na_Data <- filter(.data=calispellTemp,
                            is.na(calispell_temp))

## In "calispellData" there are 52,330 observations, and in "calispell_na_Data" there are 8,770 observations.



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


# Take a look at the new dataframe to see if it worked by either opening it from 
# the R environment tab or running the following line of code.

head(calispellTempF) 
calispell_temp   Date        Time calispell_temp_F
1           1.96 1/1/09  1:11:23 AM           35.528
2           1.32 1/1/09  1:11:23 PM           34.376
3           1.16 1/1/09 10:11:23 AM           34.088
4           1.96 1/1/09 10:11:23 PM           35.528
5           1.16 1/1/09 11:11:23 AM           34.088
6           1.96 1/1/09 11:11:23 PM           35.528



# We can also use mathematical functions on entire columns. Let's try it!

# TASK: Run the following code to create a new column that sums our two existing
# temperature columns.
calispellTempSum <- mutate(.data=calispellTempF,
                           sum=calispell_temp + calispell_temp_F)

# Check the dataframe to see if it worked.

head(calispellTempSum)
calispell_temp   Date        Time calispell_temp_F    sum
1           1.96 1/1/09  1:11:23 AM           35.528 37.488
2           1.32 1/1/09  1:11:23 PM           34.376 35.696
3           1.16 1/1/09 10:11:23 AM           34.088 35.248
4           1.96 1/1/09 10:11:23 PM           35.528 37.488
5           1.16 1/1/09 11:11:23 AM           34.088 35.248
6           1.96 1/1/09 11:11:23 PM           35.528 37.488



# TASK: The column we just created makes no sense (why would you ever want to
# sum the C and F temperatures?). Write code below to remove it from the dataframe.

select(.data = calispellTempSum, -sum)

## Or, since this just brings us back to "calispellTempF", we could just:

rm(calispellTempSum)



# QUESTION: We might also want to add a column that describes the dataset. What
# happens when you run the following code?
calispellTempFaquatic <- mutate(.data=calispellTempF,
                                type='aquatic')

## This adds a new column labelled "type" and has the word "aquatic" in every observation under that column.



# ---------------------------------------------------------- #
### PART 1.5: PASTING AND SEPARATING COLUMNS              ####
# ---------------------------------------------------------- #

# Sometimes it is nice to be able to combine columns. 

# TASK: Write code to create one more column named ecosystem in the 
# calispellTempFaquatic dataframe and fill it with the word 'stream'.

calispellTempFaquatic <- mutate(.data=calispellTempFaquatic,
                                ecosystem ='stream')



# Now we might want to create a new column that includes information from both 
# of the columns we just created. We would do so by running the following lines 
# of code:
calispellTempF4 <- unite(data=calispellTempFaquatic,
                         col='type_ecosystem',
                         c('type', 'ecosystem'),
                         sep='::')

# QUESTION: Describe in your own words what the code above does. What part 
# creates a new column? What part tells R which columns to combine? What does 
# the sep= argument do?

## The first line will create a new data frame named "calispellTempF4" from the data frame "calispellTempFaquatic", while preparing a column-combining function. The second line will determine that the new column will be named "type_ecosystem". The third line tells us which two columns that are being used to create one column. In this case, that would be the columns "type" and "ecosystem". The fourth line is referring to the spacing between our observation values in this new column. Our observations before were "aquatic" and "stream", so without any spacing it would be "aquaticstream". However, this fourth line tells us that we have a "::" between them, or "aquatic::stream".



# Another very useful function is separate, which takes apart a column into two
# or more pieces.

# TASK: Run the following code:
calispellTempF5 <- separate(data=calispellTempF4,
                            col=type_ecosystem,
                            into=c('type', 'ecosystem'),
                            sep='::')

# QUESTION: Why isn't the column name in quotes this time?

## I'm not entirely sure. I think it's because when you're using unite(), you're creating a name that hasn't been recognized by R yet, so it wants you to use quotations. However, when you're using separate(), the name is already recognized by R, so it doesn't care if you use quotations or not.



# QUESTION: Describe in your own words what the code above does.

## So, the first line is telling us that it's creating a new data frame called "calispellTempF5" out of the pre-existing data frame "calispellTempF4". The first line is also laying out the foundation for separating two columns. The second line is telling us the column we are going to separate. In this case, it is "type_ecosystem". The third line is telling us that we are making the column "type_ecosystem" into two columns named "type" and "ecosystem". The fourth line is explaining where we are splitting the observations. When using unite(), we used "::" to decide where we were putting "::" in the observation. Now that we are using separate(), we are deciding where to split the observation from one column to the other.This is needed, because the third line is separating variables, while the fourth line is separating observations. So, it's about organizing where everything separates to.



# ---------------------------------------------------------- #
### PART 1.6: PIPES                                       ####
# ---------------------------------------------------------- #

# Take a look at your R environment tab (upper right of RStudio).
# Do you feel overwhelmed by how many files are there?
# An amazing thing about tidyverse is that it can pass one function after 
# another to a dataframe using an operator called a pipe. This allows you to 
# perform a whole series of functions on one dataframe without having to create 
# tons and tons of new dataframes.

# TASK: Click on the broom icon in your environment tab or run the following 
# line of code to clear your R environment.
rm(list = ls())


# SHORTCUT: You can efficiently type the pipe icon '%>%' by using the pipe 
# shortcut ctl+shift+m (windows) or cmd+shift+m (mac)! Try using the shortcut 
# to create pipes whenever needed for the rest of the assignment.

# The pipe icon tells R to pass the dataframe it was just working with into 
# another function. This is how we can get from one function to the next without 
# creating and naming dozens of new dataframes. This is great for organization!

# TASK: We can start over by creating our original dataframe, renaming the 
# columns, selecting just the Calispell data, filtering to observations where 
# the temperature was greater or equal to 15 C, and mutate a column to Farenheit. 
# Run the following lines of code and take a look at this new dataframe to see 
# if R did everything we expect it to have done.
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
# up a dataset of leaf carbon and nitrogen percentages from a nitrogen addition 
# experiment in a grassland in Minnesota. We want to end up with nicely named 
# variables, all the info we need about the experiment (but not too much info!), 
# remove some observations that were collected a little differently than others, 
# split apart a column into more functional parts, and ultimately calculate the 
# C:N ratio (a useful number for understanding plant nutrient status).

# TASK: Perform the following steps in one workflow (i.e., using pipes):
# (1) Create a dataframe called cdr and load the .csv file 
# 'e001_Plant aboveground biomass carbon and nitrogen.csv' into it.
# (2) Add a column named 'Exp' and fill it with the text 'e001' so we know what 
# experiment we're working with.
# (3) Rename our last two columns that were originally '% Carbon' and '% Nitrogen' 
# in our csv file. Make the new names 'C' and 'N', respectively.
# (4) Remove any observations that were not obtained from Strip 1.
# (5) Create a new column called NTrtInfo that include the information from both 
# NTrt and NAdd, separated by an underscore.
# (6) Split the Species column into two columns, one named 'genus' and one named 
# 'species'.
# (7) Create a column called CN that contains the ratio of C to N for each 
# observation.
# HINT: The ratio of C to N is calculated as C/N.
# (8) Keep only the following columns: Exp, Date, Plot, NTrtInfo, genus, species, 
# Field, C, N, and CN. 



# REMEMBER: Save and push your script to your branch when you're done with this 
# assignment!