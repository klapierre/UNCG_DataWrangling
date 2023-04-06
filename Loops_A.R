#===============================================================================
# ◯。°。°。°。°。°。°。°。°。°。°。° LOOPS 。°。°。°。°。°。°。°。°。°。°。°◯
#===============================================================================


# Loops, quite simply, loop! When a loop is run in R (or even other programming
# languages!) a block of code is run again and again, often until a specified 
# condition is met. Each time the code within a loop is run, it is refereed to as 
# an iteration.

# Loops are useful for quickly performing mundane tasks that would otherwise 
# require manual completion. 

# Different loops are useful for different scenarios. Using loops successfully 
# requires recognizing when to use different loops types. Throughout this
# assignment, we will cover three major types of loops in R: "For Loops", "While
# Loops" and "Repeat Loops". 

# For Loops: A for loop repeats a given task for defined number of times.

# While Loops: A while loop keeps repeating a block of code until a certain
# logical parameter is met. Example: While x is less than 3, perform action y.

# Repeat Loops: Similar to while loop but requires a break, or stop to prevent
# the loop from running forever. Example: Until 10 iterations, perform action y. 

#===============================================================================
# For Loops 
#===============================================================================

### Description:

# A for loop applies a set of operations over a collection of objects (list, vector, matrix, or data frame)
# repeated a defined number of times. The number of iterations are known in advance. 

### Example:
# Create a vector of numbers 1 through 5, and
# then use a for loop to iterate through each number in the vector and print it to the console. 
# The loop variable i takes on the values 1, 2, 3, 4, and 5, and the print() function is called with each value of i.

# create a vector of numbers
numbers <- c(1, 2, 3, 4, 5)

# create a for loop that prints each number in the vector
for (i in numbers) {
  print(i)
}

# For loops can iterate over a sequence of numbers, in the following example,
# from 1 to 100 and calculates the sum of the numbers. 
# The loop variable i takes on the values 1, 2, 3, ..., 100, and the sum variable is updated on each iteration.

sum <- 0
for (i in 1:100) {
  sum <- sum + i
}
print(sum)


### TASK: 
# Let's look at some flowers!

# ✿¸.•´*¨`*•✿✿•*`¨*`•.¸✿

# 1) Load in the "iris" data set built into R. 
# Name the data frame "iris_loop"

# 2) Set up your For Loop with the parameters to
# use any integer from 1 through the number of columns
# within the data frame (ncol function may be of some assistance)

# 3) Within curly brackets, set the following logical conditions under an "if" function:
#     
#     a) Make it so the function returns a "TRUE" statement if certain
# conditions which we will later establish are met (Grapple with the grepl() function)

#     b) Select the columns within the "iris_loop" data frame and all integers separated by a comma 
# (HINT: [,i] will be the best way to do this)

#     c) Subset another curly bracket pair within the if condition.
#  Inside this secondary curly bracket, set up a logical condition: 
#  1000+separated integers. Make sure this condition is saved back into the "iris_loop" data frame with a "<-"

# 4) Make sure to close out all curly brackets to complete the loop.


library(tidyverse)

iris_loop <- iris

for(i in 1:ncol(iris_loop)) {                              
  if(grepl("Width", colnames(iris_loop)[i])) {             
    iris_loop[ , i] <- iris_loop[ , i] + 1000
    }
}


# Question: What happens if you change the "1000+" to "50+"?
# ANSWER: The amount added to the Width columns changes from x+1000 to x+50


#===============================================================================
# While Loops
#===============================================================================


### Description :
# A while loop is a control flow statement that allows you to repeatedly execute a block of code as long as a certain condition is met.
# The condition is a logical expression that is evaluated before each iteration of the loop. If the condition is TRUE, 
# the code inside the loop is executed, and then the condition is evaluated again. This process continues until the condition becomes FALSE, 
# at which point the loop terminates and execution continues with the code following the loop.


###Next within Loops:
# Within loops, especially While Loops, if you wish to skip a current variable and go onto the next
# iteration, you can use the "next" argument within the function. This can be helpful 
# in ignoring variables that would be messy, useless, and overall just unwanted (:,( poor variable)) 
# Consider the following example:
x<-20     # Here we set the length of our variable. 
while (x) {x <- x - 1 # We set our conditions in which x will be equal to x-1
if (x%%2 != 0) # A further condition is set in which x is divided by 2 if not equal to 0
  next # This tells the while loop to skip any numbers after our conditions set above
print(x)} # This prints x after it has gone through the loop

### QUESTION: Why do we have the argument !=0? What would occur if we changed it to !=1? 
# ANSWER: This change to the argument tells the loop to skip any number not equal to 1
# Instead of printing all even numbers, the loop will print out all odd numbers
# Go ahead and give it a try:
x<-20  
while (x) {x <- x - 1 
if (x%%2 != 0) 
  next 
print(x)}


### Example 1 of While Loops:

# Let's try an example with numbers!

x <- 1 # Stores 1 in the x variable.
while (x < 6) { # Start of the while loop. While x is less than 6, perform some action.
  print(x) #In this case, our action is printing x
  x = x+1 # Adds one to x each loop.
}

### Example 2 of While Loops:

# We can use this to label samples

# Let's build a sample data frame.
Samples_Without_ID <- c("Frog", "Cool Frog", "The Coolest Frog","Cute Frog", "Very Cute Frog", "Strong Frog", "Very Strong Frog")
Samples_Without_ID1 <- data.frame(samples = Samples_Without_ID)  #Stores as a data frame.

# Creates length 7 character vector. 
SampleID <- character(7)

x <- 0 # stores 0 into a variable called x.
while (x < 7) { # Creates a while loop that is valid while x is less than 7.
  x <- x + 1 # Adds 1 to the value of x for each iteration of the while loop.
  SampleID[x] <- paste("Sample#", x, sep = "") # Pastes together the character "Sample#" with the variable x.
  # This gives an outputs of "Sample1, Sample2, Sample3, etc.)
}

SampleID <- data.frame(SampleID) #Stores as a data frame.

View(SampleID) # Let's check it out!

# Great! Now we want to label our frogs in the Samples_Without_ID1 data frame.  

Samples_With_Label <- cbind(SampleID, Samples_Without_ID1)


### TASK:
# Create a while loop which pastes whole numbers from 1 to 10, but exclude printing 3 using the next function.
# output should look like this: 1, 2, 4, 5, 6, 7, 8, 9, 10


#===============================================================================
#Repeat Loops
#===============================================================================

###Description: 
# If we have a large multidimensional data frame and would like to repeat a block of code 
# over and over again across this data frame, it would be best to use a Repeat loop.
# A repeat loop will continuously execute a block of code and logical conditions over a data frame.
# If the logical conditions return "FALSE", the block of code will continue to be repeated 
# over the entire data frame. No output will be given for a "FALSE" return.
# If the logical conditions return "TRUE", an output will be given.
# However, unlike most other loops, even if a "TRUE" condition is met, the repeat loop will not 
# end, and continue to iterate over and over across the data frame.
# The only way for the Repeat loop to end is by giving it a BREAK condition.

### Question: Based on the description above and the description of While loops. 
# How do Repeat and While loops differ? When might it be best to use one rather than the other?
# ANSWER: While loops depend upon the information returning TRUE to continue the loop until a return is FALSE
# The repeat loop depends upon the continuous return of FALSE information, and only gives outputs that are TRUE


### Break: (Mason)
### Example: (Lowie)


### TASK:

# Let's try it on your own!

# Create a repeat loop that does the following: 
#1) Stores 1 in the variable y.
#2) prints y for iteration of the loop. 
#3) Increase y by .7 each iteration. 
#4) Set a break to terminate the loop when y is greater than 14
#5) Print "Y is big now!" when Y is greater than 14. 



#===============================================================================
#Final: Nested Loops within For Loops
#===============================================================================


# Description of nested loops
# Earlier in the course, we used nested ifelse functions. A nested ifeelse function is just
#an ifelse function INSIDE another ifelse function. The same goes for nested loops!

#In a nested loop, we have a loop INSIDE another loop! 

#Nested loops are often used for multideminsion data and allow for more precise
#control of your data. 


### Example of Nested loops:
# While any kind of loop can be nested within other loops, it will be easiest to look at the same two loops nested within each other. Nested loops allow us to look at multidimensional information. 
# A visualization of a real life nested loop would be an analogue clock.
# In this analogy, while visually it may not make the most sense, our outer loop of the clock would be the short hand, which tells the hour on the clock.
# Nested within this outer loop is the inner loop, the long hand of the clock, which tells the minute.
# So hop in your nearest Police Call Box, and let's travel time a bit: 


for (s in 1:12){  # Here we set up our outer loop as "s" to represent our short hand, so this will contain any variable between 1-12 since most analogue clocks use standard time.
  for (l in 01:59) # Now we add in a nested, inner logical condition, which creates a second value "l" for the long hand. This hand will represent our minutes
  {print(paste("The short hand is",s,"And the long hand", l))} # Now we want to print our variables, but paste them together when printed
  } # Close the loops




### TASK: (Mason)

