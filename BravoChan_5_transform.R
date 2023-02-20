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

# Let's go back to our dataset of water temperature in Calispell Creek and 
#its tributaries
# from eastern Washington State.

# TASK: Read in the CalispellCreekandTributaryTemperatures.csv file and assign
#it to a dataframe named streamTemp.
# HINT: Check last week's assignment if you forget how to read data into R.
streamTemp <- read.csv("CalispellCreekandTributaryTemperatures.csv", 
                       stringsAsFactors=F) %>%
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
#There are date, time, temperatures of three locations. It reaches a maximum 
#number of 200 observations.

# QUESTION: How does this number compare to the number of observations listed 
#by the dataframe in the R environment tab?
#It is clearly different from the dataframe information listed in the R environment
#window. There, the number of observations listed is 61,100.

# QUESTION: Based on your previous answers, what do you think the length function does?

length(streamTemp)

# It can be a bit tedious to type out all the column names and the length function
# multiple times. The across() function within the summarize() step can help us to 
# identify multiple columns to summarize the data for. Try running the following code:
streamTempLength <- streamTemp %>% #creating a new dataframe from the original dataset in #streamTemp
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), #using the summarize #function to call all columns of interest for this analysis
                   .fns=length)) #ending with the function to be applied to the data

# TASK: Using comments in the code above, describe what each line is doing.
#done in the example above

# We might also want to know some other statistics about our data, such as the max,
# min, and mean values. The across() function is useful for this too, by letting
# you set multiple functions to summarize each column by. Try running the following code:
streamTempSummary <- streamTemp %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=list(maximum=max, mean=mean, minimim=min)))

# TASK: Write code to view the column names of the streamTempSummary dataframe.
colnames(streamTempSummary)

# QUESTION: How does R know what to name each column when we use the summarize function above?
#First we used summarize across to give Rstudio an orientation to look for column names. The column names were then named using a combination of the original column name and the function name. For example, when we summarized the 'calispell' column using max, mean, and min, the resulting columns were calispell_maximum, calispell_mean, and calispell_minimim, respectively. 

# QUESTION: What values do you see for the columns when you open up the dataframe streamTempSummary? When I load the file from R Environment, the column values are all NA
# Why do you think this is? Because there are observations with missing data, the data hasn't been cleaned out so it returns an immediate NA.

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
#Now the dataframe is populated with the max, mean, and min values. The line of 
#code that removed NA cells is -> na.rm=T))

# QUESTION: What happened to the column we created in the beginning called data_type?
# Where did the date and time columns go? Those columns stayed in the original
#dataframe (streamTemp), since they weren't classified as temperature. 


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
streamTempMDY <- streamTemp %>%
  separate(col = Date, into = c("month", "day", "year"), sep = "/")
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
# each stream? One for each month.

# QUESTION: In your own words, what do you think the group_by() function does when used
# before the summarize() function? It groups different dataframes by the specified columns, then it summarizes the data.

# We can also group by multiple columns. Try running the following code:
streamTempMeans <- streamTempMDY %>% 
  group_by(month, year) %>% 
  summarize(across(.cols=c('calispell', 'smalle', 'winchester'), 
                   .fns=mean,
                   na.rm=T)) %>% 
  ungroup()

# QUESTION: What columns did we group by to get our new means? The columns for mean values of each stream.
#What does the new dataframe show? All mean temperatures for each site, grouped by month and year, including the empty (non-number) cells.


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
print(paste("Avoid flying from", minDelayAirport, "to get the shortest delays."))

# QUESTION: Which airport should you avoid if you want the shortest delays?
#Avoid LGA airport.

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
#4:20 

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
  arrange(mean_arr_delay)  # Optional: Sort by mean_arr_delay in ascending order

worst_month_airport <- monthlyDelaySummary %>%
  filter(mean_arr_delay == max(mean_arr_delay)) %>%
  select(month, origin)
worst_month_airport

# QUESTION: Which month and airport has the longest mean delay?
#EWR airport

# ---------------------------------------------------------- #
### PART 2.0: INTRO TO TIDY DATA                          ####
# ---------------------------------------------------------- #

# QUESTION: What are three characteristics of tidy data?
#Tidy data has standards (preset organization mode) where each variable is assigned to a column, each observation to a row, and each cell stands for a single measurement.

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
# HINT: Compare the csv file on your computer and the data frame that you loaded into R.
#"skip=10" is an argument that tell rStudio to skip the first 10 lines(rows) of text so the data frame includes only the data to be manipulated.

# ---------------------------------------------------------- #
### PART 2.1: FILL MISSING DATA                           ####
# ---------------------------------------------------------- #

# Sometimes when a data source has primarily been used for data entry, missing values indicate that the
# previous value should be carried forward.

# QUESTION: To clean up the willow dataframe, where do we want to fill in values? That is, which columns
# have lots of NAs.
#The columns listing willows that have died during the study's observation

# We can fix our missing value problem using the fill() function (try it by running the following code):
willowFill <- willow %>%
  fill(block:temp)

# QUESTION: What does the code 'block:temp' mean when passed to the fill() function above?
#In the code above, block:temp is a range selector (subsets then fills). It tells the function to fill missing values in all columns of the data frame "willow" that come after the "block" column and before the "temp" column.

# QUESTION: Looking at the dataframe willowFill, describe what happened compared to our initial dataframe.
#The data frame is now more coherent and organized in a table format. It is now much easier to read and understand the data.

# ---------------------------------------------------------- #
### PART 2.2: PIVOT LONGER                                ####
# ---------------------------------------------------------- #

# Another common problem, the column headers are values instead of variable names!
# In this case, the columns w1 through wC are individual willow seedlings that were sampled repeatedly.

# TASK: Write code to indicate the sequence of columns from w1 through wC. 
w_cols <- sort(grep("^w_[0-9]|^w_[A-C]$", colnames(willowFill), value = TRUE))
w_cols

# We can fix this problem using the pivot_longer() function. pivot_longer() takes multiple columns
# and condenses them into just two columns, one that indicates what column the data came from and the other
# that contains the data itself.
# And while we're at it, let's get rid of the 'w' in front of each willow individual number.
# Run the following code:
willowClean <- willowFill %>% #it creates a new data frame for the cleaned up data
  pivot_longer(cols = w_1:w_C, #selects columns to be pivoted
               names_to = "willow_id", #gives the column containing willow ID a name
               values_to = "value") %>% #names the column containing a value
  separate(col = willow_id, #separates the willow_id column
           into = c("remove", "willow_ID"), #splits "willow_ID" into two columns
           sep = "_") %>% #uses the "_" character as a divider
  select(-remove) #it removes the first column (empty) created

# TASK: Annotate (add comments) the code above to indicate what each line does.


# ---------------------------------------------------------- #
### PART 2.3: PIVOT WIDER                                 ####
# ---------------------------------------------------------- #

# Yikes, another common problem, the variables are stored in both rows and columns!

# QUESTION: What column contains the labels that tell us there are multiple variables stored
# in one column? #the 'variable' column.
#What column contains the corresponding date for these variables?
#The only dates I found are in the commentary section (10 first lines) which we have not included in our data frame.

# Good news, we can fix this problem with the complementary function to pivot_longer().
# This time we will use the pivot_wider() function to turn one column into multiple.
willowCleaner  <- willowClean %>% #creates a new data frame for the cleaner data
  pivot_wider(names_from = variable, #reshapes the data into wide format, here data is reorganized so that the rows in the column 'variable', become column names
              values_from = value) #creates a 'vale' column and fills its cells.


# TASK: Take a look at our new dataframe. How does it differ from the previous?
#The data is now much better organized, with willows having unique identifiers and now a proper variable. Also the measured variables, are properly designated in columns. 
# Annotate (add comments) the code above to indicate what each line does.
#Done above

# ---------------------------------------------------------- #
### PART 2.4: IF ELSE                                     ####
# ---------------------------------------------------------- #

# Sigh, another major issue: multiple variables are stored in one column again!
# This occurs in the ht1 (height 1) column, where there is information about the plant status
# (whether it is dead or alive) AND the height for only the individuals that were alive.
# And then it is a problem again in the willow_ID column, which tells us information about when each 
# seedling was planted.

# TASK: Verbally describe how you would want to change this problem (i.e., pseudocode).
#Create new columns with descriptive names that correspond to the types of information stored in the original column.
#For the ht1 column, split the column into two new columns: one containing information about the plant status (alive/dead), and one containing information about the height of the plant.
#For the willow_ID column, split the column into two new columns: one containing information about the date the seedling was planted, and one containing an unique identifier for the individual seedling.
#Copy the data from the original column into the appropriate new columns.
#Verify that the data in the new columns are accurate, consistent with the original data, and properly formatted.
#Remove original columns if it is no longer needed.

# ifelse() is a very powerful function that helps us with this problem!

# TASK: Look at the ifelse help file and describe in your own words the ordering of the syntax.
#ifelse syntax order is the following: object to be subjected to test, yes value for logical test, and finally, no value for logical test.

# logical statement, if the statement is TRUE then use the yes value provides, otherwise use the no value.

# We can nest the ifelse() function within a mutate() function to create a new column that contains
# one entry if the logical statement we provide is TRUE and another if the logical statement is FALSE.
# Run the following code to try it out to help fix our first problem (ht1 column has information on 
# both plant status and actual height values).
willowClean3 <- willowClean2 %>% #it creates a new data frame for the cleaned up data
  mutate(status = ifelse(ht1 == 'dead', 'dead', 'alive')) %>% #it creates a new column 'status' within the new data frame
  mutate(ht1 = ifelse(status == 'dead', NA, ht1)) #it replaces the value 'dead' with 'NA' in the new ht1 column

# TASK: Annotate the previous lines of code to indicate what each is doing.
#done above

# QUESTION: This is a good time to make sure the relevant columns are numeric. Run the str() function
# on this dataframe. What class is the ht1 column? 
str(willowClean3)
#the type of ht1 is characters

# Let's make the ht1 column numeric. And while we're at it, the columns ht2, cnpy1, and cnpy2 should also
# be made numeric. We can do so by running the following code:
willowClean4 <- willowClean3 %>% 
  mutate(ht1 = as.numeric(ht1),
         ht2 = as.numeric(ht2),
         cnpy1 = as.numeric(cnpy1),
         cnpy2 = as.numeric(cnpy1))

# TASK: Run the str() function again to view the classes for each column in willowClean4. Did we
# succeed in making the columns we wanted into numeric classes?
str(willowClean4)
#yes, these columns are now numeric

# %in% is another powerful function! With %in% we can use logical statements on a whole bunch of stuff at
# once, instead of making a billion ifelse statements. Let's try it out to fix our second problem,
# where willow_ID also contains info about when the seedling was planted. Run the following lines of code:
willowClean5 <- willowClean4 %>% 
  mutate(year = ifelse(willow_ID %in% c("A", "B", "C"), 2006, 2007))

# QUESTION: Based on the lines of code above, what can you conclude about willow seedlings with identifiers
# that were letters versus numbers? 2006 and 2007, respectively. 
#That is, what year were willow seedlings that were identified with letters
# planted? 2006
#What year were willow seedlings that were identified with numbers planted? 2007


# ---------------------------------------------------------- #
### PART 2.5: RELATIONAL DATA                             ####
# ---------------------------------------------------------- #]
# Final problem! Multiple types of observational units are stored in the same table. We have information
# about each plot's treatments AND information about willow growth in a single table.
# We'll fix this by making a relational database. To do so, we'll need to make two separate dataframes.
# We can call one plotInfo and the other willowData.

# QUESTION: What columns would go in each of our two relational databases?
#plotInfo: block, plot, code, snow, n, temp
#willoData:
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
willowDataTrt <- left_join(willowData, plotInfo, by = "plot")

# ON YOUR OWN: There are so many ways to join databases! Think through when you might want to use each type.
# We will practice more with joining data in the coming weeks.
willowDataTrt2 <- inner_join(willowData, plotInfo, by = "plot")
willowDataTrt3 <- left_join(willowData, plotInfo, by = "plot")
willowDataTrt4 <- right_join(willowData, plotInfo, by = "plot")
willowDataTrt5 <- full_join(willowData, plotInfo, by = "plot")


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
cdr <- read.csv("e001_Plant aboveground biomass carbon and nitrogen.csv") %>%
  rename(C = '% Carbon', N = '% Nitrogen') %>%
  filter(Field %in% c("Strip 1", "Strip 2")) %>%
  pivot_longer(cols = c(C, N), names_to = "element", values_to = "percentage") %>%
  group_by(Date, Plot, NTrt, Species, Field, Strip) %>%
  summarize(percentage_mean = mean(percentage)) %>%
  ungroup() %>%
  pivot_wider(names_from = Field, values_from = percentage_mean)

# ---------------------------------------------------------- #
### PART 3.0: SUBMIT YOUR WORK                            ####
# ---------------------------------------------------------- #

# REMINDER: If you haven't already, make sure to commit and push your code to your branch in GitHub!
