# MAP BUILDING IN RSTUDIO
#hello
# Hi
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
install.packages("maps")
library(maps)
library(dplyr)
install.packages("tigris")
library(tigris)
install.packages("sf")
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

#ANSWER: They are duplicated. 

#Task: Run the following code:

rownames(state_data) <- NULL

#Question: Write code to display your dataset once again. What did the previous
#code change within the dataset? What did NULL do to the rownames?
head(state_data)
#ANSWER: It removed the row names. 

#Task: Because we have loaded the dyplr package, we can create a new dataframe
#with just State and Frost data. Write a code to select the State and Frost columns
#from the state_data dataframe and name the new dataframe state_frost_data. 

state_frost_data <- state_data %>% 
  select(State, Frost)

#View the new dataset and confirm that it is correct.

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

ggplot(us_states_frost) + #identifying the dataframe to use
  geom_sf(aes(fill = Frost), color = "blue") + # tells ggplot to make a map of the US and color it blue
  theme_minimal() + #type of background we are using. 
  labs(fill = "Number of Frost Days", title = "United States Frost Data") # naming labels.

#Question: Do you see a map under the "plots" tab?

#ANSWER: yes. 

#Question: What do you notice about the size of this map? Suppose we only want
#to study frost data of mainland US states. Are there states we could omit from
#this map to better visualize the data? HINT ** to help determine which states we may 
#want to omit, check out the us_states_frost_2 tab at the different States included
#in the dataframe.

#ANSWER: It is really small and off-centered.Yes, we can omit Alaska, Hawaii and the Island Territories. 

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
  geom_sf(aes(fill = Frost), color = "black") + 
  theme_minimal() + 
  labs(fill = "Number of Frost Days", title = "United States Frost Data")

#You should see a new map in the "plots" tab that is much larger than the previous 
#map making it easier to visualize the data.

#Question: What do dark blue states represent? What do light blue states represent?

#ANSWER: the dark blue states are the states with fewer number of frosts. 

#Question: Does florida or NC have more frost days?

#ANSWER: North Carolina

#Question: Does there appear to be a relationship between latitude and 
#number of frost days? Why or why not?

#ANSWER: Yes, excpet for the PNW, but that is probably because the ocean is regulating land temp. Higher latitudes are generally cooler. 

#Task: Write code to create a map of the Population data from the state.x77 dataset.
#You can reference the pevious steps of this assignment
#while you work through this task. make the color of the map any color that is
#not blue (as we have already used this color) **Make sure to write the code
#because your code will be viewed for grading, not the map itself!

state_popn <- state_data %>% 
  select(State, Population)

us_popn <- left_join(states, state_popn, by = "State")

us_popn2 <- us_popn %>%
  dplyr::filter(State != "Alaska" & State != "Hawaii" & State != "Guam" & State != 
                  "American Samoa" & State != "United States Virgin Islands" & 
                  State != "Puerto Rico" 
                & State != "Commonwealth of the Northern Mariana Islands")

ggplot(us_popn) +
  geom_sf(aes(fill= Population), color = "lightpink3") +
  theme_bw() +
  labs(fill = "Population", title = "United States Population Data")


ggplot(us_popn2) + 
  geom_sf(aes(fill = Population), color = "black") + 
  scale_fill_gradient(low = "lightpink", high = "deeppink4") +
  theme_bw() +  
  labs(fill = "Population", title = "United States Population Data")

#Task: write three things you can infer from the map that you created:
#1 California is the most populated state. 
#2 These populations are not about people. 
#3 Maine, Vermont, and New Hampshire are either under sampled, or has a low population

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
getwd()
# TASK: Using read.csv(), create an object titled "mammal_data" from the NC_mamm_data csv 
mammal_data <- read.csv("C:/Users/kelly/Documents/data wrangling/UNCG_DataWrangling/NC_mamm_data.csv")

# TASK: Using the colnames() function, review what columns exist in your current dataset
colnames(mammal_data)

# TASK: Remove the 'USE_LICENSE_URL' column using a pipe and the select(- ) 
# function because it is not needed for plotting. You do not need to create a new object for this; just reassign to the same name 'mammal_data' 

mammal_data <- mammal_data %>% 
  select(-USE_LICENSE_URL)

colnames(mammal_data)

# Using the rename() function introduced in assignment 4, rename the remaining 11 columns in the following order: country, state, locality, date, lat, long, sex, life_stage, genus, order, family.

mammal_data1 <- mammal_data %>%
  rename(
    country = COUNTRY,
    state = STATE_PROV,
    locality = SPEC_LOCALITY,
    date = VERBATIM_DATE,
    lat = DEC_LAT,
    long = DEC_LONG,
    sex = SEX,
    life_stage = LIFE_STAGE,
    genus = GENUS,
    order = PHYLORDER,
    family = FAMILY)

colnames(mammal_data1)

# Using the mammal_data object, clean NA values from columns 'lon', 'lat', 'locality' and 'genus'. Create new object for this cleaned data titled 'clean_data'

mammal_clean <- mammal_data1 %>%
  drop_na(long, lat, locality, genus)

colnames(mammal_clean)
head(mammal_clean)

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
#ANSWER: telling ggplot to map the us with all the counties.

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

#ANSWER: It's fixing the ratio so the map doesn't look funky.

# ADDING THE DATA POINTS TO NC MAP---------------------------------------------

# Using the 'clean_data' df we created, we can map these points onto out North Carolina map to see species occurrences! 
# To do this, we can add the geom_point function to our previous chunk of code.

# TASK: With a plus sign between the sections, add the lines below to the above code:
geom_point(data = mammal_clean,
           aes(x = lon, y = lat, color = order),
           size = 1,
           alpha = 0.7) 

ggplot() +
  geom_polygon(data = nc_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  geom_point(data = mammal_clean,
             aes(x = long, y = lat, color = order),
             size = 1,
             alpha = 0.7) +
  theme_dark()

# From here, you can adjust the theme to your liking. 
# NOTE: With a plus sign between sections, if you begin typing 'theme' on the next line, options will appear that you can browse through! 

# QUESTION: Why might it be useful to have slightly transparent data points (by setting alpha to a number below 1) when mapping in a small area such as this?  

#ANSWER: in case the data points are supper close together, it will help you better visualize. 

# TASK: after adding a theme to the plot, add and title and an x and y axis label with the labs() function. 

ggplot() +
  geom_polygon(data = nc_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  theme_minimal() +
  coord_fixed(1.5) +
  geom_point(data = mammal_clean,
             aes(x = long, y = lat, color = order),
             size = 1,
             alpha = 0.7) +
  theme_minimal() +
  labs(title = "Mammal captures in North Carolina",
       x = "Longitude",
       y = "Latitude")

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

ggplot() +
  geom_polygon(data = nc_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  theme_minimal() +
  coord_fixed(1.5) +
  geom_point(data = mammal_clean,
             aes(x = long, y = lat, color = genus),
             size = 1,
             alpha = 0.7) +
  theme_minimal() +
  labs(title = "Mammal captures in North Carolina",
       x = "Longitude",
       y = "Latitude")
#ANSWER: there are WAAAAAYYYYY too many genera. Order is more "orderly". 

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
clean_sf <- st_as_sf(mammal_clean, coords = c("long", "lat"), crs = 4326)

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
  scale_fill_viridis_c(option = "inferno", na.value = "gray90") +
  theme_bw() +
  labs(title = "Richness of Mammals in North Carolina",
       fill = "Genera count",
       x = "Longitude",
       y = "Latitude")

# QUESTION: What does changing the 'option' in scale_fill_viridis_c() do?

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

# ---------------------------------------------------------------------------- #
# INTERPRETING THE MAP --------------------------------------------------------

# QUESTION: What does a lighter color indicate on this map?

# QUESTION: Why might some counties have lower richness values? 


# TASK: Save your most recent plot as an image file to your folder. 
ggsave("nc_species_richness_map.png",width = 8, height = 6, dpi = 300)

