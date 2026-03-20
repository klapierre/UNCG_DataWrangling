#Before beginning: Make sure to pull any changes and work under your own personal branch!

#Make sure to load the tidyverse package
library(tidyverse)

#Begin by installing the babynames packages using the code below.
install.packages("babynames")

#Then load the library.
library(babynames)

#Save the data to its own dataset called babyNames.
babyNames <- babynames

#Load the stringr package.
library(stringr)
#This package is also part of tidyverse, so you can also load it by just loading
#tidyverse. 



#MANAGING LENGTHS

#The "str_length" function is a simple function that can tell you the length, in
#characters, of a string. 
#Run the following code to create an object we can measure with this function:

strlengthtest <- c("This", "is", "to", "test", "stringr", "length", "functions!")

#TASK: using str_length, determine the amount of characters in each string. If
#you need help, check the help file for this function.

#The str_length function is useful if we only want to see strings of a certain 
#character count. It can be combined with the filter function to accomplish this
#in a dataframe.Suppose we want to pick a baby name, but only want names of a 
#specific length. For example, let's say we want a name with 6 or more characters.

#TASK: Use your knowledge of the filter function to create a new dataframe using
#the "babyNames" dataframe which only contains names with a length greater than
#or equal to 6. Name this new dataframe "LongbabyNames". (Note: you will need
#to load the dplyr package to use the filter function.)

#The function "str_pad" is used to pad out strings to make their lengths or 
#widths consistent. In this context, "width" refers to display width, the 
#amount of space the characters actually take on the screen. Here, we'll focus
#on length. Run the following code:

strlengthtest2 <- str_pad(strlengthtest, 15, "left", pad= " ", use_width = FALSE)

#QUESTION: Dissect the code above. What is the purpose of each argument in it?

#TASK: Run str_length on our new vector. Did we successfully make all the lengths
#consistent?

#"str_trim" essentially reverses what we did with str_pad; it removes white
#space from strings. Run this code:

strlengthtrimmed <- str_trim(strlengthtest2)

#QUESTION: What is a possible practical application of the str_pad and str_trim
#functions?

#The final length management function we will learn is "str_trunc". This function
#also serves to make string lengths consistent, but it does this by chopping off
#portions of any strings that are too long and replacing them with ellipsis. Run
#the following code.

str_trunc(strlengthtest, 4)

#QUESTION: How long is each string in the vector now?

#TASK: Write code to create a new dataframe called "babyNamesTrunc". In this 
#dataframe, truncate the "name" column so that each string is at most 5 
#characters. HINT: The mutate function will be useful here.



###CHANGING CASE###

# Sometimes we find our character values aren't synchronized to one format, so we have to modify names individually. However, with these specific stringr functions involving case changes, we can unify character values in one step. 

#TASK: Let's start by identifying some fundamental functions that we can use. Run the code below to create a set of character values.

case_names <- c("layne staley", "JERRY CANTRELL", "MIKE inez", "SeAn KiNnEy")

#TASK: Run the following functions, and answer the question at the end of the list of functions either during or after this process.

str_to_upper(case_names)

str_to_lower(case_names)

str_to_title(case_names)

str_to_sentence(case_names)

str_to_camel(case_names)

str_to_snake(case_names)

str_to_kebab(case_names)

# QUESTION: What happened to the case_names values in reference to each function that you ran?