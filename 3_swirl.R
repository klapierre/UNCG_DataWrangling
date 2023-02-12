# ---------------------------------------------------------- #
#### MODULE 1: Practice with R in swirl                   ####               
# ---------------------------------------------------------- #

## OBJECTIVE:
## To explore the basic building blocks of the R programming language.
## To become comfortable running and writing R code and working in the R Studio environment.


# ---------------------------------------------------------- #
#### SET UP:                                              ####
# ---------------------------------------------------------- #
# REMINDER: Create a new branch for this week through the GitHub website
# called yourLastName_week4. Open the Rproject for our course
# (UNCG_DataWrangling),pull any changes from GitHub, and navigate to the
# branch you created for this week in RStudio's Git tab. Open this week's
# assignment in this new branch to complete and submit on GitHub.
# Ideally, you'll commit your answers a bit at a time as you work through
# this assignment, rather than committing all at once at the end.


# ---------------------------------------------------------- #
#### PART 1: SWIRL COURSES AND ASSOCIATED QUESTIONS       ####
# ---------------------------------------------------------- #

# INSTRUCTIONS:
# Take the following courses in swirl.
# All below are all modules in the R Programming course

# Some of these will be parallel to and reinforcing previous in-class exercises, 
# and others will expand on what we have learned. 
# As you proceed with each module please pause and use the play() function 
# at relevant stages in each module to answer the associated questions below. 
# When you are ready to start working through the swirl() module again
# just type nxt().
# Please note that swirl is a little buggy, and if you answer a multiple choice 
# incorrectly it may give you an error and exit swirl. 
# If that happens, type swirl() to resume and enter the same user name you used 
# previously, and you should be able to navigate directly back to where 
# you left off. 

# If swirl is not yet installed, install it first
# install.packages("swirl")
# Then load swirl
library(swirl)
# Then install the course R Programming
install_course("R Programming")

# Now run the code below
swirl()
# You should now be able to navigate to the R Programming Course and the modules below.

# ---------------------------------------------------------- #
#### I. R Programming -> 1. Basic Building Blocks         #### 
# ---------------------------------------------------------- #
# QUESTION: What would you do to get back a line of code you previously ran
# from your console without retyping the whole thing again?
#press the up arrow to re-call previous commands.

# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?
#Working directory is linked to git while the local workspace is only linked to the computer.

# QUESTION: How do you find help files for a function using R code?
#Precede the function with a '?' and run, or search the function in the help tab.

# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?
#many different ways. Certain functions may have additional useful variables, or just cleaner looking code.
#Certain values may also be based on previously defined vectors.

# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.

# QUESTION: What does <= stand for? less than or equal to

# QUESTION: What does == stand for? exact equality

# QUESTION: What does != stand for? inequality

# QUESTION: What does | mean in R? asking if at least one logical expression is true (or function)

# QUESTION: What does & mean when testing for TRUE/FALSE statements? asking if both/all logical expressions are true (and function)


# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data below, then repeat the code 
# that generated my_data to create my_data2. 
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.
y <- rnorm(1000)
z <- rep(NA, 1000)
my_data2 <- sample(c(y,z), 100)
identical(my_data, my_data2)

# QUESTION: Explain why my_data and my_data2 were or were not identical.
#different random samples of 100 were taken from the total of 2000 samples each time the sample function ran.

# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)
#Looking at a dataset where test subjects either completed, partially completed, or did 
# not complete, you might want to study only the able or non-able groups based on the study goals.

# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue?
#you might not notice that the value is not within the vector, hence a response 
# being incorrect, but R does not notify us that it does not exist.

# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?
# x represents rows and y represents columns

# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?
#you can either create a vector and assign dimensions or use the matrix function to create a matrix
x <- 1:20 
  matrix1 <- (dim(x) <- c(4, 5)) 
matrix2 <- matrix(1:20, nrow= 4, ncol= 5)

# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
# Did you feel like you were taking an LSAT?
#this must have been my least favorite section
#I got stuck on evaluating which isTRUE statement is TRUE because I didn't notice the '!' in front of some isTRUE statements.

# ---------------------------------------------------------- #
#### VII. R Programming -> 15. Base Graphics              ####
# ---------------------------------------------------------- #

# TASK: dim(), names(), head(), and tail() are all great functions!
# Run each of them on the cars dataset.
dim(cars)  #lets you know the number of data points and can reflect the number of variables 
names(cars) #gives the names of the variables
head(cars) #displays the first 6 rows of data
tail(cars) #displays the last 6 rows of data. Head and tail gives range of the data (4-25 mph)

# QUESTION: In your own words, describe what each of these functions do and
# why each one might be useful.
#always good to be familiar with the data set you are working with.

# TASK: Run the str() function on the cars dataset.
str(cars)

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?
#displays a condensed summary of the data set with most of the info found above in a single function
#always good to be familiar with the data

# ---------------------------------------------------------- #
#### PART 2: TEST WHAT YOU LEARNED                        ####
# ---------------------------------------------------------- #

# I) Without running the code, what does the following block 
# of code print? Please explain why.
a <- 1
b <- 2
c <- a + b
b <- 4
a <- b
c <- a
c = 4 # if 'b' was set to 4, setting 'a' to 'b' or 4, and 'c' is set to 'a' which is now 4.


# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 
log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000) #<----different
#there is no base exponent set in this function so it assumes natural log. 


# III) Use one of R's built in functions to create a new vector that is 
# the entries in numvector arranged in descending order. We have not learned 
# this function, but a combination of Google and function documentation 
# should get you there.
numvector <- c(5,2,3,1,6,8)
sort(numvector, decreasing = TRUE)

# IV) Which elephant weighs more? 
# Convert one’s weight to the units of the other, and store the result in an 
# appropriately-named new variable. Test whether elephant1 weights more than 
# elephant2 using an equation that returns either true or false (1 kg ≈ 2.2 lb).

elephant1_kg <- 3492
elephant2_lb <- 7757
elephant1_lb <- (elephant1_kg * 2.2)
elephant1_lb > elephant2_lb # false elephant1 does not weigh more than elephant2

# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?
#I found it good practice and they added some helpful tips to help understand what I was doing.

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not?
#I think the Swirl tutorial would have helped the first week. I think it would reduce some stress for people new to R,
# having more guidance while being introduced.

# REMEMBER: Save and push your script when you're done with this assignment!
