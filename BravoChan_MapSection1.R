############ 
#   MAPS   #
############

#Section 1 (Carina) - Introduction to maps in Rstudio
#Rstudio can be used for more than tidying and transforming data it can also helps us visualize #our data in the form of heat maps, or maps. One of the packages used for data visualization is #"tidyverse". It comes with a number of packages, including "ggplot2" for high-quality #graphics, "dplyr" for data manipulation, and "tidyr" for data tidying. 
#The RStudio "maps" package is useful for creating maps and visualizing geographic data. It #gives you access to a wide range of map data, such as political boundaries, topography, and #even satellite imagery, which you can use to create custom maps based on your specific needs.
#In addition to basic map creation, the "maps" package includes functions for adding points, #lines, and text to maps, as well as custom legends and color scales. 
#The "mapproj" package contains tools for working with map projections, which are mathematical #transformations used to convert a curved, 3D surface, such as the earth, to a flat, 2D #surface, such as a map. It includes functions for converting latitude/longitude coordinates to #projected coordinates and working with different map projections.
#When these packages are loaded, the R environment is loaded with various functions, data sets, #and objects that can be used to create maps, work with map projections, and manipulate and #visualize data. The type of objects generated will be determined by the functions used and the #data being manipulated.

###########
#Activity:# 
###########

#Generating US Maps using RStudio
#Objective:
#How to generate US maps using RStudio and related packages.
#Necessary R packages: ggplot2, maps, ggthemes


#Step 1: Install and Load the Required R Packages
#If you don't have these libraries installed
install.packages(c("maps","tidyverse"))

#or, if you already installed the packages
library(ggplot2)
library(tidyverse)
library(usmap)


#Step 2: Lets use ggplot2 and a dataset included in Rstudio to generate a map of the United States and its states by runing the following code:
country <- map_data("state")
ggplot(world, aes(long, lat, group = group)) +
  geom_polygon(fill = "#429ef5", color = "black") +
  coord_fixed(1.3)


#Step 3: Let's make this map your own, play with fill and border colors. Add a title and change the labels on the x and y axis. 


#Step 4: Let's generate a blank map of the United States and add county boundaries using the function plot usmap(). We will also add a title and subtitle to the map.
#US states
plot_usmap(regions = "states") + 
  labs(title = "U.S. States",
       subtitle = "This is a blank map of the United States.") + 
  theme(panel.background=element_blank()) +
  coord_fixed(1.3)

#US counties
plot_usmap(regions = "counties") + 
  labs(title = "U.S. counties",
       subtitle = "This is a blank map of the United States.") + 
  theme(panel.background=element_blank()) +
  coord_fixed(1.3)


#Step 5: Let's get fancy! Using the map data() function that is included in the ggplot2 package, we will make a colorful US map. Use the guides() function to remove all labels for #state abbreviations. The map produced should have each state filled in with fun colors.
state <- map_data("state")

ggplot(data=state, aes(x=long, y=lat, fill=region, group=group)) + 
  geom_polygon(color = "white") + 
  guides(fill=FALSE) + 
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank(),
        axis.title.y=element_blank(), axis.text.y=element_blank(), axis.ticks.y=element_blank()) + 
  ggtitle('U.S. Map with States') + 
  coord_fixed(1.3)


#Step 6: Next, we will try something different. We will be isolating a region within the US and #playing around to display it in different ways. Create a map of the New England region using the #"plot_usmap" function. Only the states of Connecticut, Maine, Massachusetts, New Hampshire, #and Vermont are included in the map.
plot_usmap(include = c("CT", "ME", "MA", "NH", "VT")) +
  labs(title = "New England Region") +
  theme(panel.background = element_rect(color = "orange"))


#Now we will create a choropleth map, that means a map filled by a color gradient. Feel free to play around with colors, map scale, and label position.
plot_usmap(data = countypov, values = "pct_pov_2014", include = c("TX", "CO", "AZ", "NM", "CA"), color = "black") + 
  scale_fill_continuous(low = "white", high = "#810aff", name = "Poverty Percentage Estimates", label = scales::comma) + 
  labs(title = "Southwestern States", subtitle = "Poverty Percentage Estimates for Counties in Southwestern States 2014") +
  theme(legend.position = "right")


#Step 8: Try it yourself. Create a map similar to the one above using the information #for the 2015 population estimates you can pick a particular state, or a region. Use the values "pop_2015" from the #dataset "countypop", pick the colors of your preference for the gradient fill and edit the #title and labels accordingly.  
############
#Answer Key#
############
plot_usmap(data = countypop, values = "pop_2015", include = .new_england, color = "black") + 
  scale_fill_continuous(low = "white", high = "#0467c9", name = "Population", label = scales::comma) + 
  labs(title = "New England Region", subtitle = "Population in New England Counties in 2015") +
  theme(legend.position = "right")

#or
plot_usmap(data = countypop, values = "pop_2015", include = c("TX", "CO", "AZ", "NM", "CA"), color = "black") + 
  scale_fill_continuous(low = "white", high = "#0467c9", name = "Population", label = scales::comma) + 
  labs(title = "New England Region", subtitle = "Population in New England Counties in 2015") +
  theme(legend.position = "right")


#RStudio comes with a number of different packages that can be used to map and visualize spatial data. Some of these packages are ggplot2, plotly, mapview, leaflet, and tmap, among #others. When it comes to plotting maps, these packages provide a number of benefits, including #the ability to alter the look of the maps, combine them with other plots, and carry out advanced geospatial studies. 
#RStudio can import and handle numerous kinds of spatial data, including GPS data, shapefiles, and geotiff files, amongst others. However, it has a few drawbacks, such as a higher learning curve when compared to other GIS tools, limited support for 3D visualization, and slower rendering times for large datasets. 
#Still, RStudio is a useful tool for plotting maps and it offers a robust and adaptable framework for the creation of high-quality and #informative maps that may be used in a wide variety of applications.



