install.packages("tidyverse")
library(stringr)

# First things first, for this question you will need access to a different 
# data set of Baby Names, this one covering births in New York City from 2011 to
# 2021. The relevant .csv is located at the following link.

# https://data.cityofnewyork.us/Health/Popular-Baby-Names/25th-nujf/about_data

# TASK: As always, place the .csv into your local working directory and create a 
# dataframe using the read.csv function called "NYC_Baby_Names" additionally
# when creating this dataframe, create a pipeline and use the rename function to
# change the columns "Child.s.First.Name" and "Year.of.Birth" to replace the 
# periods with underscores (and remove the period after the d in the first case)
# i.e. Childs_First_Name instead of Child.s.First.Name
# Write the code necessary to do so below, and if necessary check the rename()
# function's help file if you need to refresh yourself on how it works.

NYC_Baby_Names <- read.csv("C:/Users/nsalt/Documents/Popular_Baby_Names.csv") %>%
  rename(Childs_First_Name = Child.s.First.Name) %>%
  rename(Year_of_Birth = Year.of.Birth)

# GOAL: Learn the general functionality of the function str_count()

# On it's most basic level we can use str_count in order to find the number of
# characters in a given string, in evaluating a .csv we will receive an output
# that contains a value for each given cell. 

# OBJECTIVE: Use str_count() in order to find the longest baby name in the 
# entire dataset. To create an object containing a list of values run the 
# following code. We will use the function max() in order to find which value
# is the highest for any given cell.

Name_Length <- str_count(NYC_Baby_Names$Childs_First_Name)
max(Name_Length)

# QUESTION: What does our output look like?
# What is the highest number of characters contained in a given name?

# Of course, str_count() can evaluate the incidence of more specific occurences
# than the total number of characters in any given string. Here we will use
# str_count() in order to find the incidence of a specific string of characters
# "ia" in babys' names by gender.

# TASK: From our dataframe "NYC_Baby_Names", we'll only be looking at the 
# data from the most recent year, that being 2021. Create an additional dataframe
# called "NYC_Baby_Names_2021" using the filter function to limit the year of birth
# to 2021.

NYC_Baby_Names_2021 <- filter(NYC_Baby_Names, Year_of_Birth == "2021")

# In order to do find the difference by gender however we will have to let stringr 
# know what to count, one way to do this is to create a new list of two dataframes, 
# with our previous dataframe split by gender. Run the following line of code in 
# order to do this.

NYC_Baby_Names_2021_List <- split(NYC_Baby_Names_2021,NYC_Baby_Names$Gender)

# Now in order to find the the incidence of a character string in our new dataframe
# we will use the function str_count(). Which can search a given column for 
# occurences of a character or a specified string of characters. In this case
# we will figure out the relative incidences of the string "ia" among male and
# female children born in NYC in 2021 respectively. The code to create a value
# for the output of str_count() is listed below. Run it.

Male_ia <- str_count(NYC_Baby_Names_2021_List[["MALE"]]$Childs_First_Name,"ia")

# QUESTION: What is the total incidences of the string "ia" among male names?
# Do any individual names have more than one instance of the string "ia"?

# Now, this data doesn't tell us much as it exists at the moment, as a list of
# values. In order to measure the total incidence of the string among names,
# we will have to take a sum of "Male_ia", do this by using the sum() function.
# Access the help file for sum if it is unclear and create a new object called
# "Male_ia_Total" which will contain our sum of the incidence.

Male_ia_Total <- sum(Male_ia)

# QUESTION: What is the value of "Male_ia_Total"?

# TASK: We now have half of what we need, as we do not have the data for girls born
# in 2021, so analogous to what we have done for the males, create an object titled
# "Female_ia" which uses str_count() to see how often the string "ia" appears among
# girls' first names. Then sum this data in order to have a total count.

Female_ia <- str_count(NYC_Baby_Names_2021_List[["FEMALE"]]$Childs_First_Name,"ia")

Female_ia_Total <- sum(Female_ia)

# QUESTION: How many female names in 2021 contained the string "ia"?

# An additional thing that str_count() allows us to do is to count characters
# in a string, but excluding some characters, for instance we could count the
# number of characters in each male name in 2021 excluding any vowels
# by running the following code.

Male_Vowelless <- str_count(NYC_Baby_Names_2021_List[["MALE"]]$Childs_First_Name,pattern="[^aeiouAEIOU]")

# QUESTION: What do you think the ^ signifies in this variant of str_count?
# Why do you think that an upper and lower case variant of each vowel is included?

