library(tidyverse)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(RColorBrewer)

# ------------------------------------------- #
#### 2.0 Making a heat map!                ####
# ------------------------------------------- #

# Read in the state and USA data set that come with the maps data package. These are 
# data frames that have the information needed for ggplot to construct the US map and
# state maps respectively.
usa <- map_data("usa")
states <- map_data("state") 

# To create our heat map, we will be using a data set that shows the population of 
# each state organized by age group. We will be focusing on adults ages 26-34. 
# Let's read in the csv file by running the following code.
age_pop <- read.csv("age_population_USstates.csv")

# To have usable data for our heat map, we need to combine the the states data frame 
# and age_pop data frame to give ggplot all of the information it needs to make a 
# heat map. That is: numeric information and geographical information that matches it.

# In the following code we tidy the population data frame so it will be able to combine with
# the states data frame.
#   1) Read in the population data set
#   2) Change the location column name to region to match the states data set
#   3) Change all the values in the newly named region column to start with lowercase
#   letters to match the states region column
#   4) Select for the relevant columns, region and population of adults age 26-34
#   5) Change the population data to be numeric (heat maps need numeric values)
age_pop_tidy <- age_pop %>% 
  rename(region = Location) %>% 
  mutate(region = tolower(region)) %>% 
  select(region, Adults.26.34)

age_pop_tidy$Adults_26_34 <- as.numeric(age_pop$Adults.26.34)

# TASK: Combine the states and age_pop data frames using inner_join, using region 
# as the common column
age_pop_states <- inner_join(states, age_pop, by = "region")

# Now that we have the data frames ggplot can use, it's time to start making the heat map!

# First, we need to create a basic map of the outline of the USA. Then put the state borders
# on the map, and finally make it a heat map using our population data!

# All of these steps can be combined to create the following code
#   1) the first two lines after ggplot() make the basic outline of the US map and
#      fixes the aspect ratio.
#   2) the following line adds the state borders
#   3) the following line adds the population data to the map and fill's the states according
#      to it's numeric value on a gradient
#   4) the following line just brings the black outline from the basic US outline back to 
#      the top so it's visible again
#   5) the last line transforms the scale of the population to a log-base-10 scale to
#      better differentiate the states on the color gradient and applies a color palette
#      from the brewer package

ggplot()+
  geom_polygon(data=usa, aes(x=long, y=lat, group=group), color = "black", fill=NA)+
  coord_fixed(1.3)+
  geom_polygon(data=states, aes(x=long, y=lat, group=group), fill=NA, color="white")+
  geom_polygon(data=age_pop_states, aes(x=long, y=lat, group=group, fill = Adults.26.34), color = "white")+
  geom_polygon(data=usa, aes(x=long, y=lat, group=group), color="black", fill = NA)+
  scale_fill_gradientn(trans = "log10", colors=rev(brewer.pal(9, "YlGnBu")))

## Note: this is a very basic section outline, once I've seen what Carina has introduced
## them to I will take out repeat information and make my section much more comprehensive 
## with questions and tasks that lead everyone to the final product. Then I'll ask them 
## to create their own heat map with guiding prompts. I started working on that below.

# Time to put it to the test!
# Using what we have done, it's time to make your own heat map following the steps we took
# together. You will be using the Adults age 55-64 column for your heat map so you will first have
# to re-tidy the age_pop data frame so it uses this column instead and assign it to a data frame
# called age_pop_tidier.
