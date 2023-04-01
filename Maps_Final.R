############ 
#   MAPS   #
############

#Section 1 (Carina) 
#Introduction to maps in Rstudio
#Rstudio can be used for more than tidying and transforming data it can also helps us visualize #our data in the form of heat maps, or maps. One of the packages used for data visualization is #"tidyverse". It comes with a number of packages, including "ggplot2" for high-quality #graphics, "dplyr" for data manipulation, and "tidyr" for data tidying. 
#The RStudio "maps" package is useful for creating maps and visualizing geographic data. It #gives you access to a wide range of map data, such as political boundaries, topography, and #even satellite imagery, which you can use to create custom maps based on your specific needs.
#In addition to basic map creation, the "maps" package includes functions for adding points, #lines, and text to maps, as well as custom legends and color scales. 
#The "usmap" package contains tools for working with map projections, which are mathematical #transformations used to convert a curved, 3D surface, such as the earth, to a flat, 2D #surface, such as a map. It includes functions for converting latitude/longitude coordinates to #projected coordinates and working with different map projections.
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
world <- map_data("state")
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

#--------------------------------#
#Section 2 (Kaysa)
#--------------------------------#
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
# called age_pop_tidier. Then follow the steps we took above and make your own map! Make sure to 
# choose a different color palette and feel free to choose your own theme as well!

#--------------------------------#
#Section 3 (Stephanie)
#--------------------------------#
install.packages(c("ggplot2", "devtools", "dplyr", "stringr"))

install.packages(c("maps", "mapdata"))

devtools::install_github("dkahle/ggmap")

library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

install.packages('tidygeocoder')
devtools::install_github("jessecambon/tidygeocoder")

#In progress:
usa <- map_data("usa") %>% 
  ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)


# Read in the data set we are going to use (starbucks_2018_11_12.csv)
# We only want the Starbucks in NY and we only want the columns "name", "latitude", and "longitude"
# tidy it up!

starb <- read.csv("starbucks_2018_11_12.csv", stringsAsFactors = TRUE) %>% 
  subset(city == "New York") %>% 
  select(state, name, latitude, longitude)


#--------------------------------#
# Section 4 (Jordan)
#--------------------------------#



##############
# Conclusion #
##############
#RStudio is a powerful open source tool for data analysis and visualization. Its various free packages that can be used for mapping and data visualization, making it an ideal choice for researchers and data analysts. The benefits of using Rstudio for data visualization are a vast range of options for customizing colors, size, and style. With RStudio, users can create informative and visually appealing maps that can communicate their data insights effectively.
#The most common difficulty that first-time users encounter when using RStudio range from installing packages to understanding the syntax of the programming language. Thankfully, you can always find help from online communities, youtube tutorials or virtual courses in R programming.
#Overall, the benefits of using RStudio for data visualization and mapping far outweigh the challenges. 
