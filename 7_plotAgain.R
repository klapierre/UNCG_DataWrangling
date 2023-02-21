# ---------------------------------------------------------- #
#### MODULE 3: Plot even more data!                       ####               
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

# Reminder of some helpful resources for graphing in R:
# ggplot Cookbook: http://www.cookbook-r.com/Graphs/
# Official ggplot2 Book: https://ggplot2-book.org/
# Themes in ggplot2: https://ggplot2-book.org/polishing.html#themes

# In ggplot2, aesthetic means “something you can see”. Each aesthetic is a
# mapping between a visual cue and a variable.
# Examples include:
# position (i.e., on the x and y axes)
# color (“outside” color)
# fill (“inside” color)
# shape (of points)
# line type
# size

# Each type of geometric object (geom) accepts only a subset of all aesthetics.
# Refer to the geom help pages to see what mappings each geom accepts. Aesthetic
# mappings are set with the aes() function.

# TASK: We will be using the ggplot2 package for graphing. Fortunately, ggplot2 
# is nested within the tidyverse package (along with many others).
# Start by writing code to load the tidyverse library.
# HINT: see the end of assignment #1 if you forgot how to load a package.


# TASK: Write code below to set your theme to black and white and both your major
# AND minor gridlines to element_blank for all plots you'll be making today.
# HINT: Check back to last week's assignment section 1.9 for setting themes for
# all plots.


# ---------------------------------------------------------- #
#### 1.0 CORRELATION                                      ####
# ---------------------------------------------------------- #

# We learned how to make correlations last week, but it never hurts to get
# more practice! Let's start by using a data set built into ggplot2.
# The mpg dataset looks at the gas efficiency of different cars. Run the following
# code to load the data:
data(mpg, package = "ggplot2")

# TASK: Create a scatterplot (i.e., a dot plot) to relate city and highway mileage.
# Color the points by the class of car (class column) and label the x and y axis 
# to be more informative (City Mileage (MPG) vs Highway Mileage (MPG)).
# HINT: Refer back to last week's assignment or the ggplot help resources if you 
# forget how to make a scatterplot.


# Looks alright, but the graph may be hiding some information...
# QUESTION: How many data points are in the mpg dataframe?


# QUESTION: Approximately how many dots are in the graph you just made? How does
# that compare to the number of observations in the dataframe?


# Try another correlation-focused geom that addresses this problem by running
# the following code:
ggplot(data=mpg, aes(x=cty, y=hwy)) + 
  geom_jitter()

# TASK: The default in geom_jitter is to jitter (or slightly move) the points away
# from each other in both the x and y directions. Check the help file for geom_jitter
# and write code below to make a graph where you jitter points in only the x-dimension
# by 0.5.


# ---------------------------------------------------------- #
#### 2.0 DEVIATION                                        ####
# ---------------------------------------------------------- #

# Deviations are used to compare variation in values between small number of 
# items (or categories) with respect to a fixed reference.

# Whether the graphical type is a deviation graph or a composition graph (or a 
# ranking graph) may depend on the underlying data structure.

# We used geom_bar() last week with factor data to create a bar graph. But
# geom_bar() is a bit tricky because it can make EITHER a bar graph or a histogram
# depending on the data you give it. The default of geom_bar() is to set stat to 
# count so if you give it just a continuous x value, it will make a histogram. Try
# it with the following code:
ggplot(data=mpg, aes(x=hwy)) + 
  geom_bar()

# In order to have the geom create bars and not a histogram, you must:
# 1) Set stat = identity
# 2) Provide both an x and a y inside the aes(), where x is either a character 
# or factor and y is numeric.

# TASK: Create a dataframe of summary statistics for the mpg data, calculating the
# mean, standard deviation, and standard error for highway mpg grouping by class.
# HINT: Look back at the Transform assignment if you forget how to summarize the
# data. Also, standard error = 1.96*standard deviation.


# TASK: Create a bar graph showing the average highway MPG on the y-axis and 
# car class on the x-axis. Fill the bars by class. Add in error bar caps that are 20%
# the width pf the bars. Rename the x and y axes to be more meaningful.
# HINT: Don't forget to change stat from the default in your geom_bar() statement!


# REMEMBER: Save and push your script when you're done with this assignment!