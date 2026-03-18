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

#MANAGING LENGTHS

#The "str_length" function is a simple function that can tell you the length, in
#characters, of a string. 
#Run the following code to create an object we can measure with this function:

strlengthtest <- c("This", "is", "to", "test", "stringr", "length", "functions!")

#TASK: using str_length, determine the amount of characters in each string. If
#you need help, check the help file for this function.

#The str_length function is useful if we only want to see strings of a certain 
#character count. It can be combined with the filter function to accomplish this.
#Suppose we want to pick a baby name, but only want names of a specific length.
#For example, let's say we want a name with 6 or more characters.

#TASK: Use your knowledge of the filter function to create a new dataframe using
#the "babyNames" dataframe which only contains names with a length greater than
#or equal to 6. Name this new dataframe "LongbabyNames".