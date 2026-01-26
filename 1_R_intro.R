#### MODULE 1: Intro to R and RStudio #### 

## OBJECTIVE:
## To explore the basic building blocks of the R programming language.
## To become comfortable running and writing R code and working together.
## We will practice the concepts of 'function' and 'argument', 
## and learn some basic functions in R. 
## Create a resource to refer back to.

# ----------------------------------------------------------
#### 1) In it's simplest form, R can be used as an interactive calculator.####
# ----------------------------------------------------------

## Type this in the console; note the use of the operator '+' 
2 + 3

## Now run the same code but this time run it from the script
## Instead of copying 2 + 3 into the console,
## click on or highlight the line and run cmd-return or cntl-R 
## Or, in a pinch, click on the line and click the run icon to
## the right in RStudio above the script
2+3

## Now try running the lines preceded by hashtags
## QUESTION: What happens? Why might this be useful?


## TASK: On a new line in the R script, type ctl+shift+c (windows) or
## cmd+shift+c (mac) and make yourself a note that keyboard shortcuts are awesome


## TASK: Use the following four basic algebraic operators: '-', '*', '/' and '^'  
## to subtract, multiply, etc. the values 2 and 3.

 
## Like any good interactive calculator, R follows the standard mathematical 
## order of operations. 
## Type:
3+2/8

# Now type:
(3+2)/8

## QUESTION: Why are the results different?


## TASK: What is the result of: multiplying 5 by 11, 
## then dividing that value by 3, adding 6 to it, 
## and then squaring that value? 
## Write this operation as a single line of code.



# ----------------------------------------------------------
#### 2) Functions can replace basic algebraic operators.####
# ----------------------------------------------------------

## Type this into the console:
sum(2, 3)

## QUESTION: What is 'sum'? 

#Now type:
Sum(2, 3)

## The above command should give you an error. This is because R distinguishes 
## lower case from UPPER case. The function 'sum' is not the same 
## as 'Sum', and in this case 'Sum' does not exist.

## In addition to the common arithmetic operators +, -, / and ^, 
## other useful operators are mean() for the mean, sqrt() to 
## take the square root, abs() for the absolute value, and exp()
## to take e^some number.

## TASK: What is the absolute value of e^3? Write this as a single line of code.
## Did you encounter any challenges in running your code? How did you solve them?



# ----------------------------------------------------------
#### 3) Results can be stored and reused as objects. #####
# ----------------------------------------------------------

## We've summed 2 and 3 a lot! This time let's just save the results for 
## future use.
## Type:
x <- sum(2,3)

## This can be read as "x gets 2 plus 3". Notice that R did not print the result 
## 5 this time.
## To view the contents of the variable x, just type x and run:


## Now store the results of x/8 in a new variable y:
y <- x/8

## QUESTION: What is the value of y? Write a line of code below in your script
## that will print the value to your console.



# ----------------------------------------------------------
#### 4) A collection of values can be stored as a vector. ####
# ----------------------------------------------------------

## The easiest way to create a vector is with the c() function, 
## which stands for 'concatenate' or 'combine'. 
## Let's store a vector of 1.1, 9 and 3.14 in a variable called z:
z <- c(1.1, 9, 3.14)

## Type z to view its contents:


## QUESTION: What do you notice about z? How many elements does it have?


## TASK: How long is z? Use the function length() to confirm the length of this vector.


## You can combine vectors to make a new vector. 

## TASK: Create a new vector that contains z, 555,then z again in that order.
## Give it a new name.


## Numeric vectors can be used in arithmetic expressions. 
## Run the following code:
z*2+100

## QUESTION: What happened when you ran the above line?


## Create a new vector my_sqrt:
my_sqrt <- sqrt(z-1)

## QUESTION: Before you look at it, what do you think my_sqrt contains?



# ----------------------------------------------------------
#### 5) Vectors can be created as sequences of numbers. ####
# ----------------------------------------------------------

## The simplest way to create a sequence is by using the ':' operator.
## Type:
1:20

## QUESTION: What happens if we instead type 20:1?


## The seq() function gives us more control over the sequence
## Type:
seq(1, 20)

## This gives the same output as 1:20. But let's say we want the numbers to range from
## 0 to 10 but at 0.5 increments. Try it out:
seq(0, 10, by=.5)

## Or maybe we don't care about the increment, we just want 30 numbers between 5 and 10.
## Try it out:
my_seq <- seq(5, 10, length=30)


## QUESTION: What is my_seq?


## TASK: Use a function to confirm that my_seq has length 30.



## Maybe we want to create a vector that contains 40 0s. 
## Type:
rep(0, times=40)

## Or maybe we want to create a vector that contains 10 repetitions of the vector (0,1,2,3,4)
## Type: 
rep(c(0, 1, 2, 3, 4), times=10)

##TASK: Generate the same vector by integrating the seq() and rep() functions



# ----------------------------------------------------------
#### 6) Values can be characters as well as numbers. ####
# ----------------------------------------------------------

## What's your favorite plant species?
## One of mine is Schizachyrium scoparium (little bluestem!)
## To make sure we remember that, let's make a vector called "kims_favorite":
kims_favorite <- c("Schizachyrium", "scoparium")

## Let's view that vector. But typing kims_favorite takes a looong time. 
## To save time, type ki then press tab. What happens?


## TASK: Use the length function to confirm the length of kims_favorite


## What if I want genus and species to be grouped as a single character string?
## Run:
kims_favorite2 <- paste("Schizachyrium", "scoparium")
## Now run:
kims_favorite3 <- "Schizachyrium scoparium"

## TASK: Use the length function to confirm the lengths of kims_favorite2 and
## kims_favorite3


## TASK: Use the function 'paste' to join together the genus and species of your 
## favorite species. 


## TASK: Concatenate c() your favorite species and mine (kims_favorite2) 
## in a vector called our_favorites.



# ----------------------------------------------------------
#### 7) Vectors can be combined into matrices and data frames #### 
# ----------------------------------------------------------

## Let's start with matrices. These are similar to vectors in that all of the 
## data must be of the same type (e.g., numbers), but matrices have 2 dimensions 
## (rows x columns). Matrices (e.g., for correlation and covariance coefficients)
## are common in statistics and in population biology, where population 
## projection matrices are used.

## We'll first create a simple vector containing the number 1 through 24. 
## The colon : operator can be used to create a sequence.
firstVector <- 1:24

## Take a look at the dim help file by running the following code:
?dim 

## According to ?dim, the dim() function can be used to both retrieve or SET 
## the dimensions of an object.

## QUESTION: What are the dimensions of firstVector? Use dim() to find out.


## Let's use it to set the dimensions of firstVector
dim(firstVector) <- c(4,6)

## QUESTION: What are the dimensions of firstVector now? Use dim() to find out.


## QUESTION: What is the class of firstVector? Use the class() function 
## to find out.


## Congratulations, you've changed a 24-element into a 4 row by 6 column matrix!
## To reflect this change, let's assign our new matrix to an object called "firstMatrix"
firstMatrix <- firstVector

## And if you like you can remove the firstVector object from your environment by
## running the following code:
rm(firstVector)

## Suppose that firstMatrix represents the happiness levels over time for some
## students of the class. Each row represents a student and each
## column represents happiness level taken at 6 times during this session.
## It would be useful to label the rows so that we know who the students are.
## We'll add a column to the matrix to do this.
students <- c("Terra", "Anish", "Emma", "Delaney")

## Now we'll use the cbind() function to combine participants and firstMatrix
## cbind indicates "column bind" - it to binds columns together.
## rbind is the corresponding function for rows.
secondMatrix <- cbind(students, firstMatrix)

## QUESTION: what attributes of the matrix change when we do this?


## Remember that a matrix can only contain one type of data! 
## We added a character vector to an integer matrix!
## And what did R do in response? Forced all of the numbers into character values. 

## TASK: Use rbind() to label the days Day1, Day3, Day5, Day7, Day9, and Day11
## in secondMatrix. Save this with a new name, thirdMatrix
## Hint, don't forget about the new column we added too!



## Accessing elements in a matrix uses square brackets, [], with the order
## rows by columns. For example, if I want to print to the screen the 
## element in the third row and second column, I would use
thirdMatrix[3,2]

## TASK: Use one line of code to print to the screen 
## the elements in the 4th row and 2nd, 3rd, and 4th columns.
## Hint, think of how we listed sequences of numbers above.


## Additional Thoughts:
## There are many ways to do the same thing in R. We could also make a matrix 
## using the matrix function.
fourthMatrix <- matrix(1:24, nrow=4, ncol=6)

## We can check to see if the matrices are the same using the 
## identical() function.
identical(firstMatrix, fourthMatrix)  #Did we succeed?

## Now, let's use a data structure that allows columns with different data types
## This is called a data frame. It is often more useful for data wrangling than
## a matrix, but cannot be used effectively for matrix math. Both are important
## to understand!

## Let's create a dataframe called "happyData" by binding students and first matrix
happyData <- data.frame(students, firstMatrix)

## TASK: View the contents of happyData


## TASK: Find the class and dimension of happyData


## The names of the columns are not descriptive. 
colnames(happyData) #note colnames() is a function that prints the column names

## Let's fix that.
## TASK: Create a vector called cNames containing 
## "student", "time1", "time2", "time3", "time4", "time5", "time6"
## Hint: you could copy those names from above. Don't forget to concatenate using c()


## TASK: Use the names() function to set the column names attribute for our 
## data frame. This will be similar to our use of dim() to set the dimension of a vector.


## TASK: View the final data frame.


## You can access specific elements of a dataframe just like you can with
## a matrix using the [rows, columns] notation.

## TASK: Print to the console Delaney's happiness on time5 


## When working with dataframes you can also access entire columns 
## using the $, so you call yourdataframe$yourcolumnname. For example
## the below code gives you all student names:
happyData$student

## TASK: in a single line of code, find the mean happiness at time2.



# ----------------------------------------------------------
#### 8) Anatomy of a function ####
# ----------------------------------------------------------

## Let's take a closer look at functions
## Functions have 5 different properties:
## 1) the name, 2) the body, 3) the arguments, 
## 4) the default values (sometimes), and 
## 5) the last line of code that it will return

## Below is an example "roll two dice" function
roll2 <- function(die = 1:6){
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

## roll2 is the name of the function.
## die is the argument, 1:6 is the default, the code within the {} is the body,
## The last line (i.e., what is returned) is the sum of rolling the dice twice
## This function rolls two die and sums their values!

## QUESTION: What happens if you run roll2 without supplying any arguments?
roll2()


## Now run the code roll2(die=30:60). 
roll2(die=30:60)

##Here, we changed the default arguments from 1:6 to 30:60

## QUESTION: How many sides does each die now have and what is the lowest
## and highest number on a single die in the above example?



# ----------------------------------------------------------
#### 9) R libraries are bundles of functions ####
# ----------------------------------------------------------

## R is open-source, which means that anyone can share code by creating an 
## R package (also called a library).
## R packages are bundles of functions, often based around a theme.
## You only have to install a package once, either through the dropdown menus 
## or using the function install.packages()
## But you have to load an installed package each R session.

## For example, try printing the code underlying the function pivot_longer
pivot_longer

## QUESTION: What happened? 


## pivot_longer is a function in the package tidyr
## If you haven't already, install tidyr now by uncommenting and running 
## the following code:
# install.packages("tidyr")

## Now load the package that you just installed using the following code:
library(tidyr)

## QUESTION: Now what happens when you print pivot_longer?


## pivot_longer is a function to help "tidy" data, which we will cover later.
## But as a preview, let's use it to transform the dataframe happy data:
pivot_longer(happyData, cols = 2:ncol(happyData), 
             names_to = "timepoints", values_to = "happiness")

## QUESTION: What did pivot_longer do? Why might this be useful? 


## TASK: Now install and load the package 'nycflights13', which is one of the 
## examples we use in the textbook.


## QUESTION: What is the name of the third column of the object flights?
## Note this object can be accessed once nycflights13 is loaded.



# ----------------------------------------------------------
#### 10) Getting help as we go along. ####
# ----------------------------------------------------------

## The arguments to each function are always documented. 
## Let's look up the possible arguments for the paste function.
## Run the following: 
?paste

## QUESTION: Using the help for the paste function, identify the role of the 
## argument 'sep'.


## QUESTION: Does this argument have a predetermined value? What is that value?


## TASK: Use 'paste' to join together the genus and species names of your 
## favorite species using the character '_' to separate the two words.



# ----------------------------------------------------------
#### 11) Next class setup  ####
# ----------------------------------------------------------

## There are a lot of different tools available to learn R
## A great one is an R package called swirl, with the motto "Learn R, in R".
## Install and load swirl now:
install.packages("swirl")
library(swirl)

## swirl includes different modules. 
## To reinforce some of this lesson, and to learn more about how R treats vectors, 
## you will be working through swirl modules for your third problem set in a few weeks.


# ----------------------------------------------------------
#### 12) Cleaning up at the end  ####
# ----------------------------------------------------------

## It is always nice (and important for reproducibility)
## to clean up your environment when you are done with a project
## and moving to a new one. This allows you to start fresh and clean
## when coming back to R.

## There are many ways to do so. My go-to is usually to go to
## session --> Clear Workspace OR click the little broom in the work environment tab




