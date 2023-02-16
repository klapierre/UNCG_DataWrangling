# ---------------------------------------------------------- #
#### MODULE 3: Plot some data!                            ####               
# ---------------------------------------------------------- #

## OBJECTIVE:
# 1. To develop a "grammar of graphics".
# 2. To become comfortable using ggplot2 for exploratory data visualization.


# ---------------------------------------------------------- #
#### SET UP:                                              ####
# ---------------------------------------------------------- #
# REMINDER: In RStudio, open the Rproject for our course (UNCG_DataWrangling), 
# pull any changes from GitHub, and navigate to the branch you created for 
# yourself (just a single branch for the whole semester) in RStudio's Git tab.
# Open this week's assignment in this new branch to complete and submit on GitHub.
# Ideally, you'll commit your answers a bit at a time as you work through
# this assignment, rather than committing all at once at the end.


# ---------------------------------------------------------- #
#### UNDERSTANDING A GRAMMER OF GRAPHICS                  ####
# ---------------------------------------------------------- #

# About a grammar of graphics:
# The author of ggplot2, Hadley Wickham, discusses his graphing philosophy in his 
# paper titled Grammar of Graphics: http://vita.had.co.nz/papers/layered-grammar.pdf

# What is a grammar of graphics?
# A grammar of graphics is a vocabulary that enables us to concisely describe the 
# components of a graph. This allows us to move beyond named graphics (e.g., a "bar 
# graph") and gain insight into the structure that underlies graphics.

# Components that make up a graph include:
## Data and aesthetic mapping
## Geometric objects
## Scales
## Facet specification
## Statistical transformations
## The coordinate system (position)

# Together, the data, mapping, statistical transformation and geometric object 
# form a layer. A plot may have multiple layers; for example, overlaying points
# representing data with a smoothed line representing a best-fit model.

# Thus, a layered grammar of graphics builds a plot this way:
## A default dataset and set of mappings from variables to aesthetics.
# (1) One or more layers, each containing one of the following:
#     (a) geometric object, 
#     (b) statistical transformation,
#     (c) position adjustment, 
#     (d) dataset, 
#     (e) a set of aesthetic mappings.
# (2) One scale for each aesthetic mapping.
# (3) A coordinate system (ie, Cartesian, Polar, etc).
# (4) The facet specification.


# TASK: We will be using the ggplot2 package for graphing. Fortunately, ggplot2 
# is nested within the tidyverse package (along with many others).
# Start by writing code to load the tidyverse library.
# HINT: see the end of assignment #1 if you forgot how to load a package.


# ---------------------------------------------------------- #
### PART 1.0: TIDY THE DATA                               ####                                           
# ---------------------------------------------------------- #

# This week we'll be starting with a dataset of fish that were found at different
# locations in the Spokane river in 2013. We will focus on the Redband Trout, which
# is a subspecies of Rainbow Trout. Redband Trout have been facing population
# declines due to habitat loss and competition with non-native species.

# HINT: Refer back to the 4_wrangle.R and 5_transform.R assignments if you forget
# how to achieve any of the tasks in this section.

# TASK: Write code to perform the following steps within one pipeline:
# (1) Load the csv file "LowerSpokaneFish.csv" and assign it to a 
#     dataframe called redband.
# (2) Filter the dataframe to only include observations that have "RB" in the
#     Species column.
# (3) Further filter the dataframe to include only fish that have been aged
#     by removing any observations where ScaleAge is NA.
redband <- read.csv(file = "LowerSpokaneFish.csv") %>% 
  filter(Species=='RB', !is.na(ScaleAge))


# ---------------------------------------------------------- #
### PART 1.1 AESTHETICS AND MAPPING                       ####
# ---------------------------------------------------------- #

# We will work through this file to build up our graphic slowly, one component
# at a time.

# MOTIVATION: There is often a length requirement for what fish you can take
# for recreational fishing. We want to look at the distribution of lengths of 
# Redband Trout in the lower Spokane River.

# GOAL: Build a histogram of lengths of Redband Trout in the lower Spokane River.

# The first thing we need is a coordinate system. Run the following code to make
# a blank graph with a coordinate system.
ggplot()

# Now we want to add in an aesthetic (aes). In ggplot2, an "aesthetic" refers to 
# something you can see, such as an axis, a point, a bar, or a line.
# Because we are going to build a histogram, we only need an x-axis aesthetic.
# Run the following code to generate our x=axis based on the Length column
# in our redband dataframe.
ggplot(redband, aes(x = Length))

# QUESTION: What was generated by running the code above? Why is there no data 
# included in the output?


# ---------------------------------------------------------- #
#### PART 1.2 GEOMETRIC OBJECT - HISTOGRAM                ####
# ---------------------------------------------------------- #

# Now let's add in the data! Run the following code to include a geometric
# object (geom). In this case, the geometric object is a histogram.
ggplot(redband, aes(x = Length)) + 
  geom_histogram()
# NOTE: When using the ggplot function, we use the + to indicate passing from
# one aesthetic or geometric object to the next. No pipes here!

# QUESTION: What was generated by running the code above? What do you notice 
# about the labels for the x- and y-axes?


# When you run the above line of code, you get a message that tells you
# bins=30 and that you can pick better values with `binwidth`. Let's try this!
# Run the code below to make a new graph below where we change binwidth to be 50.
# HINT: Check out ?geom_histogram to pull up the help page.
ggplot(redband, aes(x = Length)) + 
  geom_histogram(binwidth=50)

# QUESTION: What changed about our output when we asked for binwidth=50?


# TASK: Some other factors might affect this distribution of redband length?
# Make another histogram that plots the distribution of ScaleAge for the redband
# dataframe.


# QUESTION: If ScaleAge represents how old the fish are in years, what do you notice
# about the Redband Trout population based on the figure you generated?


# TASK: Fish weight is also an interesting variable. Make a histogram that plots
# the distribution of Weight for the redband dataframe.


# QUESTION: What warning message is generated in the console when you create the 
# weight histogram? What does this warning message mean? Do you think it is ok 
# to proceed or should you alter your code to get rid of this warning?


# ---------------------------------------------------------- #
#### PART 1.3 GEOMETRIC OBJECT: POINTS                    ####
# ---------------------------------------------------------- #

# QUESTION: In the code below, what is the dataframe being examined?
# What are the aesthetics? What will the resulting graph be plotting?
ggplot(redband, aes(x=ScaleAge, y=Length))


# When we start, we tell ggplot that we want certain aesthetics (x- and y-axis).
# But without specifying a geometric object (what shape to add to the plot), we won't
# see any data! Let's add a new type of geometric object (points!) by running the 
# following code:
ggplot(redband, aes(x=ScaleAge, y=Length)) + 
  geom_point()

# QUESTION: Based on the figure that was generated from the code above, 
# what would you conclude about the relationship between fish age and length?


# TASK: Write your own code to visualize the relationship between Redband 
# length and weight.


# ---------------------------------------------------------- #
#### PART 1.4 ADDING AESTHETICS TO GEOMETRIC OBJECTS      ####
# ---------------------------------------------------------- #

# We can also add aesthetics to any geometric object!
# For example, we can integrate the relationships we plotted above among Redband
# age, length, and weight by coloring points on our figure plotting length vs weight
# based on ScaleAge. To do this, we have to nest an aes() statement within the 
# geom_point() statement. Try it out by running the following code:
ggplot(redband, aes(x=Length, y=Weight)) + 
  geom_point(aes(color=as.factor(ScaleAge)))

# TASK: Copy and paste the code above to make the same graph, but this time remove
# as.factor() from the part where we color by ScaleAge.


# QUESTION: What differs between the graph where ScaleAge was wrapped in the as.factor()
# statement and the graph where you removed as.factor()? Why?





























# REMEMBER: Save and push your script when you're done with this assignment!