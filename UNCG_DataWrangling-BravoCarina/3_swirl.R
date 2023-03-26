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
# You should now be able to navigate to the R Programming Course and the modules below.

# ---------------------------------------------------------- #
#### I. R Programming -> 1. Basic Building Blocks         #### 
# ---------------------------------------------------------- #
# QUESTION: What would you do to get back a line of code you previously ran
# from your console without retyping the whole thing again?
#Use the up arrow to view all commands previously used

# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?
#Working directory is the "address" of the file, local space are the 
#objects you have loaded to work with

# QUESTION: How do you find help files for a function using R code?
#By placing a question mark in front of the function you will use


# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?
#Yes. Because you can always use the one that is more intuitive for you.

# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.
#Logical vector = objects that have values that indicate if a condition
#is fulfilled or not, or if it is undefined

# QUESTION: What does <= stand for? It tells R the type of object to create and 
#gives it a value.

# QUESTION: What does == stand for? 
#It indicates a boolean operator. It shows that the values on the left and
#right sides of these == are the same.

# QUESTION: What does != stand for? It is a negative statement. That means that
#it negates whatever result was given. TRUE!= FALSE.

# QUESTION: What does | mean in R? It is the equivalent to OR. That means that
#it can direct the flux of operations depending on the conditions fulfilled.

# QUESTION: What does & mean when testing for TRUE/FALSE statements?
#This stands for AND. For example when data needs to fulfill two (or more)
#conditions.

# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data below, then repeat the code 
# that generated my_data to create my_data2. 
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.
#> x <- c(44, NA, 5, NA)
#> y <- rnorm(1000)
#> z <- rep(NA, 1000)
#> my_data2 <- sample(c(y,z), 100)
#identical(my_data, my_data2)
#> my_na <- is.na(my_data)





# QUESTION: Explain why my_data and my_data2 were or were not identical.
#Not identical because there are elements in these vectors that are sampled
#from normal distribution and will be picked at random, not always the
#same ones.

# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)
#You can use the subset function to access data only within the needed parameter,
#for example, if we had a list of mRNA expression and we were interested only
#on levels above the value 100, subsetting will result on a dataframe that
#contains only the relevant results. It saves a boat load of time.

# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue?
#Sometimes R may return an answer to a question that shouldn't be asked 
#because it is unable to determine the context or the intent behind the question.

# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?
#The first number is the row number, the second is the column number

# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?
#x <- 1:20
#dim(x) <- c(4,5) 
#my_matrix <- my_vector

# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
#Section completed
# Did you feel like you were taking an LSAT?
#No, because I have never taken LSATs. :)

# ---------------------------------------------------------- #
#### XI. R Programming -> 15. Base Graphics              ####
# ---------------------------------------------------------- #

# TASK: dim(), names(), head(), and tail() are all great functions!
# Run each of them on the cars dataset.
#Done

# QUESTION: In your own words, describe what each of these functions do and
# why each one might be useful.
#These functions let you look at the dataset you will work with without
#having to open the data file itself.
#dim() - returns you the number of rows and columns in your data
#names() - returns the name of the elements in your data 
#head() - returns the first row of a dataset (default number of rows in R is 6)
#tail() - returns the last elements of a dataset (default object number in R is 6)

# TASK: Run the str() function on the cars dataset.

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?
#This function displays the type, size, class, and the contents of your data. 
#It is helpful because it gives all the details or your data so you know what
#would be the best approach to analize it.


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
#If the code above ran the way it is, the returned value would be 4. The 
#reason for that is that R will follow the steps top-to-bottom.

# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 
log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000)
#The code in line 216, log(10,1000) will be different. Because the order of 
#the arguments is incorrect and the arguments were not defined by a name
#to ensure their use in the correct order.


# III) Use one of R's built in functions to create a new vector that is 
# the entries in numvector arranged in descending order. We have not learned 
# this function, but a combination of Google and function documentation 
# should get you there.
numvector <- c(5,2,3,1,6,8)
sorted_numvector <- sort(numvector, decreasing = TRUE)
sorted_numvector

# IV) Which elephant weighs more? 
# Convert one’s weight to the units of the other, and store the result in an 
# appropriately-named new variable. Test whether elephant1 weights more than 
# elephant2 using an equation that returns either true or false (1 kg ≈ 2.2 lb).

elephant1_kg <- 3492
elephant2_lb <- 7757
elephant2_kg <- elephant2_lb / 2.2
elephant1_kg > elephant2_kg

# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?
#I loved this tutorial because it allowed me to go back and try it again
#and introduced language, concepts, and syntax slowly. It was very helpful
#for me to understand how R checks for logic, that has helped me to understand
#some of the mistakes I have made in my own code. I wish there were more modules
#like these which increasing levels of complexity to help me along as I try
#more complex operations with my data.

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not?
#Yes. Because the immediate feedback, interspaced with brief explanations were 
#easier to digest. I would have LOVED to have played around with swirl when
#I was first introduced to R. I felt very confused and discouraged.

# REMEMBER: Save and push your script when you're done with this assignment!
