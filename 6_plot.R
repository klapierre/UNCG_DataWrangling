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
### Part 1.0 TIDY THE DATA                                ####                                           
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





























# REMEMBER: Save and push your script when you're done with this assignment!