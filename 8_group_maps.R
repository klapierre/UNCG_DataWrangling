# MAP BUILDING IN RSTUDIO
#hello
# ---------------------------------------------------------------------------- #
# OBJECTIVES:
# 1. Understand when and why we may want to use R to build maps
# 2. Understand that there are many different ways to map spatial data within RStudio framework
# 3. Use packages such as maps and ggplot to map spatial data 
# 4. To learn how to find and import environmental spatial data sets

# Part 1: LOAD PACKAGES --------------------------------------------------------

# NOTE: you may need to write the line install.packages(" ") before loading these
#packages into your library if you have not used them before!
#If you run into error messages while trying to install these packages by running 
#code, go to the tools tab, click on install packages, and type the names of each
#package to install.

library(tidyverse)
library(ggplot2)
library(maps)
library(dplyr)
library(tigris)
library(sf)

#Run the following code:

options(tigris_use_cache = TRUE)

# Part 2: Using datasets within R to create a map -----------------------------

#Task: We will start by loading the state.x77 dataset
#into R as a dataframe and using the cbind() function to create a column named
#"State" with all states listed from the row names in the state.x77 dataset.
#Task: Run the following code:

state_data <- cbind(
  State = rownames(state.x77),
  as.data.frame(state.x77))

#Task: Run the following code to display your data

head(state_data)

#Question: What do you notice about the rownames and the data within the "State" 
#column? 
#Answer: The row names and the state comumn have the same values or character strings.

#Task: Run the following code:

rownames(state_data) <- NULL

#Question: Write code to display your dataset once again. What did the previous
#code change within the dataset? What did NULL do to the rownames?
#Answer: Now instead of there being both a row names column and a state column, the state column is also the first column/title column with numeric indicators of the rows instead. I think that null got rid of repetative rows and instead of repeating it becomes a numbering..

head(state_data)

#Task: Because we have loaded the dyplr package, we can create a new dataframe
#with just State and Frost data. Write a code to select the State and Frost columns
#from the state_data dataframe and name the new dataframe state_frost_data. 
state_frost_data<-select(.data=state_data, State, Frost)
head(state_frost_data)
??diplyr

#View the new dataset and confirm that it is correct.
#Answer: Oui oui, it appears so
head(state_frost_data)

#Now we need to use the tigris package to download a shapefile called 'states'
#of all of US states that we would like to plot. We set cb = TRUE 
#to specify cartographic boundary type so that we use a simple shapefile that
#is easier to work with.

#Task: Run the following code
states <- states(cb = TRUE) 

#In order to leftjoin states together we need the 'State' column in the 
#state_frost_data to have the same name as the column 'NAME' of states in 
#the states dataset. 

#Task: Run the following code to rename the 'NAME' column in the states dataset

states <- states %>% rename(State = NAME)

#Task: Run the following code to leftjoin the states and state_frost_data datasets 
#by "State" to a new dataframe named us_states_frost

us_states_frost <- left_join(states, state_frost_data, by = c("State"))

#Next we will use ggplot to construct a map of the US States and number of Frost
#days
#Task: Run the following code and annotate the significance of each line of code.

ggplot(us_states_frost) +
  geom_sf(aes(fill = Frost), color = "blue") +
  theme_minimal() +
  labs(fill = "Number of Frost Days", title = "United States Frost Data")

#Question: Do you see a map under the "plots" tab?
#Answer: Oui oui

#Question: What do you notice about the size of this map? Suppose we only want
#to study frost data of mainland US states. Are there states we could omit from
#this map to better visualize the data? HINT ** to help determine which states we may 
#want to omit, check out the us_states_frost_2 tab at the different States included
#in the dataframe.
#Answer: It is very very small. There are definitely some states such as Hawaii and Alaska that can be pulled out of this graph

#To filter out states or islands not connected to the mainland US, we can use the 
#dplyr function.

#Task: Run the following code to filter out and omit states that are islands
#not connected to the mainland US.

us_states_frost_2 <- us_states_frost %>%
  dplyr::filter(State != "Alaska" & State != "Hawaii" & State != "Guam" & State != 
                  "American Samoa" & State != "United States Virgin Islands" & 
                  State != "Puerto Rico" 
                & State != "Commonwealth of the Northern Mariana Islands")

#Write code to show a map of the us_states_frost_2 dataset following the steps
#used to create the map from the us_states_frost dataset.
ggplot(us_states_frost_2) +
  geom_sf(aes(fill = Frost), color = "blue") +
  theme_minimal() +
  labs(fill = "Number of Frost Days", title = "United States Frost Data")
#You should see a new map in the "plots" tab that is much larger than the previous 
#map making it easier to visualize the data.

#Question: What do dark blue states represent? What do light blue states represent?
#Question: Does florida or NC have more frost days?
#Answer: The darker blue states represent states that have fewer frost days, and lighter blue states have more frost days.
#Answer: NC has more frost days than Florida.

#Question: Does there appear to be a relationship between latitude and 
#number of frost days? Why or why not?
#Answer: There does seem to be a relationship between latitude and number of frost days because the lower half of the US has a higher concentration of dark blue than the northern half of the us.

#Task: Write code to create a map of the Population data from the state.x77 dataset.
#You can reference the pevious steps of this assignment
#while you work through this task. make the color of the map any color that is
#not blue (as we have already used this color) **Make sure to write the code
#because your code will be viewed for grading, not the map itself!

state_population_data <- state_data %>% select(State, Population)
us_states_pop <- left_join(states, state_population_data, by = c("State"))

us_states_pop_2 <- us_states_pop %>%
  dplyr::filter(State != "Alaska" & State != "Hawaii" & State != "Guam" & State != 
                  "American Samoa" & State != "United States Virgin Islands" & 
                  State != "Puerto Rico" 
                & State != "Commonwealth of the Northern Mariana Islands")

head(state_pop)

ggplot(us_states_pop_2) +
  geom_sf(aes(fill = Population)) +
  scale_fill_gradient(low="lightgreen",high="violet")
  theme_minimal() +
  labs(fill = "Population in Thousands", title = "United States Population Data")
colors()
?geom_sf
#Task: write three things you can infer from the map that you created:
#1:The midwest/central US has the least amount of people in the area per size of state
#2: California and NY have high populations possible since they are hubs for large industries such as acting/modeling and art
#3: New york based on the map is quite small, but still is bright purple, so I wonder if it is much more concentrated with people than say California which is also bright purple but larger in size.

# Part 3: MAPPING SPECIMEN OCCURRENCE DATA -----------------------------------

# In this section, we are going to learn how to find and plot specimen (or species) occurrence data from North Carolina. First, we need to find a data set to download.
# I want to map mammals collected in North Carolina!  

# To find an appropriate data set, I queried the opensource museum data sharing
# platform Arctos to gather mammal records from North Carolina.
# Here is the link to the website: https://arctos.database.museum/

# To filter the records, I specified "Mammalia" in the "Any taxon, ID, common   
# name" box within the Identification field, and "North Carolina" in the
# "state_prov" box within the Place field. 

# It is free to make an account and search+download records, but I shared a csv 
# file in the the email I sent out for those who do not have an account already 
# made. 

# TASK: Download the NC_mamm_data.csv into your UNCG_DataWrangling folder on your desktop
#Answer: Done

# TASK: Using read.csv(), create an object titled "mammal_data" from the NC_mamm_data csv 
mammal_data<-read.csv("NC_mamm_data.csv")

# TASK: Using the colnames() function, review what columns exist in your current dataset
colnames(mammal_data)

# TASK: Remove the 'USE_LICENSE_URL' column using a pipe and the select(- ) 
# function because it is not needed for plotting. You do not need to create a new object for this; just reassign to the same name 'mammal_data' 
mammal_data<- select(.data=mammal_data, -USE_LICENSE_URL)

# Using the rename() function introduced in assignment 4, rename the remaining 11 columns in the following order: country, state, locality, date, lat, long, sex, life_stage, genus, order, family.
mammal_data<- rename(.data=mammal_data, country=COUNTRY, state=STATE_PROV, locality=SPEC_LOCALITY, date=VERBATIM_DATE, lat=DEC_LAT, long=DEC_LONG, sex=SEX, life_stage=LIFE_STAGE, genus=GENUS, order=PHYLORDER, family=FAMILY)

colnames(mammal_data)
# Using the mammal_data object, clean NA values from columns 'lon', 'lat', 'locality' and 'genus'. Create new object for this cleaned data titled 'clean_data'

clean_data <- drop_na(mammal_data,long,lat,locality,genus)

?drop_na
# Great, now our data is clean and easier to work with! 

# BUILDING THE MAP

# First, using the function map_data() within the maps package we loaded at the start, we can build a dataframe that provides all counties within the United States. 

# TASK: Run this line of code, and look at the data frame that appears in our environment box
counties <- map_data("county")

# Great, now we have a very large data frame that gives us coordinates for every county in the United States. 

# TASK: To plot this, run the line of code below: 
ggplot() +
  geom_polygon(data = counties,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  theme_bw()

# QUESTION: What do you think the geom_polygon function is doing here?
#Answer: I think that it is shaping the counties

# TASK: Create a new dataframe titled 'nc_map' that only has North Carolina counties by assigning 'north carolina', typed exactly as it is shown in the in the 'counties' dataframe previously built. The code should look like this, with region following county:
nc_map <- map_data("county", region = "north carolina")

# TASK: plot the map using your new nc_map dataframe using the previous map code as your guide
# HINT: to adjust the map ratio, add the function coord_fixed(1.5) to the end of the code
ggplot() +
  geom_polygon(data = nc_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  theme_bw() +
  coord_fixed(1.5) 

# QUESTION: What do you think the 'coord_fixed' function is doing here? 
#Answer: Without the coord_fixed, the map is weirdly elongated upwards, so I think it is setting proportions to make the map look more correct.

# ADDING THE DATA POINTS TO NC MAP---------------------------------------------

# Using the 'clean_data' df we created, we can map these points onto out North Carolina map to see species occurrences! 
# To do this, we can add the geom_point function to our previous chunk of code.

# TASK: With a plus sign between the sections, add the lines below to the above code:
ggplot() +
  geom_polygon(data = nc_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  geom_point(data = clean_data,aes(x = long, y = lat, color = order),size = 1,alpha = 0.7)
  theme_dark() +
  coord_fixed(1.5)

# From here, you can adjust the theme to your liking. 
# NOTE: With a plus sign between sections, if you begin typing 'theme' on the next line, options will appear that you can browse through! 

# QUESTION: Why might it be useful to have slightly transparent data points (by setting alpha to a number below 1) when mapping in a small area such as this? 
  #Answer: When you have congested data, having more transparent data points, you can see points through other points. It is very important here when you have orders by colors, so if you have multiple orders in the same area, you can see the multiple dots.

# TASK: after adding a theme to the plot, add and title and an x and y axis label with the labs() function. 
  ggplot() +
    geom_polygon(data = nc_map,
                 aes(x = long, y = lat, group = group),
                 fill = "white",
                 color = "black") +
    geom_point(data = clean_data,aes(x = long, y = lat, color = order),size = 1,alpha = 0.7)
  theme_dark() +
    coord_fixed(1.5)+
    labs(title = "Mammal captures in North Carolina",x = "Longitude",y = "Latitude")


# In the end, we should have a chunk of code that looks something like this (theme can be your choosing):
ggplot() +
  geom_polygon(data = nc_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  theme_bw() +
  coord_fixed(1.5) +
  geom_point(data = clean_data,
             aes(x = lon, y = lat, color = order),
             size = 1,
             alpha = 0.7) +
  theme_bw() +
  labs(title = "Mammal captures in North Carolina",
       x = "Longitude",
       y = "Latitude")

# QUESTION: Why did I decide to color the points by order? What happens if you color the points (within the geom_point section) by genus instead? 
#Answer: Since you are using the map to see what orders are where in NC, coding by color allows you to differentiate the different orders while looking at the map. If you did it by order instead, then I would guess there would be a lot more colors of dots, and the labels would be different.

# HINT: the unique() function allows us to see how many unique values are in each of our columns 
unique(clean_data$genus)
unique(clean_data$family)
unique(clean_data$order)


# Note: If we wanted to, we could subset out dataframe by species while still working in the data cleaning section, and only plot one species at a time, or focus on different families, etc.


# This shows us that  data cleaning provides many different opportunities for visualization! 

# Part 4: MAPPING SPECIES RICHNESS ---------------------------------------------------

# Using the same object we used for our map above (clean_data), we can create a map that colors counties along a gradient, based on species richness from our capture data.

# In this section, we will build on our previous map by calculating and mapping
# species richness across North Carolina counties. Species richness refers to
# the number of unique species (or taxa) observed in a given area.

# Instead of plotting individual points, we will summarize how many different
# genera occur within each county and display this as a gradient map.

# ---------------------------------------------------------------------------- #
# PREPARING DATA FOR SPECIES RICHNESS -----------------------------------------

# TASK: Install and load the sf package if not already installed
# install.packages("sf")
library(sf)

# TASK: Convert clean_data into an sf (simple features) object using longitude and latitude
clean_sf <- st_as_sf(clean_data, coords = c("long", "lat"), crs = 4326)

# TASK: Convert nc_map dataframe into an sf object
nc_map_sf <- st_as_sf(nc_map, coords = c("long", "lat"), crs = 4326)

# NOTE: The nc_map object is not yet a true polygon sf object, so we will
# instead use a built-in county shapefile

# TASK: Load US counties map from maps package
library(maps)
counties_sf <- st_as_sf(map("county", plot = FALSE, fill = TRUE))

# TASK: Filter only North Carolina counties
nc_counties_sf <- counties_sf %>%
  filter(grepl("north carolina", ID))

# ---------------------------------------------------------------------------- #
# CALCULATING SPECIES RICHNESS ------------------------------------------------

# Make sure both spatial objects use the same CRS
nc_counties_sf <- st_transform(nc_counties_sf, st_crs(clean_sf))

# Spatial join: assign each point to a county
points_with_county <- st_join(clean_sf, nc_counties_sf)

# Calculate richness per county using the 'genus' column of our dataframe
richness_data <- points_with_county %>%
  st_drop_geometry() %>%
  group_by(ID) %>%
  summarise(richness = n_distinct(genus))

# TASK: Remove geometry from richness_data before joining 
richness_df <- st_drop_geometry(richness_data)

# TASK: Join richness values back to all counties 
nc_richness_map <- nc_counties_sf %>%
  left_join(richness_df, by = "ID")

# TASK: Replace NA values with 0
nc_richness_map$richness[is.na(nc_richness_map$richness)] <- 0

# ---------------------------------------------------------------------------- #
# BUILDING THE RICHNESS MAP ---------------------------------------------------

# TASK: Plot the North Carolina counties and fill by richness values
library(ggplot2)

ggplot() +
  geom_sf(data = nc_richness_map, aes(fill = richness),  color = "black") +
  scale_fill_viridis_c(option = "plasma", na.value = "gray90") +
  theme_bw() +
  labs(title = "Richness of Mammals in North Carolina",
       fill = "Genera count",
       x = "Longitude",
       y = "Latitude")

# ---------------------------------------------------------------------------- #
# IMPROVING THE MAP -----------------------------------------------------------

# Now that we have added a title and labels, we can further improve the map by
# adjusting the color scale and overall appearance to make patterns easier to see.

# TASK: Customize the color gradient to better highlight differences in richness
ggplot() +
  geom_sf(data = nc_richness_map, 
          aes(fill = richness),  color = "black") +
  scale_fill_viridis_c(option = "mako", na.value = "gray90") +
  theme_bw() +
  labs(title = "Richness of Mammals in North Carolina",
       fill = "Genera count",
       x = "Longitude",
       y = "Latitude")

# QUESTION: What does changing the 'option' in scale_fill_viridis_c() do?
#Answer: the scale_fill_viridis_c() function has a few color scales that can be added to the option argument in the function. By changing the option, you are changing the color gradient that is used through the map.

# ---------------------------------------------------------------------------- #

# TASK: Adjust legend position for better readability
ggplot() +
  geom_sf(data = nc_richness_map, 
          aes(fill = richness),  color = "black") +
  scale_fill_viridis_c(option = "inferno", na.value = "gray90") +
  theme_bw() +
  theme(legend.position = "left") +
  labs(title = "Richness of Mammals in North Carolina",
       fill = "Genera count",
       x = "Longitude",
       y = "Latitude")

# QUESTION: Why might changing the legend position be useful?
# Answer: Changing the legend is helpful because depending on the person, the location of the key makes it easier to read the map. For me, it is easier to have the key on the right because I tend to look at figures like I read from left to right. So, I find a point of interest on the left and find what it means on the right.

# ---------------------------------------------------------------------------- #
# INTERPRETING THE MAP --------------------------------------------------------

# QUESTION: What does a lighter color indicate on this map?
#Answer: The lighter color on this map means a higher # of genera.

# QUESTION: Why might some counties have lower richness values? 
# Answer: Some might have lower richness values because of them being more urban areas, or more agricultural areas.


# TASK: Save your most recent plot as an image file to your folder. 
ggsave("nc_species_richness_map.png",width = 8, height = 6, dpi = 300)

