##Before beginning: Make sure to pull any changes and work under your own personal branch!

##Make sure to load the tidyverse package
library(tidyverse)

##Begin by installing the babynames packages using the code below.
install.packages("babynames")

##Then load the library.
library(babynames)

##Save the data to its own dataset called babyNames.
babyNames <- babynames

##Load the stringr package.
library(stringr)
##This package is also part of tidyverse, so you can also load it by just loading
##tidyverse. 



#-----------------------------------------#
#### Part 1.1: MANAGE LENGTHS
#-----------------------------------------#

##The "str_length" function is a simple function that can tell you the length, in
##characters, of a string. 
##Run the following code to create an object we can measure with this function:

strlengthtest <- c("This", "is", "to", "test", "stringr", "length", "functions!")

##TASK: using str_length, determine the amount of characters in each string. If
##you need help, check the help file for this function.

str_length(strlengthtest)

##The str_length function is useful if we only want to see strings of a certain 
##character count. It can be combined with the filter function to accomplish this
##in a dataframe.Suppose we want to pick a baby name, but only want names of a 
##specific length. For example, let's say we want a name with 6 or more characters.

##TASK: Use your knowledge of the filter function to create a new dataframe using
##the "babyNames" dataframe which only contains names with a length greater than
##or equal to 6. Name this new dataframe "LongbabyNames". (Note: you will need
##to load the dplyr package to use the filter function.)

LongbabyNames <- babyNames %>%
  filter(str_length(name) >= 6)

##The function "str_pad" is used to pad out strings to make their lengths or 
##widths consistent. In this context, "width" refers to display width, the 
##amount of space the characters actually take on the screen. Here, we'll focus
##on length. Run the following code:

strlengthtest2 <- str_pad(strlengthtest, 15, "left", pad= " ", use_width = FALSE)

##QUESTION: Dissect the code above. What is the purpose of each argument in it?

##strlengthtest = the vector being changed
##15 = makes each string length 15 characters
##"left" = adds padding on the left side
##pad = " " = uses spaces as the padding character
##use_width = FALSE = uses character length, not display width

##TASK: Run str_length on our new vector. Did we successfully make all the lengths
##consistent?

str_length(strlengthtest2)

##"str_trim" essentially reverses what we did with str_pad; it removes white
##space from strings. Run this code:

strlengthtrimmed <- str_trim(strlengthtest2)

##QUESTION: What is a possible practical application of the str_pad and str_trim
##functions?

##Cleaning text to have it line up the way you want, remove spaces, trim things up.

##The final length management function we will learn is "str_trunc". This function
##also serves to make string lengths consistent, but it does this by chopping off
##portions of any strings that are too long and replacing them with ellipsis. Run
##the following code.

str_trunc(strlengthtest, 4)

##QUESTION: How long is each string in the vector now?

##AT MOST 4 characters long

##TASK: Write code to create a new dataframe called "babyNamesTrunc". In this 
##dataframe, truncate the "name" column so that each string is at most 5 
##characters. HINT: The mutate function will be useful here.

babyNamesTrunc <- babyNames %>%
  mutate(name = str_trunc(name, 5))

#-----------------------------------------#
#### PART 1.2: CHANGING CASE
#-----------------------------------------#

## Sometimes we find our character values aren't synchronized to one format, so we have to modify names individually. However, with these specific stringr functions involving case changes, we can unify character values in one step. 

## TASK: Let's start by identifying some fundamental functions that we can use. Run the code below to create a set of character values.

case_names <- c("layne staley", "JERRY CANTRELL", "MIKE inez", "SeAn KiNnEy")

## TASK: Run the following seven functions, and answer the question at the end of the list of functions either during or after this process.

str_to_upper(case_names)

str_to_lower(case_names)

str_to_title(case_names)

str_to_sentence(case_names)

str_to_camel(case_names)

str_to_snake(case_names)

str_to_kebab(case_names)

## QUESTION: What happened to the case_names values in reference to each function that you ran?

##str_to_upper() makes everything uppercase
##str_to_lower() makes everything lowercase
##str_to_title() capitalizes the first letter of each word
##str_to_sentence() makes it look like a sentence, mainly first letter capitalized
##str_to_camel() changes names to camelCase
##str_to_snake() changes spaces to underscores and lowercase words
##str_to_kebab() changes spaces to dashes and lowercase words

## When just doing the camel, snake, and kebab functions, the last name came out weird, right? Let's fix that.

## TASK: Put the uppercase function within the camel function and run the code. Then, instead of the uppercase function, put the lowercase function within the camel function and run the code.

str_to_camel(str_to_upper(case_names))
str_to_camel(str_to_lower(case_names))

## QUESTION: What do you notice about the two results?

##lower function result is cleaner

## QUESTION: Since the last name in case_names had problems with the camel, snake, and kebab functions, is it possible to also fix the name with the snake and kebab functions as we did with the camel function in the previous task?

##Yes

## Now that you've completed some examples using case_names, lets use our babyNames data frame to modify something a little more complex.

## TASK: Using the babyNames data frame, complete the following:
         #(1) Create a new data frame named uppercaseBabyNames.
         #(2) Select by name and year.
         #(3) Mutate the name column to be labelled name_upper and use the                   uppercase function on the name column.
         #(4) Select the name column once again, removing it, leaving only the               name_upper column.

uppercaseBabyNames <- babyNames %>%
  select(name, year) %>%
  mutate(name_upper = str_to_upper(name)) %>%
  select(-name)

## TASK: Using the babyNames data frame, complete the following:
        #(1) Create a new data frame named oldBabyNames.
        #(2) Filter by the year 1880
        #(3) Mutate the name column to be labelled name_title and use the title             function on the name column.
        #(4) Select the name column once again, removing it, leaving only the               name_title column.


oldBabyNames <- babyNames %>%
  filter(year == 1880) %>%
  mutate(name_title = str_to_title(name)) %>%
  select(-name)

## Good work! You've learned how to use some case changing functions within simple values as well as data frames!

## These examples might not be the most practical, but the option to organize entire data frames within simple functions justifies its use in a more practical sense.

#-----------------------------------------#
#### Part 1.3: DETECT MATCHES
#-----------------------------------------#

## Additionally, stringr can be used to detect specified character patterns in 
## strings.

## Note: To discover how this works, we will use a list of fruits. This vector is
## already built into the stringr package so you do not have to worry about 
## creating it. Begin by calling this vector.
fruit

## If we wanted to know if there are any fruits in the fruit vector that contain
## the letter "q", we could use the str_detect function, which will return a 
## logical statement for each element in the fruit list. Try running the following code.
str_detect(fruit, "q")

## As you can see, this function returns a true for each fruit that contains the 
## letter "q", and a false for each fruit that does not. If we needed to know the
## position of each fruit that returns a true statement, we could use the str_which function.
str_which(fruit, "q")

## QUESTION: What is the result of running this code?

##Gives the position numbers of the fruits that have q in them.

## Not only can we use the str_detect function to detect individual characters in
## a string, but we can also use it to detect larger patterns of characters. For 
## example, if we wanted to know if there are fruits that contain the word "melon" 
## we could run this code.
str_detect(fruit,"melon")

## In addition, str_detect can be used to find consecutive double letters by 
## using "(.)\\1" as the pattern! The "(.)" portion signifies any letter, 
## and the "\\1" portion refers to a repeat of the previous letter.

## TASK: Try using the str_detect function with "(.)\\1" as the pattern to find 
## out if there are any fruits containing double letters.

str_detect(fruit, "(.)\\1")

## Another interesting function is str_count.
## TASK: Run the following code to create a smaller vector containing only the
## first five fruits in the original fruit vector.
fivefruits <- fruit[1:5]
## TASK: Now run this one.
str_count(fivefruits, "a")

## QUESTION: What does the str_count function do? If needed, use ?str_count.

##Counts how many times something shows up

## To get the actual position of the first occurrence of the letter "a" in each of
## these five fruits, we can run the following code.
str_locate(fivefruits, "a")

## Note: The output of this code gives two columns per element (a start and end 
## column). In the case of this specific code, we only looked for one letter so 
## the starting and ending position of each match looks the same. If we told R to 
## locate more than one letter (such as "er"), the start and end columns would not match.

## QUESTION: Notice that the fifth fruit returns NAs. Why do you think this is?

##Has no "a"

## This tells us only the first occurrence of the letter "a" in each of the five 
## fruits. However, if we wanted to locate the positions of all of the matches 
## for the letter "a" in each of these five fruits, we could use str_locate_all function.
str_locate_all(fivefruits, "a")

## QUESTION: Which positions contain "a" in the fourth fruit in our vector? 
## (Hint: There are three.)

##2,4,6

## QUESTION: Other functions that are similar to str_detect are str_starts and 
## str_ends. What do you think each of these does?

##Checks whether a string STARTS with what you are looking for and the second one checks if it ENDS with what you are looking for.

## TASK: Use the knowledge you've learned in this section to create a code that gives 
## a count of how many fruits in the fruit vector contain the word "berry". (Hint:
## You will need to use a dplyr function.)

fruit_berry_count <- tibble(fruit = fruit) %>%
  filter(str_detect(fruit, "berry")) %>%
  count()

fruit_berry_count

## QUESTION: How many fruits containing the word "berry" are there in the fruit vector?

##14

## Great job! You've learned how to use stringr to detect, count, and locate 
## pattern matches in strings of characters. One way that these functions could 
## be practical is combining them with the filter function to filter a column in 
## a data frame by only those containing a certain letter or string of letters.

#-------------------------------------------------------#
# PART 1.4: COUNTING CHARACTERS
#-------------------------------------------------------#

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

# QUESTION: Do any individual names have more than one instance of the string "ia"?

# Now, this data doesn't tell us much as it exists at the moment, as a list of
# values. In order to measure the total incidence of the string among names,
# we will have to take a sum of "Male_ia", do this by using the sum() function.
# Access the help file for sum if it is unclear and create a new object called
# "Male_ia_Total" which will contain our sum of the incidence.



# QUESTION: What is the value of "Male_ia_Total"?

# TASK: We now have half of what we need, as we do not have the data for girls born
# in 2021, so analogous to what we have done for the males, create an object titled
# "Female_ia" which uses str_count() to see how often the string "ia" appears among
# girls' first names. Then sum this data in order to have a total count.



# QUESTION: How many female names in 2021 contained the string "ia"?

# An additional thing that str_count() allows us to do is to count characters
# in a string, but excluding some characters, for instance we could count the
# number of characters in each male name in 2021 excluding any vowels
# by running the following code.

Male_Vowelless <- str_count(NYC_Baby_Names_2021_List[["MALE"]]$Childs_First_Name,pattern="[^aeiouAEIOU]")

# QUESTION: What do you think the ^ signifies in this variant of str_count?
# Why do you think that an upper and lower case variant of each vowel is included?

#-------------------------------------------------------#
# PART 1.5: MODIFYING VECTORS
#-------------------------------------------------------#

## Stringr also has various functions that can be used to modify
## character vectors.

## So imagine that you want to list out some taco ingredients.
## We can turn these into a vector and edit the vector with stringr.

## TASK: Create the following vector with stringr to list out your taco ingredients.

taco_ingredients <- str_c("tortilla","beans", "lettuce", "guacamole", "cheese", "salsa")

## QUESTION: Print the vector below. Is it legible? Why or why not?


## TASK: Now make the same vector, but formatted as a list (as in with ", "
## after each word).


## TASK: Not everyone likes cilantro, so use the replace function to
## replace it with guacamole and save it as taco_ingredients_2


## TASK: Now, it appears that we have forgotten to include meat in the list.
## Add meat to the list after the tortilla, but before the beans.


## TASK: Now remove one ingredient of choice without replacing it with anything.
## Save this as taco_ingredients_3 without any empty strings.

