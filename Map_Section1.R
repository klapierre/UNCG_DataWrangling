############ 
#   MAPS   #
############

#Section 1 (Carina) 
#Rstudio can be used for more than tidying and transforming data.
#The RStudio "maps" package is useful for creating maps and visualizing geographic data. It #gives you access to a wide range of map data, such as political boundaries, topography, and #even satellite imagery, which you can use to create custom maps based on your specific needs.
#In addition to basic map creation, the "maps" package includes functions for adding points, lines, and text to maps, as well as custom legends and color scales. 

###########
#Activity:# 
###########

    #Generating US Maps using RStudio
#Objective:
    #To teach students how to generate US maps using RStudio and related packages.
#Necessary R packages: "ggplot2", "maps", "ggthemes"

#Step 1: Lets use some of the functions included in this package. For example, you could use the following code to generate a basic map of the world using the "Mercator" projection:
map("world", projection = "mercator")


#Step 2: Install and Load the Required R Packages
    #ggplot2, maps, and ggthemes.

#If you don't have these libraries installed
install.packages("ggplot2")
install.packages("maps")
install.packages("ggthemes")

#or, if you already installed the packages
library(ggplot2)
library(maps)
library(ggthemes)


#Step 3: Load the US Maps Dataset
    #Load the US maps dataset using the following command:
data("usa")


#Step 4: Generate a Map of the United States
    #Generate a map of the United States using the following command:
map_data <- map_data("usa")
ggplot() +
  geom_map(data = map_data, map = map_data,
           aes(x = long, y = lat, map_id = region),
           fill = "#03adfc", color = "black", size = 0.2) +
  ggtitle("Map of the United States") +
  theme_map()


#Step 5: Customize the Map
    #Customize the map by adding various features such as a title, changing the fill color      #of states, and adjusting the plot theme.


#Step 6: Do it yourself. Now using the dataset "state" generate a map using syntax similar to the one used in Step 4.


#This will load a dataframe called state that contains the polygon data for each state in the US.
data("state")


#Create a basic plot of the US map using ggplot2 by typing the following command into the 
ggplot() + 
  geom_polygon(data = state, aes(x = long, y = lat, group = group), fill = "#03e8fc", color = "black")

#This will create a plot with white polygons representing each state, outlined in black.

#If you want to add additional layers to your plot (such as points or lines), you can do so using the various ggplot2 functions, such as geom_point() or geom_line(). 
#For example, if you wanted to plot the location of major cities in the US, you could use the map_data() function from the ggplot2 package to obtain latitude and longitude data for the cities, and then plot them on the map using geom_point(). Here's an example:

# Load data for major US cities
cities <- map_data("world.cities") %>%
          filter(country.etc == "USA") %>%
          select(long, lat, city)

# Plot the US map with cities overlaid
#This will plot the US map with red dots representing the location of major cities.
ggplot() + 
geom_polygon(data = state, aes(x = long, y = lat, group = group), fill = "#03e8fc", color = "black") +
geom_point(data = cities, aes(x = long, y = lat), size = 2, color = "red") +
labs(title = "US Map with Major Cities")








