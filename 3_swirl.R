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
## Use the up arrow to re-select it.


# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?
## The working directory is where all files are permanently saved, 
## while the local workspace is where you are currently accessing files.

# QUESTION: How do you find help files for a function using R code?
##By typing ? before the command. (ex. ?sum)

# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?
## There are usually a bunch of different ways to do different things,
## some might be simpler or easier to use or make more sense to the
## person writing them.


# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.
## A logical vector describes a characteristic (such as TRUE or FALSE),
## a character vector is any non-numeric character (such as !, &, *, letters, etc),
## an integer vector contains integers and a numeric vector contains
## only numbers.

# QUESTION: What does <= stand for?
## Less than or equal to.
# QUESTION: What does == stand for?
## Exactly equal to.
# QUESTION: What does != stand for?
## Inequality.
# QUESTION: What does | mean in R?
## OR, is a variable true in A or B.
# QUESTION: What does & mean when testing for TRUE/FALSE statements?
## AND, is a variable true in both A and B.

# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data below, then repeat the code 
# that generated my_data to create my_data2. 
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.
my_data <-sample(c(y,z),100)
my_data2 <-sample(c(y,z),100)

identical(my_data,my_data2)
##They are not identical.

# QUESTION: Explain why my_data and my_data2 were or were not identical.
## They are pulling random values, and as such will most likely be pulling
## different values and different #'s of NA's.


# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)
## If you have a large dataset full of specimens and their associated information,
## like sex, age, weight, etc., it might be useful to subset out just one variable,
## such as sex, to see what your ratio of females to males is.

# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue?
## If you make an error when coding (like you want variable 300, not 3000) but don't
## realize it right away, you could cause more errors for yourself down the line by
## using this non-existant variable.


# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?
## X represents rows, Y represents columns.


# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?
my_matrix<-matrix(1:20,nrow=4,ncol=5)
## OR
my_vector<- 1:20
dim(my_vector)<-c(4,5)


# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
# Did you feel like you were taking an LSAT?
<<<<<<< HEAD
## Yes - some of those definitely made my brain hurt. :(
=======
## blah blah.
>>>>>>> ab338440cbf0866a9e13589f0b930bbbb70acd66


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
## dim(cars) provides the dimensions of the dataset - 2 columns and 50 rows.
## names(cars) provides the names of each column.
## head(cars) provides the first 6 rows of the dataset + associated column names.
## tail(cars) provides the last 6 rows of the dataset + associated col names.

# TASK: Run the str() function on the cars dataset.
str(cars)

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?
## It provides basic identifying information, such as the type of data set it is -
## a dataframe - how many objects are within - 50 for 2 variables - as well as 
## the first ten values as well as col names and type of data (num = numerical).
## This is very valuable for identifying what kind of dataset you are looking at,
## and verifying it has the amount and type of data you are looking for.


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

## It should print 4. a+b are originally equal to 3, making c originally 3, but 
## b is then set to 4, making a set to 4, and then c is set to a (4), making
## c equivalent to 4.


# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 
log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000)

## log(10,1000) would not result in the same answer as the others, as all the rest
## of the functions are a log of base 10 to 1000, while the fourth is a log of 
## base 1000 to 10.



# III) Use one of R's built in functions to create a new vector that is 
# the entries in numvector arranged in descending order. We have not learned 
# this function, but a combination of Google and function documentation 
# should get you there.
numvector <- c(5,2,3,1,6,8)

numvector <- sort(numvector,decreasing=TRUE)

## Shoutout to geeksforgeeks.org for the easy answer. \o/


# IV) Which elephant weighs more? 
# Convert one’s weight to the units of the other, and store the result in an 
# appropriately-named new variable. Test whether elephant1 weights more than 
# elephant2 using an equation that returns either true or false (1 kg ≈ 2.2 lb).

elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_lb <- (elephant1_kg*2.2)
isTRUE(elephant1_lb>elephant2_lb)


# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?

## It was very helpful! I did find that dipping toes in plots was a little tricky,
## along with the boolean arguments, but I think that just comes with the territory.
## I do wish there was a way to restart a tutorial you're on (? maybe I missed it?),
## since I stopped partway through 8 and confused myself and couldn't get back to the 
## start of that section. Might be useful to cover this in the future.

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not?
## Big yes! The first four modules (+7) feel more like week 1 work, and 5, 6, 8 
## and 15 feel more appropriate for week 3. I feel like they would make a great 
## hands-on portion to help supplement the learning we did on each of these weeks.

# REMEMBER: Save and push your script when you're done with this assignment!
