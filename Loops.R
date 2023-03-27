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

#Example (Mason)

#Create a vector of numbers 1 through 5, and then use a for loop to iterate through each number in the vector and print it to the console. The loop variable i takes on the values 1, 2, 3, 4, and 5, and the print() function is called with each value of i.

# create a vector of numbers
numbers <- c(1, 2, 3, 4, 5)

# create a for loop that prints each number in the vector
for (i in numbers) {
  print(i)
}

# For loops can iterate over a sequence of numbers, in the following example, from 1 to 100 and calculates the sum of the numbers. The loop variable i takes on the values 1, 2, 3, ..., 100, and the sum variable is updated on each iteration.

sum <- 0
for (i in 1:100) {
  sum <- sum + i
}
print(sum)

#Do it yourself 

#DUE: MARCH 26TH

#While Loops
#Description (Mason)
#Next  (William)
#Example (Zachary)
#Do it yourself (Lowie)

#DUE: MARCH 30TH

#Repeat Loops
#Description (William)
#Break (Mason)
#Example (Lowie)
#Do it yourself (Zachary)

#DUE: APRIL 5TH

#Final 
#Nested loops within For Loops 
#Description of nested loops  (Zachary)
#Example (William)
#Do it yourself with a dataset (Mason)


#DUE: APRIL 8TH