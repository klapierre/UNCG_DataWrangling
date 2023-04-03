#--------------------------------#
#Section 3: Plotting Points on a Map
#--------------------------------#

# Prep by instaling these packages and loading these libraries if you haven't already
install.packages(c("ggplot2", "devtools", "dplyr", "stringr"))
install.packages(c("maps", "mapdata"))
devtools::install_github("dkahle/ggmap")

library(tidyr)
library(dplyr)
library(ggplot2)

library(ggmap)
library(maps)
library(mapdata)
library(usmap)

# We are going to be learning how to plot different points on a map
# let's test out plotting a point on the map of the US
# run this line of code to get a data point
testData <- data.frame(LATITUDE = 20.31557, LONGITUDE = -102.42547)

# Notice how we need to have longitude and latitude in order to make this data point

# Load the US Map
p <- plot_usmap(regions = "state") 
# and then plot the data point!
p + 
  geom_point(data = testData, aes(x = LONGITUDE, y = LATITUDE), color = "red")

#Notice that the longitude and latitude are operating as the x and y coordinates for the map!
# pretty cool, right?
# let's try stepping it up a little


# Task:
# We are going to plot out the different Starbucks found in New York.
# We need a map to plot our information on.
# To load a map of New York, run the following codes:
state <- map_data("state") 

NY <- state %>% 
  filter(region == "new york")


# Task:
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
# Hint 3: You would have to load the data sets and give them a unique name




############
#Answer Key#
############
# Task:
starb <- read.csv("starbucks_2018_11_12.csv", stringsAsFactors = TRUE) %>% 
  subset(city == "New York") %>% 
  select(state, name, latitude, longitude)


# Final Task:
starb_CA <- read.csv("starbucks_2018_11_12.csv", stringsAsFactors = TRUE) %>% 
  subset(city == "New York") %>% 
  select(state, name, latitude, longitude)

ggplot() +
  geom_polygon(data = NY, aes(x=long, y=lat, group=group), fill = "lightblue", col = "black") +
  coord_fixed(1.5) +
  geom_point(data = starb, aes(x = longitude, y = latitude, color = "red"), size = 0.05, shape = ".")



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



# starbucks of the us

starb_US <- read.csv("starbucks_2018_11_12.csv", stringsAsFactors = TRUE) %>% 
  subset(country == "US") %>% 
  select(state, name, latitude, longitude)
