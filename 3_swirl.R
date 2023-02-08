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
#press on the up arrow until it filters through the lines of code for the find that one you want

# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?
#your working directory is essentially the folder that you keep everything in on your computer
#the local workspace is very similar, but is inside R rather then any of your folders

# QUESTION: How do you find help files for a function using R code?
#You can use the ?function() to find out more information about the function you are trying to use

# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?
#There are usually several different ways to do something, however, there might be functions 
#written specifically for a purpose - those are usually the most optimized
#additionally, multiple different ways of doing things allows  you to write your own functions in necessary

# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.
#Logical vectors: generate results based on logical conditions: TRUE, FALSE, NA are the results
#Character vectors: contain character objects - often something that has been named or words
#Integer vector: is made up of numbers that will go up by integers if generated
#Numeric vector: a vector with a specific length

# QUESTION: What does <= stand for?
#less than or equal to
# QUESTION: What does == stand for?
#exact equality
# QUESTION: What does != stand for?
#equal or not equal to
# QUESTION: What does | mean in R?
#at least one is true "union" "or"
# QUESTION: What does & mean when testing for TRUE/FALSE statements?
#whether both logical expressions are true "intersection"

# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data below, then repeat the code 
# that generated my_data to create my_data2. 
x <- c(44, NA, 5, NA)
y <- rnorm(1000)
my_data <- sample(c(y,z), 100)

my_data2 <- sample(c(y,z), 100)
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
identical(my_data, my_data2)
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.


# QUESTION: Explain why my_data and my_data2 were or were not identical.
#They were not identical because sample() generates a random sample of y and x. So the sample for my_data and my_data2 were unique

# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)
#you could use it to sort through rough data with missing numbers - or could easily pull out certain numbers depending 
#on the threshold you are looking at (above certain values)

# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue?
#if you don't know that you asked some something that R can't give, you could be proceeding with inaccurate data

# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?
# row: x
# columns: y

# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?
#use dim()
#use matrix()

# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
# Did you feel like you were taking an LSAT?
#Yes. My two brains cells were smoking by the end. They weren't built for this strain.

# ---------------------------------------------------------- #
#### VII. R Programming -> 15. Base Graphics              ####
# ---------------------------------------------------------- #

# TASK: dim(), names(), head(), and tail() are all great functions!
# Run each of them on the cars dataset.
dim(cars)
head(cars)
tail(cars)

# QUESTION: In your own words, describe what each of these functions do and
# why each one might be useful.
#dim will retrieve the dimensions of whatever you are looking at - this can be helpful to know size of datasets
#head shows the first part of the vector - useful to be able to see your starting data and maybe even double check you work
#if you know what should be there
#tail shows you the last part of the vector - you can see the ending data and more easily work with a small
#section of data

# TASK: Run the str() function on the cars dataset.
str(cars)

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?
#it shows a compact view of whatever object you are looking at - useful for succinct display of data

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
#C should be 4
# a and b start as 1 and 2 respectively. Then are added together to make c = 3. 
#b is then changed to 4
#a is designated what b is, which is 4
#c is whatever a is, whic is 4
#c should be 4

# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 
log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000)
#log(10, 1000) will run differently because that is not one of the says that the log function can be correctly written


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
elephant2_lb/2.2 == elephant1_kg #FALSE

# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?
#I did think that Swirl was helpful. There were definitely things that I learned in it that I hadn't know about before. 
#I also have a little bit of a better understand with the FALSE and TRUE commands - which I had never messed around with before. 
#I think that especially for people who are new, this is a good resource to become familiar with just 
#basic R functions and how the software works. 

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not?
#I think rather than split the Swirl portion (it takes a while, but it isn't really difficult), the content for 
#classes 1 and 3 should just swap. Maybe it depends on how familiar people are with R, but I think that maybe
#swirl would get people are familiar with the basic mechanics, and then use the 1st assignment to make people
#work for what they should be familiar with now

# REMEMBER: Save and push your script when you're done with this assignment!
