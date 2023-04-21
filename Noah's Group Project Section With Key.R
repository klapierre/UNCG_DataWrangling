# --------------------------------------------------------------------------- #
####                      Section 4: *THE* Titanic                         ####
# --------------------------------------------------------------------------- #


# Now that you've had some practice with gganimate, it's time to really test your knowledge!
# 
# But first, lets get some new data to mess around with.
# Make sure you have the "titanic.csv" file downloaded from the github branch or Canvas.
# Then load it into R as an object and name it "rawTitanic"

rawTitanic <- read.csv("titanic.csv")

# This data is a passenger list for the RMS Titanic, including information on the
# different passengers' names, if they survived, sex, age, number of siblings/spouses aboard, number of parents/children aboard, ticket number, ticket fare,
# cabin number, passenger class, and where they boarded the ship.

# Take a moment to look it over and see how the different variables are named
# Note that siblings/spouses (SibSp) and parents/children (Parch) are only 2 columns rather than 4

# Question: What problems could the SibSp and Parch columns make for us due to 
# how they are recorded?

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####
# Answer: something along the lines of how you can't separate number of siblings 
# from spouses or parents from children. Or, any other problems that make sense
###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####

# Question: What columns seem to be missing information?

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####
# Answer: The age column has some N/As and the cabin column is missing a lot of entries.
###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####


# Now, as we can see, this data is pretty untidy with lots of empty cells and
# columns that are tricky to work with. 

# Task: Make a new dataframe called "titanicTidyAge" and have it only include the
# PassengerId, Survived, Pclass, Name, Sex, and Age columns.
# Then filter it to remove any N/A values in any of the cells. Try using the 
# na.omit() function

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####
# Answer: 
titanicTidyAge <- rawTitanic %>% 
  select(c(PassengerId, Survived, Pclass, Name, Sex, Age)) %>% 
  na.omit()

###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####

