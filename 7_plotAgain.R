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


# ---------------------------------------------------------- #
#### 1.0                                           ####
# ---------------------------------------------------------- #



# REMEMBER: Save and push your script when you're done with this assignment!