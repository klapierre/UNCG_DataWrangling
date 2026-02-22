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

install.packages('tidyverse')
library('tidyverse')

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

setwd("c:/users/bigsi/OneDrive/Desktop/UNCG_DataWrangling")


# TASK: Read in the data by running the following line of code.
streamTemp <- read.csv("CalispellCreekandTributaryTemperatures.csv", 
                       stringsAsFactors = TRUE) 


# QUESTION: What do you think stringsAsFactors mean?
#Answer: My guess as to what strings as Factors means is that all of the strings in the data will not function as a factor instead of a string.


# TASK: Let's learn a little more about our data. Run the following line of code.
str(streamTemp)

# QUESTION: What does it look like the str() function does?
#Answer: I think the str() function shows what the inside of the data frame looks like because it is reciting the # of observations and the # of variables, but also the 5 variables.



# QUESTION: How many rows does our dataframe have? How many columns? 
# What class of data is in each column?
#Our data set has 5 rows and 61100 observations. It appears that Date and time are both factors and Calispell.Cr.Temp.C., Smalle.Cr.Temp.C., and Winchester.Cr.Temp..C. are numbers.


# TASK: Try reading your data in without the stringsAsFactors argument included.
streamTemp <- read.csv("CalispellCreekandTributaryTemperatures.csv")
str(streamTemp)

# QUESTION: What is the difference? (HINT: rerun the str function to check).
# When would we want to set the stringsAsFactors argument to true?  When would 
# it be better to make it false?
#Answer: It looks like the difference between the two is that when the strings are not being viewed as factors it is classified as a character and instead of catagorizing each text as a level, each one is listed out. I think that the False strings as # is easier to read and understand, but if you need to filter data by date and time it might be better to have a True stringsAsFactors. However it might be easier to have a FALSE statement if you want to filer the temperature results instead of data dn time.


# ---------------------------------------------------------- #
### PART 1.1: RENAMING COLUMNS                            ####
# ---------------------------------------------------------- #

# Let's assign some more useable column names! We do this using the rename() function.
# TASK: Open the file you downloaded from Canvas on your computer (e.g., using 
# excel. Then, run the following line of code.
colnames(streamTemp)


# QUESTION: What output do you get in the console? Why is this useful?
#Answer: The output is a list of all the column names. This is very useful because you can look at them and their order without the clutter of the rest of the data. It also makes it easier to edit the columns when you can see all of them, and it means you can see the contents of the data without looking at all of the data.

# QUESTION: What happened to the title of the third column when it was loaded
# into R?
# HINT: What happened to the spaces and parenthesis in the R column names?
#Answer: What happened is that all of the spaces were replaced with periods, and all of the parenthesis were replaced with periods.


# TASK: Run the following line of code. Note the alignment of the code components.
streamTempRename <- rename(.data=streamTemp,
                           calispell_temp=Calispell.Cr.Temp.C.,
                           smalle_temp=Smalle.Cr.Temp.C.,
                           winchester_temp=Winchester.Cr.Temp..C.)


# TASK: Write your own code to find the column names of our new dataframe 
# (streamTempRename). 
colnames(streamTempRename)


# QUESTION: What differences do you notice from before? In your own words, what 
# did each line from the rename function do? Why might this function be useful 
# for wrangling data? In the rename code above, does the new column name come 
# before or after the =?
#Answer: Each line of the rename code changed the name of the column name in the line, so you place the new name that you want to the left of the equal sign, and the name that you want to change on the right. The thing that I noticed is that becuase date and time were already concise names the only names that were changed were the last three which got distorted in the transfer from excel into R. This is a super helpful function because it allows you to make sure that the data is readable even if the format changes between platforms.


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

# TASK: Run the following line of code to select our columns of interest.
calispellTemp <- select(.data=streamTempRename,
                        calispell_temp, Date, Time)


# QUESTION: Take a look at the column names for our new dataframe (calispellTemp),
# by coding the appropriate R function of course. What do you notice about the 
# new dataframe? Which columns are present? Which are absent? Are they in the same 
# order as before?
colnames(calispellTemp)
#Answer: Now the new dataframs is excluding any columns that were not mentioned in code line 144. Now only the columns calispell_temp, Date, and Time are present and smalle_temp and winchester_temp are absent from the data set. The order of the columns has also changed, they appear to now be in the order that is listed in the the select function.

# A nice thing to notice about this code. We didn't have to type 'streamTemp$date'
# etc to indicate each column as we would outside of the tidyverse. The select()
# function knows we are referring to streamTemp because the dataframe is our first
# argument to the function.


# TASK: Recall that in R, the `:` operator is a compact way to create a sequence 
# of numbers. For example, write code below to generate a sequence from 1 to 3.
# HINT: Look back to assignment #1 or the swirl tutorial for help (or google!).
seq_13<-c(1:3)
seq_13

# Normally this notation is just for numbers, but the select() function allows 
# you to specify a sequence of columns this way. This can save a bunch of typing!

#TASK: Create a new dataframe called calispellTemp2 and select the date, time, 
# and calispell_temp columns using the sequence notation. !!!Ask Komatsu####
# HINT: Replace the code where each column was listed out with a sequence of 
# column names. Be sure they are listed in the order they exist in the original 
# dataframe.
calispellTemp2<-select(.data=streamTempRename,1:3)

# TASK: Write code to check your column names again to see what happened in your
# new dataframe.
colnames(calispellTemp2)

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
#Answer: They all came back as TRUE letting me know that all three data_frames are identical
identical(calispellTemp3,calispellTemp4)
identical(calispellTemp4,calispellTemp5)
identical(calispellTemp3,calispellTemp5)

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

# QUESTION: If you remove all of the observations (rows) with temperatures lower
# than 15 C, would you expect your new dataframe to have more, the same, or fewer
# observations than the original dataframe?
#Answer: I would expect there to be fewer observations than the original dataframe.


# TASK: Run the following code to only keep the values greater than or equal to 15C.
calispellHighTemp <- filter(.data=calispellTemp,
                            calispell_temp >= 15)

# How do you know if it worked??
# TASK: Check the number of observations in your dataframe! You can either do 
# this using the str() function or by looking next to the dataframe name in the
# R environment tab.
#Answer: I chose to check via the environment becuase I knew they would be on top


# QUESTION: How many observations did the original dataframe (calispellTemp) 
# have? How many does the new dataframe (calispellHighTemp) have?
#Answer: The original datafram calispellTemp had 61100 observations, and the new dataframe calispellHighTemp has 7703 observations which is significantly less than the original data frame.


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
str(calispellData)
#Answer: There are 52330 observations in calispellData

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


# We can also use mathematical functions on entire columns. Let's try it!

# TASK: Run the following code to create a new column that sums our two existing
# temperature columns.
calispellTempSum <- mutate(.data=calispellTempF,
                           sum=calispell_temp + calispell_temp_F)

# Check the dataframe to see if it worked.
head(calispellTempSum)

# TASK: The column we just created makes no sense (why would you ever want to
# sum the C and F temperatures?). Write code below to remove it from the dataframe.
calispellTempMinus <- select(.data=calispellTempSum,
                         -sum)
head(calispellTempMinus)

# QUESTION: We might also want to add a column that describes the dataset. What 
# happens when you run the following code?
calispellTempFaquatic <- mutate(.data=calispellTempF,
                                type='aquatic')
head(calispellTempFaquatic)
#Answer: Now there is another column called type, and every observation is labeled as aquatic in that column.

# ---------------------------------------------------------- #
### PART 1.5: PASTING AND SEPARATING COLUMNS              ####
# ---------------------------------------------------------- #

# Sometimes it is nice to be able to combine columns. 

# TASK: Write code to create one more column named ecosystem in the 
# calispellTempFaquatic dataframe and fill it with the word 'stream'.
calispellTempFaquatic <- mutate(.data=calispellTempFaquatic,
                                ecosystem='stream')
head(calispellTempFaquatic)

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
#Answer: The section that makes the new column is the col= function which you then assign the name of the column after the = sign. The unite function tells R to combine the columns, so inside unite you tell the function what data set you are using, then is where you are adding/assignning a column, and then the c which is the function that also indicates the creation of a vector is used to dictate which column data is being united which in this situation is 'type' and 'ecosystem'. After the function is closed, the sep function is being used so that when the columns are combined there is seperation between the observation that are now in the same columns. So now in the type_ecosystme column instead of saying 'aquaticstream' it says 'aquatic::stream'
head(calispellTempF4)

# Another very useful function is separate, which takes apart a column into two
# or more pieces.

# TASK: Run the following code:
calispellTempF5 <- separate(data=calispellTempF4,
                            col=type_ecosystem,
                            into=c('type', 'ecosystem'),
                            sep='::')

# QUESTION: Why isn't the column name in quotes this time?
#Answer: I think that the column name is not in quotes this time we are not using col to make a new column, instead we are seperating a column that already exists into two "new" columns where using the separate function you dictate the new columns using the into= instead of col=.

# QUESTION: Describe in your own words what the code above does.
#Answer: so the code above uses the function separate to take the data set calispellTempF4 and seperates the column type_ecosystem into two columns, 'type and 'ecosystem'. The first portion, data=, tells the function which data set the code is refering to, next col=, tells the function which existing column in the data set is being seperated, then into= contains what the preexisting column is being turned into, in this case it is being seperated into two columns 'type' and 'ecosystem'.

# ---------------------------------------------------------- #
### PART 1.6: PIPES                                       ####
# ---------------------------------------------------------- #

# Take a look at your R environment tab (upper right of RStudio).
# Do you feel overwhelmed by how many files are there?

#Answer: Yes, very much so actually, especially if I want to use split screen to understand how a function works and the help is not cutting it, it becomes hard to read the dataset names.

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

cdr <- read.csv("e001_Plant aboveground biomass carbon and nitrogen.csv") %>% 
  mutate(exp='e001') %>% 
  rename(C = all_of("% Carbon"),N = all_of("% Nitrogen")) %>%
  filter(Strip == 1) %>% 
  mutate(NTrtInfor=paste(NTrt, NAdd, sep = " ")) %>% 
  separate(Species, into=c("genus", "species"), sep=" ") %>% 
  mutate(CN = C/N) %>% 
  select(Exp, Date, Plot, NTrtInfor, genus, species, Field, C, N, CN) 
  
cdr <- read_csv("e001_Plant aboveground biomass carbon and nitrogen.csv")

colnames(cdr)
# REMEMBER: Save and push your script to your branch when you're done with this 
# assignment!