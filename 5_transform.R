# ---------------------------------------------------------- #
#### MODULE 2: Transform some data!                         ####               
# ---------------------------------------------------------- #

## OBJECTIVE:
# 1. To learn how to manipulate and transform data into a form usable for 
# analysis and graphs.
# 2. To do this in a way that each step is traceable and reproducible.
# To this end we'll continue to familiarize ourselves with the dplyr package and 
# dive into the tidyr package.


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

# REMINDER: The dplyr and tidyr packages are nested within the tidyverse package
# (along with many others). Be sure to start by loading the tidyverse library.
# HINT: see the end of assignment #1 if you forgot how to load a package.
library('tidyverse')

# ---------------------------------------------------------- #
#### PART 1.0: LEARNING THE FUNCTIONS                     ####
# ---------------------------------------------------------- #

# Let's go back to our dataset of water temperature in Calispell Creek and its 
# tributaries from eastern Washington State.

# TASK: Read in the CalispellCreekandTributaryTemperatures.csv file and assign 
# it to a dataframe named streamTemp. Clean up the column names to the following:
# data, time, calispell, smalle, winchester
# HINT: Check last week's assignment if you forget how to read data into R.
streamTemp <- read.csv("CalispellCreekandTributaryTemperatures.csv", 
                       stringsAsFactors = TRUE) 
streamTemp <- rename(.data=streamTemp,
                           calispell=Calispell.Cr.Temp.C.,
                           smalle=Smalle.Cr.Temp.C.,
                           winchester=Winchester.Cr.Temp..C.)

# ---------------------------------------------------------- #
### PART 1.1: SUMMARIZING DATA                            ####
# ---------------------------------------------------------- #

# We can use the summarize() function to get a lot of quick stats on our data!
# Let's try out the length function by running the following code:
streamTempLength <- streamTemp %>% 
  summarize(calispell_length = length(calispell),
            smalle_length = length(smalle),
            winchester_length = length(winchester))

# QUESTION: When you open the streamTempLength dataframe, what value is in each 
# column?
#Answer: 61100 is the value that is in each column


# QUESTION: How does this number compare to the number of observations listed by
# the dataframe in the R environment tab?
#Answer: The R environment tab  says there is only 1 observation in the streamTempLength, but then in streamTemp it also says 61100 observations just like the value in the dataframe.


# QUESTION: Based on your previous answers, what do you think the length 
# function does?
#Answer: I think that the length function gives the number of observations in the column.


# It can be a bit tedious to type out all the column names and the length 
# function multiple times. The across() function within the summarize() step can
# help us to identify multiple columns to summarize the data for. Try running 
# the following code:

#streamTempLength is a new dataset made from streamTemp
streamTempLength <- streamTemp %>% 
#Summarize the columns calispell, smalle, and winchester by how long the column is (# of observations)
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=length))

# TASK: Using comments in the code above, describe what each line is doing.
#Completed

# We might also want to know some other statistics about our data, such as the 
# max, min, and mean values. The across() function is useful for this too, by 
# letting you set multiple functions to summarize each column by. Try running 
# the following code:
streamTempSummary <- streamTemp %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=list(maximum=max, mean=mean, minimim=min)))

# TASK: Write code to view the column names of the streamTempSummary dataframe.
colnames(streamTempSummary)

# QUESTION: How does R know what to name each column when we use the summarize 
# function above?
#Answer: It looks like R takes the column name and uses that with an underscore and then the functions applied. So the list function seems to have a list of text that is being added to the original column names.


# QUESTION: What values do you see for the columns when you open up the 
# dataframe streamTempSummary? Why do you think this is?
#Answer: There are only NA values. I suspect this is becuase there are other columns in the data set that contain characters and also a lot of the data in the dataset was missing.


# Recall that our data had a lot of missing values. R doesn't know how to find 
# the mean, max, or min of a group of observations that include NAs.
# To fix this problem, we need to add a statement telling R to remove the NAs 
# when calculating these summary stats. Run the following code:
streamTempSummary <- streamTemp %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=list(maximum=max, mean=mean, minimim=min),
                   na.rm=TRUE))

# QUESTION: Now what values do you see for the columns when you open up the 
# dataframe streamTempSummary? What line of the above code removed the NAs from 
# our data?
#Answer: Now there are numerical values in the dataset. it is the na.rm=TRUE that removed all of the NAs from the data.


# QUESTION: What happened to the column we created in the beginning called 
# data_type? Where did the date and time columns go?
#Answer: I believe that because of the summarize function it got rid of any colum that was not in the list of columns that was provided to the function.


# RECOMMENDED: Take a look at the summarize help file, particularly the "Useful 
# functions" section to see all of the different ways you can summarize your 
# dataframe.
?summarize

# ---------------------------------------------------------- #
### PART 1.2: GROUPING DATA                               ####
# ---------------------------------------------------------- #

# Summarizing data is great, but it can be more useful to get summaries for 
# particular subsets of the data.

# TASK: Write code to do the following:
# (1) Separate the date column into columns named month, day, and year;
# (2) Mutate the year column to paste '20' to the front of each year value;
# (3) Call your new dataframe streamTempMDY.
# HINT: Check the help documentation for the separate(), mutate(), and paste() 
# functions.
streamTempMDY <- streamTemp %>%
  separate(Date, into = c("month", "day", "year"), sep = "/") %>%
  mutate(year = paste("20", year, sep = ""))


# TASK: Write code to create a new dataframe called streamTempJan that filters 
# only rows where the month column is equal to 1 from the streamTempMDY dataframe.
streamTempJan <- streamTempMDY %>%
  filter(month == "1")


# TASK: Write code that uses the summarize function to find the mean temperature 
# for Calispell, Smalle, and Winchester streams in only January.
streamTempJan %>%
  summarize(Calispell_mean = mean(calispell, na.rm = TRUE),Smalle_mean = mean(smalle, na.rm = TRUE),Winchester_mean = mean(winchester, na.rm = TRUE))


# Now imagine you had to repeat this set of steps (creating new filtered 
# dataframes) for all 12 months!
# That would not only be tedious, but would also clutter up our R environment.
# Instead, we can use the handy group_by() function before the summarize() 
# function to tell R that we want to get the summary stats for each of the 
# groups we specify.
# Try running the following code:
streamTempMonthlyMean <- streamTempMDY %>% 
  group_by(month) %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=mean,
                   na.rm=T)) %>% 
  ungroup()

# NOTE: Whenever you group a dataframe, you should always ungroup after 
# performing your function. Otherwise, R will consider that dataframe to be 
# grouped forever, which can mess up future functions.


# QUESTION: When you look at the streamTempMonthlyMean dataframe, how many means 
# do you see for each stream?
#Answer: I see twelve means for each stream

# QUESTION: In your own words, what do you think the group_by() function does 
# when used before the summarize() function?
#Answer: It creates the groups that summarize will summarize. So if you use group_by before summarize, instead of getting one summary per column, you get a summary per previous grouping.


# We can also group by multiple columns. Try running the following code:
streamTempMeans <- streamTempMDY %>% 
  group_by(month, year) %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=mean,
                   na.rm=T)) %>% 
  ungroup()

# QUESTION: What columns did we group by to get our new means? What does the new 
# dataframe show?
#Answer: Month and year were grouped together to show a mean per month recorded per year recorded. There are five years recorded, so there are twelve means per five years meaning there are 60 means.


# ---------------------------------------------------------- #
### PART 1.3: PRACTICING THESE SKILLS                     ####
# ---------------------------------------------------------- #

# Let's return to our flight delays question from last week. Recall that we are 
# interested  in avoiding flights with long delays. Load the data for New York 
# City flights by running  the following code:
flightData <- nycflights13::flights

# TASK: Write a pipeline to figure out which airport of origin to avoid when 
# flying to Raleigh  by taking the original flight dataframe (flightData) and 
# performing the following tasks:
# (1) filter to keep only flights that have RDU as the destination (dest column);
# (2) groups the data by airport of origin (origin column);
# (3) summarize to find the mean arrival delay (arr_delay column) remembering to 
#     remove NAs;
# (4) ungroup the dataframe;
# (5) assign the output to a dataframe named airportDelaySummary.

airportDelaySummary <- flightData %>%
  filter(dest == "RDU") %>%                 
  group_by(origin) %>%                      
  summarize(mean_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%  
  ungroup() 


# QUESTION: Which airport should you avoid if you want the shortest delays?
#Answer: You should avoid EWR if you want the shortest delays.


# TASK: Write a pipeline to figure out which month of the year to avoid when 
# flying to Raleigh  by taking the original flight dataframe (flightData) and 
# performing the following tasks:
# (1) filter to keep only flights that have RDU as the destination (dest column);
# (2) groups the data by hour;
# (3) summarize to find the mean AND the maximum arrival delay (arr_delay column), 
#     remembering to remove NAs;
# (4) ungroup the dataframe;
# (5) assign the output to a dataframe named timeDelaySummary
timeDelaySummary <- flightData %>%
  filter(dest == "RDU") %>%                                  
  group_by(hour) %>%                                        
  summarize(mean_arr_delay = mean(arr_delay, na.rm = TRUE),max_arr_delay = max(arr_delay, na.rm = TRUE)) %>%
  ungroup() 


# QUESTION: What is the earliest hour of the day that flights leave New York for 
# Raleigh?
#Answer: It looks like the earliest hour that a flight leaves to Raleigh from New York is 6am.


# QUESTION: Which hour of the day has the longest mean delay? What about the 
# longest maximum delay?
#Answer: Hour 22 has the longest mean delay of ~65,and hour 12 has the longest max delay of 430 hours


# TASK: Write a pipeline to figure out which month of the year and airport to 
# avoid when flying to Raleigh by taking the original flight dataframe 
# (flightData) and performing the following tasks:
# (1) filter to keep only flights that have RDU as the destination (dest column);
# (2) groups the data by month AND origin;
# (3) summarize to find the mean arrival delay (arr_delay column), remembering 
#     to remove NAs;
# (4) ungroup the dataframe;
# (5) assign the output to a dataframe named monthlyDelaySummary
monthlyDelaySummary <- flightData %>%
  filter(dest == "RDU") %>%                                   
  group_by(month, origin) %>% 
  summarize(mean_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  ungroup()


# QUESTION: Which month and airport has the longest mean delay?
#Answer: March at EWR has the longest mean delay of ~30hours *makes sense becuase of spring break

# ---------------------------------------------------------- #
### PART 2.0: INTRO TO TIDY DATA                          ####
# ---------------------------------------------------------- #

# QUESTION: What are three characteristics of tidy data?
#Answer: Each column is a variable, each row is an observation, and each cell is one measurement.

# There are five common problems associated with messy data:
# 1. Column headers are values, not variable names
# 2. Multiple variables are stored in one column
# 3. Variables are stored in both rows and columns
# 4. Multiple types of observational units are stored in the same table
# 5. A single observational unit is stored in multiple tables

# Here we will build a workflow to demonstrate how we can tidy up a dataset.
# Let's start by clearing our R environmnet and then bringing the Willow 
# Seedling Survey data into R by running the following line of code:
rm(list = ls())
willow <- read_csv("Niwot_Salix_2014_WillowSeedlingSurvey.csv", skip = 10)

# QUESTION: What do you think the statement 'skip = 10' means in the code above?
# HINT: Compare the csv file on your computer and the dataframe that you loaded 
# into R.
#Answer: The original datafram appears to have some information at the top that the data in R does not have, so my guess is that skip ignores line 10 or ignores 10 lines starting from the top moving down.


# ---------------------------------------------------------- #
### PART 2.1: FILL MISSING DATA                           ####
# ---------------------------------------------------------- #

# Sometimes when a data source has primarily been used for data entry, missing 
# values indicate that the previous value should be carried forward.

# QUESTION: To clean up the willow dataframe, where do we want to fill in values? 
# That is, which columns have lots of NAs.
# Answer: Most of the columns have a ton of NAs. The only ones that don't are the variable columns and willow_1 (which just has less than the other willows.)


# We can fix our missing value problem using the fill() function (try it by 
# running the following code):
willowFill <- willow %>%
  fill(block:temp)

# QUESTION: What does the code 'block:temp' mean when passed to the fill() 
# function above?
#Answer: It tells the fill function that columns block through column temp, all NA should be filled.


# QUESTION: Looking at the dataframe willowFill, describe what happened compared 
# to our initial dataframe.
#Answer: The new data frame has columns block through temp filled with no more NAs. It looks like the previous observation was dragged through the empty cells below until a new observation was hit.


# ---------------------------------------------------------- #
### PART 2.2: PIVOT LONGER                                ####
# ---------------------------------------------------------- #

# Another common problem, the column headers are values instead of variable 
# names! In this case, the columns w1 through wC are individual willow seedlings 
# that were sampled repeatedly.

# TASK: Write code to indicate the sequence of columns from w1 through wC. 


# We can fix this problem using the pivot_longer() function. pivot_longer() takes 
# multiple columns and condenses them into just two columns, one that indicates 
# what column the data came from and the other that contains the data itself.
# And while we're at it, let's get rid of the 'w' in front of each willow 
# individual number.
# Run the following code:

#Creates a new dataset, 'willowClean' from dataset willowFill
willowClean <- willowFill %>%
#Converts the rows w_1:w_C into rows instead of columns
  pivot_longer(cols = w_1:w_C,
#The original column name moves into the column willow_id
               names_to = "willow_id",
#the original values of each column go into the new column value
               values_to = "value") %>%
#The willow_id column is seperated into two columns
  separate(col = willow_id,
#The two new columns are "remove" and "willow_ID"
           into = c("remove", "willow_ID"),
#The willow_id column is seperated where there is an underscore
           sep = "_") %>%
#The column remove was deleted from the dataframe.
  select(-remove)


# TASK: Annotate (add comments) the code above to indicate what each line does.


# ---------------------------------------------------------- #
### PART 2.3: PIVOT WIDER                                 ####
# ---------------------------------------------------------- #

# Yikes, another common problem, the variables are stored in both rows and columns!

# QUESTION: What column contains the labels that tell us there are multiple 
# variables stored in one column? What column contains the corresponding date 
# for these variables?
#Answer: There is one column that is labeled variable, and I am not sure where the corresponding dates are for these variables. Maybe is is the values column or the id column that tells you which  willow it is, but the variables are just repeated over and over in the column per willow in each plot per block.


# Good news, we can fix this problem with the complementary function to pivot_longer().
# This time we will use the pivot_wider() function to turn one column into multiple.

#Makes a new dataframe "willowCleaner' from the datafram willowclean
willowCleaner  <- willowClean %>%
#Takes the names that are in the column variable and turns them into columns with the values from the value column.
  pivot_wider(names_from = variable,
              values_from = value)


# TASK: Take a look at our new dataframe. How does it differ from the previous?
# Annotate (add comments) the code above to indicate what each line does.
#Answer: Now all of the variables that were in the variables column are there own individual columns


# ---------------------------------------------------------- #
### PART 2.4: IF ELSE                                     ####
# ---------------------------------------------------------- #

# Sigh, another major issue: multiple variables are stored in one column again!
# This occurs in the ht1 (height 1) column, where there is information about the 
# plant status (whether it is dead or alive) AND the height for only the 
# individuals that were alive. And then it is a problem again in the willow_ID 
# column, which tells us information about when each seedling was planted.

# TASK: Verbally describe how you would want to change this problem 
# (i.e., pseudocode).
#Answer: I would want to take the ht1 column and almost sort it into two columns, one column with the height and another column that is if the plant is alive or not. 
#then with the willow_ID column I would want to stop repetatively recording data for all of the willows that were found to be dead so that you can clearly see the living willows and the data that is recorded for them.


# ifelse() is a very powerful function that helps us with this problem!

# TASK: Look at the ifelse help file and describe in your own words the ordering 
# of the syntax.
?ifelse
#I do not completedly understand this function, but what I think it is doing is that the first value is a question or test if the variable passes the test then either the value of yes is put into the place or x does what is in the yes space (The second value in the function), if the test is false than the no value is used.

# We can nest the ifelse() function within a mutate() function to create a new 
# column that contains one entry if the logical statement we provide is TRUE and 
# another if the logical statement is FALSE. Run the following code to try it 
# out to help fix our first problem (ht1 column has information on both plant 
# status and actual height values).

#I changed the willowClean2 into willowCleaner becuase I had not created a willowClean2 at this point
#A new dataset willowClean3 is created from the dataset willowCleaner
willowClean3 <- willowCleaner %>%
#A new column "status" is made with the mutate function where if the observation says dead then the observation remains as 'dead' and if it has a numerical value than it says 'alive' instead
  mutate(status = ifelse(ht1 == 'dead', 'dead', 'alive')) %>% 
#The height column was then changed so that if the observation says 'dead' the value will now be NA, and if it is not 'dead' then it remains as the original numerical value.
  mutate(ht1 = ifelse(status == 'dead', NA, ht1))

# TASK: Annotate the previous lines of code to indicate what each is doing.


# QUESTION: This is a good time to make sure the relevant columns are numeric. 
# Run the str() function on this dataframe. What class is the ht1 column?
str(willowClean3)
#Answer: The ht1 comumn is character

# Let's make the ht1 column numeric. And while we're at it, the columns ht2, 
# cnpy1, and cnpy2 should also be made numeric. We can do so by running the 
# following code:
willowClean4 <- willowClean3 %>% 
  mutate(ht1 = as.numeric(ht1),
         ht2 = as.numeric(ht2),
         cnpy1 = as.numeric(cnpy1),
         cnpy2 = as.numeric(cnpy1))

# TASK: Run the str() function again to view the classes for each column in 
# willowClean4. Did we succeed in making the columns we wanted into numeric 
# classes?
str(willowClean3)
#Answer: No we did not succeed :(

# %in% is another powerful function! With %in% we can use logical statements on 
# a whole bunch of stuff at once, instead of making a billion ifelse statements. 
# Let's try it out to fix our second problem, where willow_ID also contains info 
# about when the seedling was planted. Run the following lines of code:
willowClean5 <- willowClean4 %>% 
  mutate(year = ifelse(willow_ID %in% c("A", "B", "C"), 2006, 2007))

# QUESTION: Based on the lines of code above, what can you conclude about willow 
# seedlings with identifiers that were letters versus numbers? That is, what 
# year were willow seedlings that were identified with letters planted? What year 
# were willow seedlings that were identified with numbers planted?
#Answer: Based off of the ifelse it appears that seedlings labled as A, B, or C were planted in 2006, and seedlings labled as numbers were planted in 2007.


# ---------------------------------------------------------- #
### PART 2.5: RELATIONAL DATA                             ####
# ---------------------------------------------------------- #]
# Final problem! Multiple types of observational units are stored in the same 
# table. We have information about each plot's treatments AND information about 
# willow growth in a single table. We'll fix this by making a relational database. 
# To do so, we'll need to make two separate dataframes. We can call one plotInfo 
# and the other willowData.

# QUESTION: What columns would go in each of our two relational databases?

# Let's do it! Run the following code:
plotInfo <- willowClean5 %>%
  select(block:temp) %>%
  unique()

willowData <- willowClean5 %>%
  select(block, plot, willow_ID:year)

# It might seem trivial to have this be a relational database, but it's super 
# useful for larger and more complicated datasets.

# TASK: Write code to join these two dataframes back together into a new 
# dataframe called willowDataTrt using the left_join() function.


# ON YOUR OWN: There are so many ways to join databases! Think through when you 
# might want to use each type. We will practice more with joining data in the 
# coming weeks.


# ---------------------------------------------------------- #
### PART 2.6: PRACTICING YOUR SKILLS                      ####
# ---------------------------------------------------------- #

# Let's go back to the data of leaf carbon and nitrogen percentages from a 
# nitrogen addition experiment in a grassland in Minnesota.

# TASK: Perform the following steps in one workflow (i.e., using pipes):
# (1) Create a dataframe called cdr and load the .csv file 
# 'e001_Plant aboveground biomass carbon and nitrogen.csv' into it.
# (2) Rename our last two columns that were originally '% Carbon' and 
# '% Nitrogen' in our csv file. Make the new names 'C' and 'N', respectively.
# (3) Remove any observations that were not obtained from Strips 1 or 2 using an 
#     %in% statement.
# (4) pivot_longer the C and N data so that there is one column called element 
#     that contains C or N and another column called percentage that contains 
#     the values of either %C or %N.
# (5) group_by() Date, Plot, NTrt, Species, Field, and Strip and then use the 
#     summarize() function to calculate the mean value of the percentage column 
#     for each group. Store the mean values in a column called 'percentage_mean'. 
#     Don't forget to ungroup at the end!
# (6) pivot_wider so that the values of percentage_mean are contained in 
#     different columns


# ---------------------------------------------------------- #
### PART 3.0: SUBMIT YOUR WORK                            ####
# ---------------------------------------------------------- #

# REMINDER: If you haven't already, make sure to commit and push your code to your branch in GitHub!
