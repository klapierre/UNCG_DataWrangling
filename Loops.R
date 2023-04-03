#Loops, quite simply, loop! When a loop is run in R (or even other programming
#languages!) a block of code is run again and again, often until a specified 
#condition is met. Each time the code within a loop is run, it is refereed to as 
#an iteration.

#Loops are useful for quickly performing mundane tasks that would otherwise 
#require manual completion. 

#Different loops are useful for different scenarios. Using loops successfully 
#requires recognizing when to use different loops types. Throughout this
#assignment, we will cover three major types of loops in R: "For Loops", "While
#Loops" and "Repeat Loops". 

#For Loops: A for loop repeats a given task for defined number of times.

#While Loops: A while loop keeps repeating a block of code until a certain
#logical parameter is met. Example: While x is less than 3, perform action y.

#Repeat Loops: Similar to while loop but requires a break, or stop to prevent
#the loop from running forever. Example: Until 10 iterations, perform action y. 

#For Loops 
#Description (Lowie)

# A for loop applies a set of operations over a collection of objects (list, vector, matrix, or data frame)
# repeated a defined number of times. The number of iterations are known in advance. 

#Example (Mason)

#Create a vector of numbers 1 through 5, and
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

#Do it yourself 
# 1) Load in the "iris" data set built into R. 
# Name the data frame "iris_loop"
# 2) Set up your for loop with the parameters to
# use any integer from 1 through the number of columns
# within the data frame (Look into ncol functions if unsure)
# 3) Within curly brackets, set the following logical if-conditions:
#    a) Make it so the function returns a "TRUE" statement if certain
# conditions are met (Look into grepl())
# b) Select the columns within the "iris_loop" data frame and all integers 
# (Remember your brackets!)
# c) Subset another curly bracket pair within the if condition.
# Inside this curly bracket subset, set up a logical condition: 
#  1000+separated integers (Commas will be your friend). Make sure this condition is
# saved back into the "iris_loop" data frame.
# 4) Make sure to close out all curly brackets to complete the loop.


#While Loops
#Description (Mason)
#A while loop is a control flow statement that allows you to repeatedly execute a block of code as long as a certain condition is met.
#The condition is a logical expression that is evaluated before each iteration of the loop. If the condition is TRUE, 
# the code inside the loop is executed, and then the condition is evaluated again. This process continues until the condition becomes FALSE, 
# at which point the loop terminates and execution continues with the code following the loop.

#Next
# Within While Loops, if you wish to skip a current loop and go onto the next
# iteration, you can use the "next" argument within the function. Consider the 
# following example:
x<-20     # Here we set the length of our variable. 
while (x) {x <- x - 1 # We set our conditions in which x will be equal to x-1
  if (x%%2 != 0) # A further condition is set in which x is divided by 2 if not equal to 0
    next #This tells the while loop to skip any odd numbers
  print(x)} # This prints x after it has gone through the loop

#QUESTION: What happens if you change !=0 to !=1?



#Example 1 (Zachary)

#Let's try an example with numbers!

x <- 1 #Stores 1 in the x variable.
while (x < 6) { #Start of the while loop. While x is less than 6, perform some action.
  print(x) #In this case, our action is printing x
  x = x+1 #Adds one to x each loop.
}

#Example 2

#We can use this to label samples

# Let's build a sample data frame.
Samples_Without_ID <- c("Frog", "Cool Frog", "The Coolest Frog","Cute Frog", "Very Cute Frog", "Strong Frog", "Very Strong Frog")
Samples_Without_ID1 <- data.frame(samples = Samples_Without_ID)  #Stores as a data frame.

#Creates length 7 character vector. 
SampleID <- character(7)

x <- 0 #stores 0 into a variable called x.
while (x < 7) { #Creates a while loop that is valid while x is less than 7.
  x <- x + 1 #Adds 1 to the value of x for each iteration of the while loop.
  SampleID[x] <- paste("Sample#", x, sep = "") #Pastes together the character "Sample#" with the variable x.
                                     #This gives an outputs of "Sample1, Sample2, Sample3, etc.)
}

SampleID <- data.frame(SampleID) #Stores as a data frame.

View(SampleID) #Let's check it out!

#Great! Now we want to label our frogs in the Samples_Without_ID1 data frame.  

Samples_With_Label <- cbind(SampleID, Samples_Without_ID1)


#Do it yourself (Lowie)




#Repeat Loops
#Description (William)
#Break (Mason)
#Example (Lowie)
#Do it yourself (Zachary)

#Let's try it on your own!

#Create a repeat loop that does the following: 
#1) Stores 1 in the variable y.
#2) prints y for iteration of the loop. 
#3) Increase y by .7 each iteration. 
#4) Set a break to terminate the loop when y is greater than 14
#5) Print "Y is big now!" when Y is greater than 14. 




#DUE: APRIL 5TH

#Final 
#Nested loops within For Loops 
#Description of nested loops  (Zachary)
#Example (William)
#Do it yourself with a dataset (Mason)


#DUE: APRIL 8TH