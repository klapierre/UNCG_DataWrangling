# ---------------------------------------------------------- #
#### MODULE 1: Practice with R in swirl                   ####               
# ---------------------------------------------------------- #

## OBJECTIVE:
## To explore the basic building blocks of the R programming language.
## To become comfortable running and writing R code and working in the R Studio environment.


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
install.packages("swirl")
# Then load swirl
library(swirl)
# Then install the course R Programming
install_course("R Programming")

# Now run the code below
swirl()
# You should now be able to navigate to the R Programming Course and the specific
# modules below. Complete modules 1-8 and 15, pausing between each module to 
# answer the questions below. Then continue on to Part II, testing out your 
# ability to put what you learned into practice. Finish with Part III to provide
# feedback on what you think of swirl.

# ---------------------------------------------------------- #
#### I. R Programming -> 1. Basic Building Blocks         #### 
# ---------------------------------------------------------- #
# QUESTION: What would you do to get back a line of code you previously ran
# from your console without retyping the whole thing again?
# The up arrow key will recycle through previous commands.

# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?
# Your working directory is the location of R's files on your computer. While
# your local workspace includes which variables etc. you have created / been using.

# QUESTION: How do you find help files for a function using R code?
# ?list.files will give you a help page for functions you have been using. Alternatively
# you can type ?NameOfFormula to see more information.

# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?
# There are usually multiple different ways to complete the same task, this allows
# for using a smoother path depending on circumstances.Additionally in some cases
# extra functionality is added (i.e a sequence can be calculated in different increments).
# This also helps with readability etc.

# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.
# Logical vectors are based around a logical assumption, that is that it is true,
# false, or not availiable. A numeric vector contains numerical values, a character
# vector contains characters i.e. letters, and an integer vector contains exact
# integer values.

# QUESTION: What does <= stand for?
# Less than or equal to.

# QUESTION: What does == stand for?
# Exact equality.

# QUESTION: What does != stand for?
# Inequality.

# QUESTION: What does | mean in R?
# At least one piece is true.

# QUESTION: What does & mean when testing for TRUE/FALSE statements?
# Both pieces are true or false.

# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data to the script below, then create a new 
# object called my_data2 using the same procedure.  
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.


# QUESTION: Explain why my_data and my_data2 were or were not identical.
# Because my_data / my_data2 were both random draws, so each of the 100 values 
# will not match in the same spots.

# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)
# You may only want positive values from a dataset of say growth per quarter 
# in order to calculate growth during non-recessionary times.

# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue? 
# The value may not exist within the dataset at all, so it's good to check such
# a value actually exists before asking for it.


# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?
# x represents rows and y represents columns

# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?
# You could arrange the numbers in the matrix either in increasing or decreasing
# orders.

# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
# Did you feel like you were taking an LSAT?
# A little bit.

# ---------------------------------------------------------- #
#### VII. R Programming -> 15. Base Graphics              ####
# ---------------------------------------------------------- #

# TASK: dim(), names(), head(), and tail() are all great functions!
# Run each of them on the cars dataset.

# QUESTION: In your own words, describe what each of these functions do and
# why each one might be useful.
# dim(cars) describes the dimensions of the dataset, i.e. how many rows and columns
# we have, this would be useful to now how many items we have. names(cars) describes 
# the names of the columns, which'll let us know what the numeric values mean. head 
# (cars) and tail(cars) respectively show us the first and last 6 sets of data of the
# dataset, which would let us see at least a general trend.

# TASK: Run the str() function on the cars dataset.

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?
# str(cars) will give us essentially all of the data (aside from the tail) which
# the previous functions gave us, with less typing required.

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
# c will be equal to four as the last bit of data?

# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 
log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000)
# The last one will be different as it doesn't express what the 10 or 1000
# correspond to in the formula per the log function.


# III) Use one of R's built in functions to create a new vector that is 
# the entries in numvector arranged in descending order. We have not learned 
# this function, but a combination of Google and function documentation 
# should get you there.
numvector <- c(5,2,3,1,6,8)
# numvector_desc <- sort(numvector, decreasing = TRUE)

# IV) Which elephant weighs more? 
# Convert one’s weight to the units of the other, and store the result in an 
# appropriately-named new variable. Test whether elephant1 weights more than 
# elephant2 using an equation that returns either true or false (1 kg ≈ 2.2 lb).

elephant1_kg <- 3492
elephant2_lb <- 7757
# elephant1_kg*2.2 > elephant2_lb

# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?
# The swirl tutorial was generally useful to learn some basic formulas / 
# functions within R. I did at least learn the general formatting a little bit more.

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not
# I think both assignments were useful, so I think keeping the swirl tutorial as 
# a week 3 assignment while the original assignment was on week 1 would be reasonable.

# REMEMBER: Save and upload your script to Canvas when you're done with
# this assignment!