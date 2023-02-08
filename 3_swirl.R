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

# Hit the up arrow until you get your desired line of code.

# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?

# Working directory is where you can pull and place files from.
# Your Working Space is synonymous with Environment

# QUESTION: How do you find help files for a function using R code?

# Place a ? before the function name.

# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?

# There are lots of ways to do the same things.
# Some people have some individual preferences for how to approach a task.
# Also some specific packages don't work well together, so more options = better.


# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.

# QUESTION: What does <= stand for?

# Less than or equal to vector

# QUESTION: What does == stand for?

# Is exactly 

# QUESTION: What does != stand for?

# Is not equal to

# QUESTION: What does | mean in R?

# Or

# QUESTION: What does & mean when testing for TRUE/FALSE statements?

# Both


# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data below, then repeat the code 
# that generated my_data to create my_data2. 
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.

my_data2 <- sample(c(y, z), 100)
identical(my_data, my_data2)

# QUESTION: Explain why my_data and my_data2 were or were not identical.

# These sets are not identical because when "mydata2" was created it
# pulled a different subset from the sample population criteria

# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)

# Maybe every third data point you collected needs to be removed, or examined separately.

# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue?

# R needs you to think about the question that your asking it. You need to know
# if your question/code makes sense for the dataset you are examining.


# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?

# x = row
# y = col

# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?

# You could create a vector through something like matrix <- 1:20 then 
# adding it some dimensions using the dim() function

# Or you could use the matrix() function like matrix(1:20,4,5,F)

# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
# Did you feel like you were taking an LSAT?

# It is far too late in the day to be answering the Sphinx's riddles.


# ---------------------------------------------------------- #
#### VII. R Programming -> 15. Base Graphics              ####
# ---------------------------------------------------------- #

# TASK: dim(), names(), head(), and tail() are all great functions!
# Run each of them on the cars dataset.

# QUESTION: In your own words, describe what each of these functions do and
# why each one might be useful.

dim(mtcars)
# Give dimensions of dataframe. Tells us rows (32) and columns (11). Gives us an idea of the dataset.

names(mtcars)
# Tell us the column names. Give us an idea of what was measured or recorded.

head(mtcars)
# Displays the first few lines of the dataset. Again, gives us an idea of what the dataframe contains and how it begins.

tail(mtcars)
# Displays the last few lines of the dataset. Again, gives us an idea of what the dataframe contains and how it ends.


# TASK: Run the str() function on the cars dataset.

x <- mtcars
?str()
str(mtcars)

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?

# Tells us the information type of each column. (Number, Integer, Character). This gives us an idea of the recorded
# information and helps us realize what analyses/functions/proccesses to use per row/column.

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

# The only thing it will print out is the end value for the "c" object. All the other lines
# are creating objects which just end up in our environment.

# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 

?log

log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000)

# Looking at the help function the 4th option is basically the 1st option reversed.
# So it should spit out a different result.



# III) Use one of R's built in functions to create a new vector that is 
# the entries in numvector arranged in descending order. We have not learned 
# this function, but a combination of Google and function documentation 
# should get you there.
numvector <- c(5,2,3,1,6,8)

newvector <- sort(numvector, decreasing = T)

newvector


# IV) Which elephant weighs more? 
# Convert one’s weight to the units of the other, and store the result in an 
# appropriately-named new variable. Test whether elephant1 weights more than 
# elephant2 using an equation that returns either true or false (1 kg ≈ 2.2 lb).

elephant1_kg <- 3492
elephant2_lb <- 7757

elephant2_kg <- (elephant2_lb/2.205)

elephant1_kg == elephant2_kg

# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?

# It's definitely useful if you haven't ever played around with R in a serious way before!
# It can infodump on you pretty fast, so you need to be cognizant to take it as slow as you need.

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not?

# No strong opinions. It wouldn't have affected my learning, but for the newer students it
# might be more useful?

# REMEMBER: Save and push your script when you're done with this assignment!
