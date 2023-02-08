setwd("D:/School Stuff/Graduate Stuff/Graduate Classes/Spring 2023/UNCG_DataWrangling")
swirl()

Will
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
#You can create a variable to represent that value/line of code or press the up arrow to recycle a previous code



# ---------------------------------------------------------- #
#### II. R Programming -> 2. Workspace and Files          #### 
# ---------------------------------------------------------- #
# QUESTION: What is the difference between your working directory
# and your local workspace?
#The working directory is where your R files will be stored, and where other data will be pulled from

# QUESTION: How do you find help files for a function using R code?
#? function should pull up the help files for functions



# ---------------------------------------------------------- #
#### III. R Programming -> 3. Sequences of Numbers        #### 
# ---------------------------------------------------------- #
# QUESTION: In R, is there usually just one way or many different
# ways of doing the same thing? Why might this be useful?
#Generally, there are multiple different ways of doing the same thing
#This can allow for a lesser need for overall knowledge to use R effectively, and for dynamic use of the program



# ---------------------------------------------------------- #
#### IV. R Programming -> 4. Vectors                      #### 
# ---------------------------------------------------------- #
# QUESTION: Describe in your own words the difference between a 
# logical vector, a character vector, an integer vector, and a 
# numeric vector.
#Logical vectors contain binary logic: Yes, No or NA


# QUESTION: What does <= stand for?
#Less than or equal to

# QUESTION: What does == stand for?
#Exact equality

# QUESTION: What does != stand for?
#Inequality

# QUESTION: What does | mean in R?
#Or

# QUESTION: What does & mean when testing for TRUE/FALSE statements?
#And



# ---------------------------------------------------------- #
#### V. R Programming -> 5. Missing Values                ####  
# ---------------------------------------------------------- #

# TASK: Copy your assignment of my_data below, then repeat the code 
# that generated my_data to create my_data2. 
my_data<- sample(c(y,z),100)
# Using the R function identical(), test whether my_data and my_data2 
# are identical.
identical(my_data,my_data2)
 FALSE
# Hint: You can always Google or in R type ?identical() to get
# help on using this (or any) function.


# QUESTION: Explain why my_data and my_data2 were or were not identical.
# Both my data 1 and 2 are random samples of a population. These vectors cannot be identical if randomly sampled

# ---------------------------------------------------------- #
#### VI. R Programming -> 6. Subsetting                   ####
# ---------------------------------------------------------- #
# QUESTION: Subsetting can be an amazing thing! Describe one real world
# scenario where you might want to subset a dataset. (you can make up anything)
When grinding a lot of biomass for a small sample, you may subset the biomass to get a representative of the entire plot
 
# QUESTION: Sometimes R gives you an answer to a question that shouldn't be
# asked (e.g., when you asked for the 3000th variable in your vector x). Why
# might this be an issue?
R doesnt stop me from asking for it, but that value is unavailable. Formulas dependent on a static number may stop working if the data is altered at all

 
 
# ---------------------------------------------------------- #
#### VII. R Programming -> 7. Matrices and Data Frames    ####
# ---------------------------------------------------------- #
# QUESTION: In the code matrix[x,y], which letter represents the rows? 
# Which letter represents the columns?
y

# QUESTION: What are two different ways you could assign the numbers 1-20
# into a matrix with 4 rows and 5 columns?
my_vector<-1:20  dim(my_vector)<- c(4,5)
my_matrix2<- matrix(1:20, nrow=4, ncol=5)


# ---------------------------------------------------------- #
#### VIII. R Programming -> 8. Logic                      ####
# ---------------------------------------------------------- #
# TASK: Leave a comment that you have completed this section. 
# Did you feel like you were taking an LSAT?
# I have completed this section. Yes, I absolutely did


# ---------------------------------------------------------- #
#### VII. R Programming -> 15. Base Graphics              ####
# ---------------------------------------------------------- #

# TASK: dim(), names(), head(), and tail() are all great functions!
# Run each of them on the cars dataset.
dim(cars), head(cars), tail(cars)

# QUESTION: In your own words, describe what each of these functions do and
# why each one might be useful.
Dim allows us to understand the dimensions of our matix. This may inform you on how to format additions to the data. Head and tail allow us to look at the first and last datapoints, respectively. This can give us a quick snapshot of the beginning and end of our matices.

# TASK: Run the str() function on the cars dataset.

# QUESTION: In your own words, describe what the str() function does.
# Why might this be useful?
str includes the roles of both dim and head. It lists th first variables and dimesntions of the matrix. This allows for a more comprehensive snapshot than just dim or head on their own.

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
It sets up three variables: a, b and c. It eventually sets them all equal to 4.


# II) Three of the following lines produce the same result. 
# Without running the code, which one will produce a different result than the
# others? Please explain why. 
# HINT: The helpfile for the log function may be useful. 
log(x = 1000, base = 10)
log10(1000)
log(base = 10, x = 1000)
log(10, 1000)

#log(10,1000) will produce a different result. The other formulas are saying that the base of the log is 10. Even if out of order, they are specifying so that R does not mistake the x form the base. The last formula does not do that, and has the x as the base, and vice-versa.


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
elephant2_kg<- elephant2_lb/2.2
elephant1_kg>elephant2_kg
elephant 1 is lighter than elephant 2

# ---------------------------------------------------------- #
#### PART 3: FEEDBACK                                     ####
# ---------------------------------------------------------- #
# QUESTION: What did you think of the Swirl tutorial? Was it helpful? Why 
# or why not?
I think that the tutorial was very helpful and informative. It was long, but it was also comprehensive.

# QUESTION: Would you have preferred to split the Swirl tutorial over weeks
# 1 and 3 of the class instead of the week 1 assignment you previously 
# completed? Why or why not?
Probably, yes. Just time reasons
# REMEMBER: Save and push your script when you're done with this assignment!
