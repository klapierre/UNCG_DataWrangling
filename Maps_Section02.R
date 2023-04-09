library(tidyverse)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(RColorBrewer)

# ------------------------------------------- #
#### 2.0 Making a heat map!                ####
# ------------------------------------------- #

# We're going to read in the state and USA data set that come with the maps data package. 
# These are data frames that have the information needed for ggplot to construct the 
# US map and state maps respectively. Run the following code.
usa <- map_data("usa")
states <- map_data("state") 

# To create our heat map, we will be using a data set that shows the population of 
# each state organized by age group. We will be focusing on adults ages 26-34. 
# Let's read in the csv file by running the following code.
age_pop <- read.csv("age_population_USstates.csv")

# To have usable data for our heat map, we need to combine the the states data frame 
# and age_pop data frame to give ggplot all of the information it needs to make a 
# heat map. That is: numeric information and geographical information that matches it.

# Here we tidy the population data frame (numeric info) so it will be able to combine with the 
# states data frame (geographic info) with the following steps
#   1) Make the location column match the region column in the states data set
#   2) Select for the relevant columns: region and population of adults age 26-34
#   4) Change the population data to be numeric (heat maps need numeric values)
age_pop_tidy <- age_pop %>% 
  rename(region = Location) %>% 
  mutate(region = tolower(region)) %>% 
  select(region, Adults.26.34)

age_pop_tidy$Adults.26.34 <- as.numeric(age_pop$Adults.26.34)

# TASK: Now that our population data frame only has the data we need and has a matching 
# column with the states data frame, we can combine them using inner_join(), using region 
# as the common column in the "by =" statement
age_pop_states <- inner_join(states, age_pop_tidy, by = "region")

# Now that we have a data frame ggplot can use, it's time to start making the heat map!
# First, you create a basic map of the outline of the USA. Then put the state borders
# on the map, and finally make it a heat map using our population data!

# Here we break it down step by step with example code

# 1) First we make the basic outline of the US map using the usa data frame and use 
# coord_fixed() to maintain the correct aspect ratio. For the US it is recommended to use 1.3
ggplot()+
  geom_polygon(data=usa, aes(x=long, y=lat, group=group), color = "black", fill=NA)+
  coord_fixed(1.3)

# 2) Next we add the state borders to the map using the states data frame. We use fill=NA 
# since we just want the border lines
geom_polygon(data=states, 
             aes(x=long, y=lat, group=group), 
             fill=NA, color="white")

# 3) Then we add the population data to the map using our combined data frame and fill the 
# states according to it's numeric value by using fill = Adults.26.34 in the aesthetic statement
geom_polygon(data=age_pop_states, 
             aes(x=long, y=lat, group=group, fill = Adults.26.34), 
             color = "white")

# 4) Then we bring the black outline from the basic US map back to the top so it's visible again
geom_polygon(data=usa, aes(x=long, y=lat, group=group), color="black", fill = NA)

# 5) The last line transforms the scale of the population to a log-base-10 scale which
# better differentiates the states on the color gradient. Then it applies a color palette
# from the brewer package. The number 9 before the specified palette tells ggplot how
# many colors from the palette we want to use.
scale_fill_gradientn(trans = "log10", colors=rev(brewer.pal(9, "YlGnBu")))

# Here is all of that put together:
ggplot()+
  geom_polygon(data=usa, aes(x=long, y=lat, group=group), color = "black", fill=NA)+
  coord_fixed(1.3)+
  geom_polygon(data=states, aes(x=long, y=lat, group=group), fill=NA, color="white")+
  geom_polygon(data=age_pop_states, aes(x=long, y=lat, group=group, fill = Adults.26.34), color = "white")+
  geom_polygon(data=usa, aes(x=long, y=lat, group=group), color="black", fill = NA)+
  scale_fill_gradientn(trans = "log10", colors=rev(brewer.pal(9, "YlGnBu")))

# Time to put it to the test!
# You will be using the Adults age 55-64 column for your heat map so you will first have
# to re-tidy the age_pop data frame so it uses this column instead and assign it to a data frame
# called age_pop_tidier. Then follow all the steps we took above and make your own map! Make sure to 
# choose a different color palette and feel free to choose your own theme as well!
### Answer: can be done in many ways but here is how I did it
age_pop_tidier <- age_pop %>% 
  rename(region = Location) %>% 
  mutate(region = tolower(region)) %>% 
  select(region, Adults.55.64)

age_pop_tidier$Adults.55.64 <- as.numeric(age_pop$Adults.55.64)

age_pop_states2 <- inner_join(states, age_pop_tidier, by = "region")

ggplot()+
  geom_polygon(data=usa, aes(x=long, y=lat, group=group), color = "black", fill=NA)+
  coord_fixed(1.3)+
  geom_polygon(data=states, aes(x=long, y=lat, group=group), fill=NA, color="white")+
  geom_polygon(data=age_pop_states2, aes(x=long, y=lat, group=group, fill = Adults.55.64), color = "white")+
  geom_polygon(data=usa, aes(x=long, y=lat, group=group), color="black", fill = NA)+
  scale_fill_gradientn(trans = "log10", colors=rev(brewer.pal(9, "Purples")))
