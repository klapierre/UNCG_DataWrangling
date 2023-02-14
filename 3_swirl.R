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
## To recall previously run lines of code, simply press the up button
## Until the desired line appears in the working console.

# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?
# The working directory is where we pull data to work from, the
# workspace is where our variables and data are stored to be worked with. 

# QUESTION: How do you find help files for a function using R code?
# By typing a "?" before the function.

# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?
# There are multiple ways of executing a task in R, this is useful as it allows
# R programmers a wide range of executing similar tasks, but with varying
# levels of specificity and customization.


# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.

# QUESTION: What does <= stand for?
# less than or equal to

# QUESTION: What does == stand for?
# exact equality

# QUESTION: What does != stand for?
# Ineduqalities

# QUESTION: What does | mean in R?
# This states at least one of the statements is TRUE

# QUESTION: What does & mean when testing for TRUE/FALSE statements?
# This states that both statements are TRUE


# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data below, then repeat the code 
# that generated my_data to create my_data2. 
y <- rnorm(1000)
z <-  rep(NA, 1000)
my_data <- sample(c(y,z),100)
y <- rnorm(1000)
z <- rnorm(NA,1000)
my_data2 <-  sample(c(y,z),100)
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
identical(my_data,my_data2)
#FALSE
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.


# QUESTION: Explain why my_data and my_data2 were or were not identical.
# From what I can tell, the two variables differ due to them switching off
## counting which lines are NA or an actual number.

# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)
# By subsetting we are able to select a portion of our data to work with our of a larger
# dataset. This would be useful in a number of scenarios, but especially if we are
# trying to look at data in a specific region or place out of a larger range of locations.

# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue?
# This can be an issue because it can confuse or muddle our information, or result in
# an inconclusive answer.


# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?
# x= rows, y= columns


# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?
#You could create a vector by assigning it dimensions. Or you could run the below line.
matrix= (data=1:20,nrow=4,ncol=5,byrow= FALSE)



# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
# Did you feel like you were taking an LSAT?
# Done, and my head is swimming! 


# ---------------------------------------------------------- #
#### VII. R Programming -> 15. Base Graphics              ####
# ---------------------------------------------------------- #

# TASK: dim(), names(), head(), and tail() are all great functions!
# Run each of them on the cars dataset.
dim(cars)
names(cars)
head(cars)
tail(cars)

# QUESTION: In your own words, describe what each of these functions do and
# why each one might be useful.
# dim() shows the dimensions and size of the object of interest.
# names() shows each of the names associated with the column variables
# head() and tail() show the beginning and end of an object, respectively.
# TASK: Run the str() function on the cars dataset.
str(cars)

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?
# str() gives a basic overview of all of the data within an object. This
# could be helpful in viewing the basics of a dataset before jumping into analysis.

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
c
#This block of code assigns values to variables and then nests certain variables
# within others to create a string of information to be used.

# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 
log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000)
# I am not entirely sure, but I would assume the last one would yield a different result,
# because they are treated as two entirely different variables within the logarithm


# III) Use one of R's built in functions to create a new vector that is 
# the entries in numvector arranged in descending order. We have not learned 
# this function, but a combination of Google and function documentation 
# should get you there.
numvector <- c(5,2,3,1,6,8)
ordered <- numvecctor[order(numvector,decreasing=TRUE)]

# IV) Which elephant weighs more? 
# Convert one’s weight to the units of the other, and store the result in an 
# appropriately-named new variable. Test whether elephant1 weights more than 
# elephant2 using an equation that returns either true or false (1 kg ≈ 2.2 lb).

elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_kg <- 3492
elephant2_lb <- 7757
elephant2_kg <- elephtant2_lb/2.2
elephant1_kg < elephant2_kg

# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?
# This was SUPER helpful. I was introduced to a ton of new skills and information
# that I will be using far after this class, and I will likely come back to swirl for help.

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not?
# I would have definitely preferred this split into multiple parts rather than just one week.

# REMEMBER: Save and push your script when you're done with this assignment!
