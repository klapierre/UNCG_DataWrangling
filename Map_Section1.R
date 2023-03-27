# MAP GROUP   
##make sure to have a list of the errors you encounter while working on your code

#Section 1 (Carina) 
#ggmap, mapdata, maps, ggplot2, dplyr, stringr, maptools
#Libraries to be downloaded
#data set -> country, states and county
#Description of each library
#Description of how to render the US map
#let's try it

#The RStudio "maps" package is useful for creating maps and visualizing geographic data. It gives you access to a wide range of map data, such as political boundaries, topography, and even satellite imagery, which you can use to create custom maps based on your specific needs. 

#To use the "maps" package in RStudio, first install it in the R console by typing 
install.packages('maps')
install.packages('mapproj')

#Once installed, use the command to load the package into your workspace.
library(maps)
library(mapproj)

#For example, you could use the following code to generate a basic map of the world using the "Mercator" projection:
map("world", projection = "mercator")

#In addition to basic map creation, the "maps" package includes functions for adding points, lines, and text to maps, as well as custom legends and color scales.


#Overall, the RStudio "maps" package is a powerful tool for creating maps and visualizing geographic data that can be used in a variety of applications ranging from data analysis and visualization to education and research.

#Rstudio can be used for more than tidying and transforming data. Lets try create a map of the United States ggplot2 and other packages. First, install or load the following libraries:

#


#Load the map data for the United States by typing the following command into the R console:

data("state")
#This will load a dataframe called state that contains the polygon data for each state in the US.
#Create a basic plot of the US map using ggplot2 by typing the following command into the 
ggplot() + 
  geom_polygon(data = state, aes(x = long, y = lat, group = group), fill = "white", color = "black")

#This will create a plot with white polygons representing each state, outlined in black.

#If you want to add additional layers to your plot (such as points or lines), you can do so using the various ggplot2 functions, such as geom_point() or geom_line(). 
#For example, if you wanted to plot the location of major cities in the US, you could use the map_data() function from the ggplot2 package to obtain latitude and longitude data for the cities, and then plot them on the map using geom_point(). Here's an example:

# Load data for major US cities
cities <- map_data("world.cities") %>%
          filter(country.etc == "USA") %>%
          select(long, lat, city)

# Plot the US map with cities overlaid
ggplot() + 
geom_polygon(data = state, aes(x = long, y = lat, group = group), fill = "white", color = "black") +
geom_point(data = cities, aes(x = long, y = lat), size = 1, color = "red") +
labs(title = "US Map with Major Cities")


#This will plot the US map with red dots representing the location of major cities.
#Conclusion (Group)
#global distribution of something, heat map
#bigger problem where all skills listed above will be used
#library(ggplot2)
#library(tidyverse)
#library(ggmap)
#library(mapdata)
#library(maps)
#library(maptools)
#library(stringr)
#library(dplyr)




