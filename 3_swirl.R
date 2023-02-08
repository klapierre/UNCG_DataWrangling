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

##The up arrow can be used!

# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?

##Your working directory stores files related to your project while your local
##workspace can also variables as defined by R.

# QUESTION: How do you find help files for a function using R code?

#Using ? before the function name will open a help window.

# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?

#There are many differnt ways to do things in R. Sometimes, certain setups could
#be faster than others. Perhaps it may make more sense to you as well or follow
#a specific format that you prefer.

# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.

#logical vectors contain logical values. Character vecotors aren't logical and
#just contain characters such a names or labels. Numeric vectors contain numbers

# QUESTION: What does <= stand for?

#Less than or equal to

# QUESTION: What does == stand for?

#Exactly equal to

# QUESTION: What does != stand for?

#Not equal to

# QUESTION: What does | mean in R?

# At least one is true

# QUESTION: What does & mean when testing for TRUE/FALSE statements?

#Both must be true to be true.

# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data below, then repeat the code 
# that generated my_data to create my_data2. 
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.
my_data <- sample(c(y,z), 100)

my_data2 <- sample(c(y,z), 100)

# QUESTION: Explain why my_data and my_data2 were or were not identical.

#Not identical. This is because we are taking random sample each time.
# Therefore, we would expect they would be different as the chance of
#two random samples being the same are likely small.

# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)

#Perhaps we take an entire summer of field data regarding aboveground biomass for a plant.
#If we decide to investigate early summer growth only, we can take subset
#of our data and examine only the early months.

# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue?

#It may be out of the bounds of the vector that you are working with.
# This potentially could "break" your code.

# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?

#X is rows, y is columns

# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?

#It could be done directly with matrix(1:20,4,5) or create a vector by  my_vector <- 1:20 and then add dimension 

# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
# Did you feel like you were taking an LSAT?

#Done...yes, feels like law school.

# ---------------------------------------------------------- #
#### VII. R Programming -> 15. Base Graphics              ####
# ---------------------------------------------------------- #

# TASK: dim(), names(), head(), and tail() are all great functions!
# Run each of them on the cars dataset.

# QUESTION: In your own words, describe what each of these functions do and
# why each one might be useful.

#Dim() gives us the dimensions of something. Use ful for determining what type of data
#we are dealing with.

#names() gives us names in an object. Useful for understanding how data is
#labeled in a certain object.

#head() gives us the beginning or head of an object. Use for previewing
#the setup of data without viewing the entire set.

#tail() gives us the end of an object. Useful for rapidly viewing the end
#of an object.

# TASK: Run the str() function on the cars dataset.

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?

#Str() provides an overview of everything in an object. This is useful
#because it allows us to easily analysis the structure of an object. 

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

#On line 211 "b" is assigend the value of 4, wiping it of any previous
#value it had and replacing its value with 4. That value of 4 is then
#stored in a using a <- b. "a", which is now equal to 4, is then contained 
# in c. This means c is now equal to 4. 


# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 
log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000)

#log(10, 1000) will produce a different result because x is being to 10
#and the log being set to 1000. 



# III) Use one of R's built in functions to create a new vector that is 
# the entries in numvector arranged in descending order. We have not learned 
# this function, but a combination of Google and function documentation 
# should get you there.
numvector <- c(5,2,3,1,6,8)

numevector2 <- sort(numvector, decreasing=TRUE, na.last=NA)


# IV) Which elephant weighs more? 
# Convert one’s weight to the units of the other, and store the result in an 
# appropriately-named new variable. Test whether elephant1 weights more than 
# elephant2 using an equation that returns either true or false (1 kg ≈ 2.2 lb).

elephant1_kg <- 3492*2.2
elephant2_lb <- 7757

elephant2_lb > elephant1_kg

#True. Elephant1 weights more
# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?

#Very helpful! Great introduction to R. More hints could be an improvement. 

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not?

#No. I think getting familiarized with R and Github prior to this was fine. Either way,
#there will be a bit of a learning curve.

# REMEMBER: Save and push your script when you're done with this assignment!
