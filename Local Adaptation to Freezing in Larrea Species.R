---
# Local Adaptation to Freezing in Larrea Species ------------------------------
# author: Mariii Huff
#------------------------------------------------------------------------------#

# Introduction-----------------------------------------------------------------
  
#Larrea species are desert shrubs that occur across a wide geographic range. 
# Populations found at higher latitudes may experience colder temperatures, 
# including freezing events. Understanding how plant populations adapt to 
# different environmental conditions can provide insight into evolutionary 
# processes and climate adaptation.

# The goal of this project is to examine whether patterns in growth enviiroment
# differ between species or across different sites. I hypothesize that growth
# environment will vary amoong locations because growing in different regions 
# experience diifferent environmental conditions such as temperature, soil 
# composition, and water availability. 

# To find an appropriate dataset, I queried the Environmental Data Initiative
# website. Local Adaptation to Freezing in High and Low Latitude Populations of L. tridentata
# is the title of the dataset.
# Here is the link to the website: https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-sev.227.275475

# LOAD THESE PACKAGES
library(tidyverse)
library(ggplot2)
library(dplyr)
library(readr)

# QUESTION: Why are data visualization tools important in biological research?
# TASK: What types of tasks does dplyr() function helps with? 

#------------------------------------------------------------------------------#
#IMPORT DATA -------------------------
#------------------------------------------------------------------------------#

# Read this data. Make sure to save this dataset to your working directory.
# Now, run this code. 
larrea <- read.csv("sev227_larreafreeze_20140107.csv")

# QUESTION: How many observations are in the dataset? How mant variables are 
# included?

# Want to check what the data looks like; run these codes. 
# These let you see variables, missing values, and data types. 
head(larrea)
str(larrea)
summary(larrea)

#-----------------------------------------------------------------------------#
# INSPECT THE DATA----------------------
#-----------------------------------------------------------------------------#

# Let's explore this dataset structure. 
# TASK: Identify some of the important variables & look for any missing data.

# QUESTION: What variables are available for analysis? 
# Which variables relate to species or environment? Are there any missing values
# in the dataset? 

#------------------------------------------------------------------------------#
# TIDY THE DATA------------------------
#------------------------------------------------------------------------------

# Now it time too clean up our dataset and make it more cleaner. 
# Remove rows with missing values in key variables.
# Let's run this code. 
clean_data <- larrea %>%
  filter(is.na(species)) %>%
  filter(is.na(latitude)) %>%
  filter(is.na(growth_environment))
  
# QUESTION: Why is data cleaning important before analysis? How many observations
# remain after cleaning? 

#------------------------------------------------------------------------------#
# CREATE SUMMARY STATISTICS --------------------
#------------------------------------------------------------------------------#

# Now that we cleaned up the dataset and it's pretty and neat. Let's get a summary 
# on the dataset also. 

#TASK: Summarize the observations by species and environment. Group the data by
# species and environment. Count observations in each category. 

# QUESTION: Which species has the most observations? Which growth environment
# appears most frequently? 

#------------------------------------------------------------------------------#
# GROWTH ENVIRONMENT DISTRIBUTION --------------------------
#------------------------------------------------------------------------------#

# Now for the fun part! Le's makes some graphs! 
# Refer to previous assignments for the functions to use. 

#TASK: Create a bar graph; label the axes (x = Growth Environment y = Count) and 
# the title of the graph should be called " Distribution of Growth Environments"

# QUESTION: Which growth environment has the most observations? Are some 
# environments underrepresented? 

#------------------------------------------------------------------------------#
# SPECIES VS. GROWTH ENVIRONMENT -----------------------
#------------------------------------------------------------------------------#

# Like previous let's make a scatterplot but this time we are comparing two columns
# (species and growth environment)

# TASK: Make a scatterplot & compare species across environments.

# QUESTION: Do species occur in similar environments? Does one species appear 
# more often in a certain environment? 

#------------------------------------------------------------------------------#
# LATITUDE PATTERNS -----------------------------------
#------------------------------------------------------------------------------#

# One last time I promise you. We are now going to explore the geographic patterns

#TASK: Make a histogram; label the axes ( x = Latitude y = Count) and make the 
# title named "Latitude Distribution of Growth Environments"

# QUESTION: Do certain growth environments occur more at higher or lower latitudes?
# What geographic patterns appear in the dataset? 

#------------------------------------------------------------------------------#
# DISCUSSION ---------------------------------
#------------------------------------------------------------------------------#

# Now we are coming to an end of the assignment. Let's interpret your results. 

# TASK: Summarize patterns observed in the graphs and connect the results to
# your hypothesis. 

# QUESTION: Did the results support your hypothesis? 
# How might environmental differences influence plant populations?
# What limitations exist in the dataset?
# What future research could explore this question further? 
