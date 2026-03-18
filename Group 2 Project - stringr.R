## Group 2 (stringr) Project Test

# Test
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
#or equal to 6. Name this new dataframe "LongbabyNames".

#The function "str_pad" is used to pad out strings to make their lengths or 
#widths consistent. In this context, "width" refers to display width, the 
#amount of space the characters actually take on the screen. Here, we'll focus
#on length. Run the following code:

strlengthtest2 <- str_pad(strlengthtest, 15, "left", pad= " ", use_width = FALSE)

#QUESTION: Dissect the code above. What is the purpose of each part of it?

#TASK: Run str_length on our new vector. Did we successfully make all the lengths
#consistent?

#"str_trim" essentially reverses what we did with str_pad; it removes white
#space from strings. Run this code:

strlengthtrimmed <- str_trim(strlengthtest2)

#QUESTION: What is a possible practical application of the str_pad and str_trim
#functions?

