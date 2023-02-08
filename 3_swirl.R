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
install.packages("swirl")
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
# ANSWER: Use the up arrow to get to the line of code you want to return to.

# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?
# ANSWER: The working directory is a kind of file in which all the work is saved while the 
# local workspace contains what is currently being worked with.

# QUESTION: How do you find help files for a function using R code?
# ANSWER: You can type ? followed by the function you need to know more about.


# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?
# ANSWER: There are many different ways. This is useful because there are some built in 
# functions that serve a specific purpose, but there are often other ways to do the same function
# making there several approaches to the same problem.

# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.

# QUESTION: What does <= stand for?
# ANSWER: Less than or equal to

# QUESTION: What does == stand for?
# ANSWER: exactly equal to

# QUESTION: What does != stand for?
# ANSWER: not equal to

# QUESTION: What does | mean in R?
# ANSWER: or

# QUESTION: What does & mean when testing for TRUE/FALSE statements?
# ANSWER: To ask whether both are TRUE


# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data below, then repeat the code 
# that generated my_data to create my_data2.
my_data <- sample(c(y, z), 100)
my_data2 <- sample(c(y, z), 100)
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
identical(my_data, my_data2)
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.


# QUESTION: Explain why my_data and my_data2 were or were not identical.
# ANSWER: They were not identical because 100 elements were selected at random from 
# 2000 values.

# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)
# ANSWER: An example could be if you only wanted to look at a specific species of
# plant in your data that only grew to a specific height, subsetting would be very helpful
# when organizing the data.

# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue?
# ANSWER: Becasue it might give an answer, even if its just NA, when in reality 
# there is no answer because it is out of the bounds of the vector.

# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?
# ANSWER: x represents rows and y represents columns.

# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?
# ANSWER: By creating a vector with 1-20 and then setting the dimentions of the 
# vector to 4 by 5 and then turning it into a matrix or by running this script ->
# matrix(1:20, 4, 5)



# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
# Did you feel like you were taking an LSAT?
# ANSWER: I have completed this sections, yes, the logic was very painful. 

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
# ANSWER:
# dim: retrieves or sets the dimension of an object. You can make matrixs and 
# check to make sure the dimensions are correct.
# names: retrieves or sets the names of objects, helps you know the names in the data before manipulation.
# head: displays the first rows of the data, can give more insight to the data.
# tail: displays the last rows of the data, can give more insight to the data.

# TASK: Run the str() function on the cars dataset.
str(cars)

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?
# ANSWER: gives a summary of the data which can be useful to get to know the data.

# ---------------------------------------------------------- #
#### PART 2: TEST WHAT YOU LEARNED                        ####
# ---------------------------------------------------------- #

# I) Without running the code, what does the following block 
# of code print? Please explain why.
# It would print 4, this is because we assigned the number 1 to a and the number 2 to be. 
# Then we added them together and so now 3 is assigned to c. Afterward, the number 4 replaces 2 for the letter b.
# Then b replaces a, so a was previously 1, becomes b's new value of 4. 
# Finally, we replace c's original value of 3 with a's new value of 4.
a <- 1
b <- 2
c <- a + b
b <- 4
a <- b
c <- a
c


# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 
log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000)

# ANSWER: The last line would produce in a different result because it is calculating the
# log with a base of 1000, while the other is producing a result with the base of 10.

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
elephant1_lb <- elephant1_kg * 2.2
elephant2_lb <- 7757

elephant1_lb > elephant2_lb

# ANSWER: elephant 2 weighs more

# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?
# ANSWER: It was very helpful because it gave a step by step guide to how to use each 
# function. I felt that I made a lot less mistakes becasue I was told exactly what 
# to do and also was quizzed along the way.

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not?
# ANSWER: yes, i think if we did part of swirl before completing week 1 assignment,
# it would result in mush faster understanding of the material because we already feel comfortable
# with r.

# REMEMBER: Save and push your script when you're done with this assignment!
