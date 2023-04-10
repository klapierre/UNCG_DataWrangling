#===============================================================================
# ◯。°。°。°。°。°。°。°。°。°。°。° LOOPS 。°。°。°。°。°。°。°。°。°。°。°◯
#===============================================================================


# Loops, quite simply, loop! When a loop is run in R (or even other programming
# languages!) a block of code is run again and again, often until a specified 
# condition is met. Each time the code within a loop is run, it is referred to as 
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

# A For Loop applies a set of operations over a collection of objects (list, vector, matrix, or data frame)
# repeated a defined number of times. The number of iterations are known in advance. 

### Example:
# Create a vector of numbers 1 through 5, and
# then use a for loop to iterate through each number in the vector and print it to the console. 
# The loop variable i takes on the values 1, 2, 3, 4, and 5, and the print() function is called with each value of i.
library(tidyverse)
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

# ✿¸.•´*¨`*•✿ Let's look at some flowers! ✿•*`¨*`•.¸✿

# 1) Load in the "iris" data set built into R. 
# Name the data frame "iris_loop"
iris_loop<- as.data.frame(iris)
iris_loop
# 2) Set up your For Loop with the parameters to
# use any integer from 1 through the number of columns
# within the data frame (ncol function may be of some assistance)
for (i in incol(iris_loop)) {
}
# 3) Within curly brackets, set the following logical conditions under an "if" function:
for (i in incol(iris_loop)) {
if(grepl("length"))} 
#     a) Make it so the function returns a "TRUE" statement if certain
# conditions which we will later establish are met (Grapple with the grepl() function)
for (i in incol(iris_loop)) {
  if(grepl("length", colnames(iris_loop[i])))  {
    
  }
#     b) Select the columns within the "iris_loop" data frame and all integers separated by a comma 
# (HINT: [,i] will be the best way to do this)
for (i in 1:ncol(iris_loop)) {
    if(grepl("Length", colnames(iris_loop)[i])) {
      iris_loop[,i]<- iris_loop[,i]+1000
      
    }
  }
  
#     c) Subset another curly bracket pair within the if condition.
#  Inside this secondary curly bracket, set up a logical condition: 
#  1000+separated integers. Make sure this condition is saved back into the "iris_loop" data frame with a "<-"
  for (i in 1:ncol(iris_loop)) {
    if(grepl("Length", colnames(iris_loop)[i])) {
      iris_loop[,i]<- iris_loop[,i]+1000
      
    }
  }
# 4) Make sure to close out all curly brackets to complete the loop.

# Question: What happens if you change the "1000+" to "50+"?
  for (i in 1:ncol(iris_loop)) {
    if(grepl("Length", colnames(iris_loop)[i])) {
      iris_loop[,i]<- iris_loop[,i]+50
      
    }
  }
#it added 50 and 1000.  
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
# Go ahead and give it a try:
x<-20  
while (x) {x <- x - 1 
if (x%%2 != 1) 
  next 
print(x)
}
# !=0 makes it start at 0 while !=1 has it start at 1.

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
x <- 0 
while (x < 10)

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
## Repeat is used for a set of code that would be repeated non-stop this would b ehelpful in cases where youwould like to manually stop the repeat. While loops will repeat until a true output is given which will be helpful if you are looking for a specific code. 

### Breaks:
#The Break statement is a way to stop a loop from running before it has finished all its iterations. When the break statement is encountered within a repeat loop, the loop stops running immediately, and the program moves on to the next line of code after the loop. This can be useful if you want to stop a loop based on a certain condition, without having to wait for it to finish all its iterations.

### Example of Repeat Loops: 

# Basic example of Repeat Loop with a conditional break. 
# Without the break statement, repeat loops would continue indefinitely.
i <- 1
repeat {
  print(paste("Loop", i))
  if (i == 3) {
    break
  }
  i <- i + 1
}


# Example of using a repeat loop for 'data processing' and conditional break.
# In this example we will increase the salary of each individual in the dataset
# and store the processed data in a new dataset.

# First let's create a data frame with columns 'ID', 'Name', 'Age', 'Gender', and 'Salary'
my_data <- data.frame(
  ID = c(1, 2, 3, 4, 5),
  Name = c("John", "Alice", "Bob", "Eve", "Charlie"),
  Age = c(25, 32, 28, 40, 36),
  Gender = c("M", "F", "M", "F", "M"),
  Salary = c(50000, 60000, 55000, 70000, 65000)
)

# Create a counter to keep track of iterations
i <- 1
# Create a blank dataframe. This allows us to reset the dataframe everytime the loop is ran.
processed_data <- data.frame()

# Repeat loop for processing each row of the dataset
repeat {
  row <- my_data[i, ] # Get the row at the current iteration
  processed_row <- list(  # Perform some data processing on the row
    ID = row$ID,
    Name = paste("Processed:", row$Name),
    Age = row$Age,
    Gender = ifelse(row$Gender == "M", "Male", "Female"),
    Salary = row$Salary * 1.1 # Add a 10% salary increase
  )
  processed_data <- rbind(processed_data, processed_row) # Append the processed row to the processed_data  data frame
  i <- i + 1 # Increase the counter
  if (i > nrow(my_data) || processed_row$Salary > 100000) { 
    break  # Exit the loop when all rows have been processed or when the salary exceeds 100,000 (arbitrary)
  }}

### TASK:

# Let's try it on your own!

# Create a repeat loop that does the following: 
#1) Stores 1 in the variable y.
#2) prints y for iteration of the loop. 
#3) Increase y by .7 each iteration. 
#4) Set a break to terminate the loop when y is greater than 14
#5) Print "Y is big now!" when Y is greater than 14. 

y <- 1
repeat {
  print(paste("Loop", y))
  if (y == 14) {
    break
  }
  y <- y + 1
}
y+.7
print(Y)



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
# In this analogy, our outer loop of the clock would be the short hand, which tells the hour..
# Nested within this outer loop is the inner loop, the long hand of the clock, which tells the minute.
# Here's how we would accomplish this in R:


for (s in 1:12){  # Here we set up our outer loop as "s" to represent our short hand, so this will contain any variable between 1-12 since most analogue clocks use standard time.
  for (l in 01:59) # Now we add in a nested, inner logical condition, which creates a second value "l" for the long hand. This hand will represent our minutes
  {print(paste("The short hand is",s,"And the long hand", l))} # Now we want to print our variables, but paste them together when printed
} # Close the loops




### TASK:

# ✿¸.•´*¨`*•✿ More Flowers!✿•*`¨*`•.¸✿

# Now that we know how nested loops work, lets use our knowledge to create a graph that utilizes this new skill.
#We are going to create a scatterplot using the iris dataset, of sepal length vs. sepal width, with each point colored according to its species (setosa in red, versicolor in blue, and virginica in green). The nested loops are going to be used to loop over each species in the dataset, and then over each observation within that species to plot the points with the appropriate color.

#1. Load the iris dataset using the command data(iris).
#2. Create an empty scatterplot with the plot() function. Set the x-axis to Sepal.Length, y-axis to Sepal.Width, and add labels and a title.
#3. Create a loop to iterate over each unique species in the iris dataset using the for() function.
#4. Within the loop, subset the iris dataset to only include the current species using the subset() function.
#5. Assign a color to the current species using an if statement and a variable to hold the color.
#6. Create another loop to iterate over each observation within the current species using the for() function.
#7. Within the nested loop, extract the current observation's sepal length and width using the $ operator.
#8. Use the points() function to plot the current observation as a point on the scatterplot, using the assigned color.
#9. After the nested loop, use the legend() function to create a legend for the plot. Set the position to "topright", the legend argument to the unique species in the dataset, the col argument to a vector of colors matching the species, the pch argument to 1 to use solid point markers, and the title argument to "Species".
#10. Run the code and check that the resulting scatterplot has a legend.

data("iris")
plot( x=iris$Sepal.Length, y=iris$Sepal.Width, 
      xlab = "Sepal Length", ylab= "Sepal Width",
      main="Scatterplot of Length vs Width")
for(species in unique(iris$species)) {
  spcies_data<-subset(iris,Species==species)
  if(species=="setosa") {
    col<-"#b103fc"
      }else if(species== "versicolot") {
        col<-"#007ae6"
      }else{
        col<-"#e69200"
      }
points(species_data$Sepal.Length,species_data$Sepal.Width, col =col)
  
}
par(xpd=TRUE)
legend("topright",
       legend=unique(iris$Species),
       col=c("b103fc", "#007ae6","#e69200", "#b103fc"),
       pch=1,
       title="species",
       cex=0.8,
       inset=c(0.01,0.1))
