############ 
#   MAPS   #
############

#Section 1 (Carina) 
#Introduction to maps in Rstudio
#Rstudio can be used for more than tidying and transforming data it can also helps us visualize #our data in the form of heat maps, or maps. One of the packages used for data visualization is #"tidyverse". It comes with a number of packages, including "ggplot2" for high-quality #graphics, "dplyr" for data manipulation, and "tidyr" for data tidying. 
#The RStudio "maps" package is useful for creating maps and visualizing geographic data. It #gives you access to a wide range of map data, such as political boundaries, topography, and 
#even satellite imagery, which you can use to create custom maps based on your specific needs.
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


#Step 2: Lets use ggplot2 and a dataset included in Rstudio to generate a map of the United States and its states by running the following code:
world <- map_data("state")
ggplot(world, aes(long, lat, group = group)) +
  geom_polygon(fill = "#429ef5", color = "black") +
  coord_fixed(1.3)


#Step 3: TASK: Let's make this map your own, play with fill and border colors. Add a title and change the labels on the x and y axis. 
world <- map_data("state")
ggplot(world, aes(long, lat, group = group)) +
  geom_polygon(fill = "blue", color = "yellow") +
  xlab("Longitude")+
  ylab("Latitude")+
  coord_fixed(1.3)


#Step 4: Let's generate a blank map of the United States and add county boundaries using the function plot usmap(). We will also add a title and subtitle to the map.
#US states
plot_usmap(regions = "states") + 
  labs(title = "U.S. States",
       subtitle = "This is a blank map of the United States.") + 
  theme(panel.background=element_blank()) +
  coord_fixed(1.3)

#TASK: US counties
plot_usmap(regions = "counties") + 
  labs(title = "U.S. Counties",
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


#Step 8: TASK: Try it yourself. Create a map similar to the one above using the information #for the 2015 population estimates you can pick a particular state, or a region. Use the values "pop_2015" from the #dataset "countypop", pick the colors of your preference for the gradient fill and edit the #title and labels accordingly.  
plot_usmap(data = countypop, values = "pop_2015", include = c("NC", "VA", "GA", "SC", "FL"), color = "lightblue") + 
  scale_fill_continuous(low = "blue", high = "lightyellow", name = "Poverty Percentage Estimates", label = scales::comma) + 
  labs(title = "Southeastern States", subtitle = "Population Estimates for Counties in Southeastern States 2015") +
  theme(legend.position = "left")


#RStudio comes with a number of different packages that can be used to map and visualize spatial data. Some of these packages are ggplot2, plotly, mapview, leaflet, and tmap, among #others. When it comes to plotting maps, these packages provide a number of benefits, including #the ability to alter the look of the maps, combine them with other plots, and carry out advanced geospatial studies. 
#RStudio can import and handle numerous kinds of spatial data, including GPS data, shapefiles, and geotiff files, amongst others. However, it has a few drawbacks, such as a higher learning curve when compared to other GIS tools, limited support for 3D visualization, and slower rendering times for large datasets. 
#Still, RStudio is a useful tool for plotting maps and it offers a robust and adaptable framework for the creation of high-quality and #informative maps that may be used in a wide variety of applications.

#--------------------------------#
#Section 2 (Kaysa)
#--------------------------------#
## Before jumping in, make sure the following packages are loaded. For the ones you don't have installed, go ahead and install them and then load them.
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
age_pop_states <- age_pop_tidy%>%
  inner_join(states,age_pop_tidy, by= "region")

# Now that we have a data frame ggplot can use, it's time to start making the heat map!
# First, you create a basic map of the outline of the USA. Then put the state borders
# on the map, and finally make it a heat map using our population data!

# Here we break it down step by step with example code, don't run the code until we combine it all

# 1) First we make the basic outline of the US map using the usa data frame and use 
# coord_fixed() to maintain the correct aspect ratio. For the US it is recommended to use 1.3
ggplot()+
  geom_polygon(data=usa, aes(x=long, y=lat, group=group), color = "black", fill=NA)+
  coord_fixed(1.3)

# 2) Next we add the state borders to the map using the states data frame. We use fill=NA 
# since we just want the border lines (color=)
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
# TASK: You will be using the Adults age 55-64 column for your heat map so you will first have
# to re-tidy the age_pop data frame so it uses this column instead and assign it to a data frame
# called age_pop_tidier. Then follow all the steps we took above and make your own map! Make sure to 
# choose a different color palette and feel free to choose your own theme as well!

old_pop_tidy <- age_pop %>% 
  rename(region = Location) %>% 
  mutate(region = tolower(region)) %>% 
  select(region, Adults.55.64)

old_pop_tidy$Adults.55.64 <- as.numeric(age_pop$Adults.55.64)

old_pop_states <- old_pop_tidy%>%
  inner_join(states,old_pop_tidy, by= "region")


ggplot()+
  geom_polygon(data=usa, aes(x=long, y=lat, group=group), color = "darkgreen", fill=NA)+
  coord_fixed(1.3)+
  geom_polygon(data=states, aes(x=long, y=lat, group=group), fill=NA, color="black")+
  geom_polygon(data=old_pop_states, aes(x=long, y=lat, group=group, fill = Adults.55.64), color = "black")+
  geom_polygon(data=usa, aes(x=long, y=lat, group=group), color="black", fill = NA)+
  scale_fill_gradientn(trans = "log10", colors=rev(brewer.pal(9, "Spectral")))
#--------------------------------#
#Section 3: Plotting Points on a Map
#--------------------------------#

# Prep by instaling these packages and loading these libraries if you haven't already
install.packages(c("ggplot2", "devtools", "dplyr", "stringr"))
install.packages(c("maps", "mapdata"))
devtools::install_github("dkahle/ggmap")
# also download the starbucks csv file

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

# TASK:
# Now tidy up the data so that we are working with only the Starbucks found in New York!
# Be sure to name the data set "starb_NY"

starb_NY <- starb%>%
  filter(state %in% c("NY"))

# We do this because to plot points on a map, we need to know the latitude and longitude.
# Sometimes we have to figure this out by hand or by using packages to figure this out for us.
# In this case, the csv file came with the latitude and longitude already included!


# Now we will learn how to plot points onto our graphs
# first we will load our map as we learnt in the previous sections
# feel free to customize the map and make it your own!

ggplot() +
  geom_polygon(data = NY, aes(x=long, y=lat, group=group), fill = "orange", col = "black") +
  coord_fixed(1.5)

# TASK:
# Now we are going to add our coordinates from the starb_NY
# to do this we are going to use "geom_point", just like from the example part 1
# Be sure to:
#   include the data set we are inserting (starb_NY)
#   specify that: x=longitude & y=latitude
ggplot() +
  geom_polygon(data = NY, aes(x=long, y=lat, group=group), fill = "grey", col = "black") +
  coord_fixed(1.5)+
  geom_point(data = starb_NY, aes(x = longitude, y = latitude), color = "darkgreen", size = 4, shape= 13)



# Congratulations!
# We can adjust the color, size, and shape of our data points too
# here is a line of code which you can play around with!
# change the size, the color, and the shape until the map looks how you want it to
# You can Google the different shapes you can have for your points (there are 25 shapes)

ggplot() +
  geom_polygon(data = NY, aes(x=long, y=lat, group=group), fill = "lightblue", col = "black") +
  coord_fixed(1.5) +
  geom_point(data = starb_NY, aes(x=longitude, y=latitude), color = "#Fe019a" , size = 5, shape = 25)


# Final task
# Map out the Starbucks in California
# Be sure to personalize it!

CA <- state %>% 
  filter(region == "california")

starb_CA <- starb%>%
  filter(state %in% c("CA"))

ggplot() +
  geom_polygon(data = CA, aes(x=long, y=lat, group=group), fill = "lightyellow", col = "orange") +
  coord_fixed(1.5)+
  geom_point(data = starb_CA, aes(x = longitude, y = latitude), color ="green", size = 3, shape= 10)


#--------------------------------#
# Bring it all together.
#--------------------------------#

# Alright y'all, for the last part of this assignment we are tying it all together and going global.
# We are going to be using the packages below, so go ahead and load those up if you don't
# already have them loaded.

library(tidyverse)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(RColorBrewer)

# Let's all start by brushing up on our geography.
# TASK: Using the mapdata() package go ahead and create a base map of the whole world.
# Refer to your work above to help, but if you're feeling stuck be sure to reference the help function!
# (Don't forget the coor_fixed argument! :^) )
globe <- map_data("world") 

ggplot()+
  geom_polygon(data=globe, aes(x=long, y=lat, group=group), color = "darkblue", fill=NA)+
  coord_fixed(1.5)


# Hopefully you've got yourself a nice map, don't be afraid to give it some personality and
# change around the colors and labels.

# Once you have your map ready to go lets load up the the "country-capital-lat-long-population.csv" file

caps <- read.csv("country-capital-lat-long-population.csv")

# Give this data frame a look over. What does it contain?
# The geographical information for all of the capitals of the world

# Let's start by adding the capitals to the map as points. 


ggplot()+
  geom_polygon(data=globe, aes(x=long, y=lat, group=group), color = "darkblue", fill="white")+
  coord_fixed(1.5)+
  geom_point(data = caps, aes(x = Longitude, y = Latitude), color="red", size = 2, shape= 10)


# Nice! Be sure to change to color of the points and the size to something of your liking.

# We can actually label all those points using the geom_text function! Give that package a look over and then
# Add the labels to the countries to your map (If it looks like a garbled mess change the "size" of the text)

ggplot()+
  geom_polygon(data=globe, aes(x=long, y=lat, group=group), color = "darkblue", fill="white")+
  coord_fixed(1.5)+
  geom_point(data = caps, aes(x = Longitude, y = Latitude), color="red", size = 2, shape= 10)+
  geom_text(data=caps,aes(x=Longitude, y= Latitude, label=Capital.City),size=1.5)
  


# Alright now that you are comfy with the map making tools we have shown now it's time to set you free.
# Load up the "observations-309667.csv" and keep your capitals dataset loaded. We will be incorporating it into
# our final product

pines <- read.csv("observations-309667.csv")

# What does this data frame look like? How many observations are there?
# This is a large dataset with 39 variables and 153439 observations.

# This is a data set containing all research grade observations from the Pinus genus from iNaturalist.
# There's actually way more data than this, but this range goes from 1/1/2020 - 3/24/2023
# There are quite a few observations in our data set and wouldn't look too hot if we plotted all those points.
# You didn't think you were going to do a whole lesson without some data manipulation did you? (◕‿↼)
# Make a global map (with some color options other than default) that has the following capital cities 
#listed for the following countries: 
# USA, Australia, France, and Italy. These points should be orange and labels should be red.
# Next whittle down the pine data set so that we only have observations from after 1/1/2021.
# Next plot all "Pinus palustris" species and make the points green change the size to be larger
# because bigger is better for the coolest species of pine.
# Then plot all European pine and make those points yellow.
# This is a huge dataset so go ahead and plot another species your choice, just make it clear which one you choose


capsfilter <- filter(caps, Country %in% c("Australia", "France", "Italy", "United States of America"))

pines2021 <- subset(pines, observed_on > "2021-01-01")

palustris_sub <- subset(pines2021, scientific_name == "Pinus palustris")
euro_sub <- subset(pines2021, scientific_name == "Pinus sylvestris")
NC_sub <- subset(pines2021, scientific_name == "Pinus echinata")


ggplot()+ 
  geom_polygon(data = globe, aes(x=long, y = lat, group = group), color = "darkblue", fill="white")+
  coord_fixed(1.5)+
  geom_point(data = capsfilter, aes(x = Longitude, y = Latitude), color = "orange", size = 0.5)+
  geom_text(data = capsfilter, aes(x = Longitude, y = Latitude,label = Capital.City), size = 1.5, col = "red")+
  geom_point(data = palustris_sub, aes(x = longitude, y = latitude), color = "green", size = 1, shape = 3)+
  geom_point(data = euro_sub, aes(x = longitude, y = latitude), color = "yellow", size = .2, shape = 5)+
  geom_point(data = NC_sub, aes(x = longitude, y = latitude), color = "brown", size = .2, shape = 7)



##############
# Conclusion #
##############
#RStudio is a powerful open source tool for data analysis and visualization. Its various free packages 
#that can be used for mapping and data visualization, making it an ideal choice for researchers and data analysts. 
#The benefits of using Rstudio for data visualization are a vast range of options for customizing colors, size, and style. 
#With RStudio, users can create informative and visually appealing maps that can communicate their data insights effectively.
#The most common difficulty that first-time users encounter when using RStudio range from installing packages to 
#understanding the syntax of the programming language. Thankfully, you can always find help from online communities, 
#youtube tutorials or virtual courses in R programming.
#Overall, the benefits of using RStudio for data visualization and mapping far outweigh the challenges. 