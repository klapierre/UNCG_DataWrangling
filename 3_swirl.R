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
  #press the up arrow key

# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?
  #working directory is the file space in your computer you're working in with R where R will open files, and your workspace is the working environment R is using to store your created objects.

# QUESTION: How do you find help files for a function using R code?
  #the ? function

# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?
  #There are usually multiple ways of doing things, which is helpful as the different ways of doing something may work better for some tasks than others.

# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.
  #a logical vector is a vector containing only logical statements such as TRUE FALSE or NA, a character vector contains strings or non-numerical characters, an integer vector contains only integers, and a numeric vector contains only numeric values.

# QUESTION: What does <= stand for?
  #less than or equal

# QUESTION: What does == stand for?
  #equal to

# QUESTION: What does != stand for?
  #not equal to

# QUESTION: What does | mean in R?
  #"or" or "union", "is A or B true?"

# QUESTION: What does & mean when testing for TRUE/FALSE statements?
  #the & function tests if A and B are true


# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data below, then repeat the code 
# that generated my_data to create my_data2. 
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.
my_data2 <- sample(c(y,z),100)
identical(my_data,my_data2)
  
# QUESTION: Explain why my_data and my_data2 were or were not identical.
  # the sample function pulls a random sample from the two data sets, so its very unlikely that the two samples would happen to be identical

# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)
  # If i was only interested in the average height of adults from ages 20 to 40, i would want to make a subset of average height data

# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue?
  # It can mess up your code without you realizing it, as R just runs with it without detecting an issue

# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?
  # x is rows, y is columns

# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?
dim(1:20) <- c(4,5)
matrix(1:20, nrow=4, ncol=5)

# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
# Did you feel like you were taking an LSAT?
  # I completed this section and yea it felt like an LSAT

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
  # dim gives the dimentions of the data set, names lists the column names, head shows the first 6 rows, tail shows the last 6 rows. Each is useful in displaying information about the data set so that you can be sure youre code involving it is looking at the right values annd objects.

# TASK: Run the str() function on the cars dataset.
str(cars)

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?
  # str gives basic information about the data set such as number of observations, number of variables, names of columns, and a preview of some of the rows.

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
  # this will print 4, as the last lines say b=4, then a=b which means a=4, then c=a which means c=4.

# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 
log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000) #this line will print differently as the order indicates its log base 1000 of 10.



# III) Use one of R's built in functions to create a new vector that is 
# the entries in numvector arranged in descending order. We have not learned 
# this function, but a combination of Google and function documentation 
# should get you there.
numvector <- c(5,2,3,1,6,8)
nv <- sort(numvector)

# IV) Which elephant weighs more? 
# Convert one’s weight to the units of the other, and store the result in an 
# appropriately-named new variable. Test whether elephant1 weights more than 
# elephant2 using an equation that returns either true or false (1 kg ≈ 2.2 lb).

elephant1_kg <- 3492
elephant2_lb <- 7757
elephant1_lb <- elephant1_kg*2.2
elephant2_kg <- elephant2_lb/2.2
elephant1_kg>elephant2_kg
  # elephant 2 weighs more
# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?
  # I think it was helpful, it gave a lot of practice on various R commands and explained some of how the commands work in more plan terms than the help documentation

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not?
  # No, i think a small assignment on weeks 1 and 3 worked well to get in the headspace of working with R before going into a long tutorial like this.

# REMEMBER: Save and push your script when you're done with this assignment!
