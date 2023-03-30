# Tidyverse does not play well with the "map" package
library(tidyverse)


library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

# Ok for this last part of the assignment we are going to brush up on our geography.
# Don't get too excited. ;)

# We first need to make a base map that is the entire earth.
# Go ahead and do the same process as you did above but use "world" instead.

?map

world <- map_data("world")

ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3) 

ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group), fill = "blue", col = "black") + 
  coord_fixed(1.5) + geom_point(data = pines, aes(x = Longitude, y = Latitude), color = "yellow", size = 1)

]# Nice what was your output?

# Answer: It better be a map

# Ok now practice changing the outline and fill colors to something other than the default.

# The same as above but ya know. A little different and most likely uglier.

caps <- read.csv("country-capital-lat-long-population.csv")

