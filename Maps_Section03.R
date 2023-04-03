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
  geom_point(data = testData, aes(x = LONGITUDE, y = LATITUDE))

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


# Read in the data set we are going to use (starbucks_2018_11_12.csv)
# We only want the Starbucks in US and we only want the columns "name", "latitude", and "longitude"
starb <- read.csv("starbucks_2018_11_12.csv", stringsAsFactors = TRUE) %>% 
  subset(country == "US") %>% 
  select(state, name, latitude, longitude)

# Task:
# Now tidy up the data so that we are working with only the Starbucks found in New York!
# Be sure to name the data set "starb_NY"


# We do this because to plot points on a map, we need to know the latitude and longitude.
# Sometimes we have to figure this out by hand or by using packages to figure this out for us.
# In this case, the csv file came with the latitude and longitude already included!


# Now we will learn how to plot points onto our graphs
# first we will load our map as we learnt in the previous sections
# feel free to customize the map and make it your own!

ggplot() +
  geom_polygon(data = NY, aes(x=long, y=lat, group=group), fill = "lightblue", col = "black") +
  coord_fixed(1.5)

# Task:
# Now we are going to add our coordinates from the starb_NY
# to do this we are going to use "geom_point", just like from the example part 1
# Be sure to:
#   include the data set we are inserting (starb_NY)
#   specify that: x=longitude & y=latitude



# Congratulations!
# We can adjust the color, size, and shape of our data points too to make it look
?geom_point
# here is a line of code which you can play around with
# change the size, the color, and the shape until the map looks how you want it to
# You can Google the different shapes you can have for your points (there are 25 shapes)

ggplot() +
  geom_polygon(data = NY, aes(x=long, y=lat, group=group), fill = "lightblue", col = "black") +
  coord_fixed(1.5) +
  geom_point(data = starb_NY, aes(x=longitude, y=latitude), color = "#Fe019a" , size = 5, shape = 25)


# Final task
# Map out the Starbucks in California
# Be sure to personalize it!



############
#Answer Key#
############
# Task:
starb_NY <- starb %>% 
  subset(state == "NY")


# Task
ggplot() +
  geom_polygon(data = NY, aes(x=long, y=lat, group=group), fill = "lightblue", col = "black") +
  coord_fixed(1.5) +
  geom_point(data = starb_NY, aes(x=longitude, y=latitude))


ggplot() +
  geom_polygon(data = NY, aes(x=long, y=lat, group=group), fill = "lightblue", col = "black") +
  coord_fixed(1.5) +
  geom_point(data = starb_NY, aes(x=longitude, y=latitude), color = "red", size = 1, shape = 21)


# Final Task:
starb_CA <- starb %>% 
  subset(state == "CA")

CA <- state %>% 
  filter(region == "california")

ggplot() +
  geom_polygon(data = CA, aes(x=long, y=lat, group=group), fill = "lightblue", col = "black") +
  coord_fixed(1.5) +
  geom_point(data = starb_CA, aes(x = longitude, y = latitude))

ggplot() +
  geom_polygon(data = CA, aes(x=long, y=lat, group=group), fill = "lightblue", col = "black") +
  coord_fixed(1.5) +
  geom_point(data = starb_CA, aes(x = longitude, y = latitude, color = "red"), size = 1, shape = 7)



# Notes (ignore for final project)

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