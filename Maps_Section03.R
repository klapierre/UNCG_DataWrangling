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
library(tidyr)
library(dplyr)

# Task 1:
# We are going to plot out the different Starbucks found in New York.
# We need a map to plot our information on.
# To load a map of New York, run the following codes:
state <- map_data("state") 

NY <- state %>% 
  filter(region == "new york")


# Task 2:
# Read in the data set we are going to use (starbucks_2018_11_12.csv)
# We only want the Starbucks in NY and we only want the columns "name", "latitude", and "longitude"
# tidy it up!


# We do this because to plot points on a map, we need to know the latitude and longitude.
# Sometimes we have to figure this out by hand or by using packages to figure this out for us.
# In this case, the csv file came with the latitude and longitude already included!


# Now we will learn how to plot points onto our graphs

ggplot() +
  geom_polygon(data = NY, aes(x=long, y=lat, group=group), fill = "lightblue", col = "black") +
  coord_fixed(1.5) +
  geom_point(data = starb, aes(x = longitude, y = latitude, color = "red"), size = 0.05, shape = ".")


# Final task
# Map out the Starbucks in Canada
# Hint 1: Canada is abbreviated as "CA" under "country" in the Starbucks csv
# Hint 2: Canada is listed as "Canada" under "region" in the world data




############
#Answer Key#
############
# Task 1:
starb <- read.csv("starbucks_2018_11_12.csv", stringsAsFactors = TRUE) %>% 
  subset(city == "New York") %>% 
  select(state, name, latitude, longitude)


  


# Notes (ignore for final project)
library(ggplot2)
library(usmap)
testData <- data.frame(LATITUDE = 20.31557, LONGITUDE = -102.42547)
p <- plot_usmap( regions = "state") 
p + geom_point(data = testData, aes(x = LONGITUDE, y = LATITUDE), color = "red")
  
library(albersusa) # https://gitlab.com/hrbrmstr/albersusa / https://github.com/hrbrmstr/albersusa
library(ggplot2)
library(sp)

us <- usa_composite(proj = "aeqd")

states_centers <- as.data.frame(state.center)
states_centers$name <- state.name

states_centers <- states_centers[!(states_centers$name %in% c("Alaska", "Hawaii")),]

coordinates(states_centers) <- ~x+y
proj4string(states_centers) <- CRS(us_longlat_proj)
states_centers <- spTransform(states_centers, CRSobj = CRS(us_aeqd_proj))
states_centers <- as.data.frame(coordinates(states_centers))

us_map <- fortify(us, region="name")

ggplot() +
  geom_map(data = us_map, map = us_map, aes(x = long, y = lat, map_id = id), color = "#2b2b2b", size = 0.1, fill = NA) +
  geom_point(data = states_centers, aes(x, y), size = 4, color = "steelblue") +
  coord_equal() + # the points are pre-projected
  ggthemes::theme_map()

#In progress:
usa <- map_data("usa") %>% 
  ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)Trials


ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group), color = "black", fill="gray") +
  coord_fixed(1.3) + geom_point(data = starb, aes(x = longitude, y = latitude), color = "yellow", size = 0.1) 
