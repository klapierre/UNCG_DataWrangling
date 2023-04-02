#--------------------------------#
#Section 3: Plotting Points on a Map
#--------------------------------#

# Prep by instaling these packages and loading these libraries if you haven't already
install.packages(c("ggplot2", "devtools", "dplyr", "stringr"))
install.packages(c("maps", "mapdata"))
devtools::install_github("dkahle/ggmap")

library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

# Task 1:
# We are going to plot out the different Starbucks found in New York.
# We need a map to plot our information on.
# To load a map of New York, run the following codes:
state <- map_data("state") 

NY <- state %>% 
  filter(group == 37)


# Task 2:
# Read in the data set we are going to use (starbucks_2018_11_12.csv)
# We only want the Starbucks in NY and we only want the columns "name", "latitude", and "longitude"
# tidy it up!


# We do this because to plot points on a map, we need to know the latitude and longitude.
# Sometimes we have to figure this out by hand or by using packages to figure this out for us.
# In this case, the csv file came with the latitude and longitude already included!

world <- map_data("world")


ggplot() +
  geom_polygon(data = state, aes(x=long, y = lat), fill = "blue", col = "black") +
  coord_fixed(1.5) 
  geom_point(data = starb, aes(x = longitude, y = latitude), color = "yellow", size = 0.1)






############
#Answer Key#
############
# Task 1:
starb <- read.csv("starbucks_2018_11_12.csv", stringsAsFactors = TRUE) %>% 
  subset(city == "New York") %>% 
  select(state, name, latitude, longitude)



# Notes

install.packages('tidygeocoder')
devtools::install_github("jessecambon/tidygeocoder")

#In progress:
usa <- map_data("usa") %>% 
  ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)Trials


ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group), color = "black", fill="gray") +
  coord_fixed(1.3) + geom_point(data = starb, aes(x = longitude, y = latitude), color = "yellow", size = 0.1) 
