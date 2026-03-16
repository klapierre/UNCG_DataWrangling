# Map building in RStudio
#mariii
#pattie
#Write a code to install the packages ggplot2, maps, dyplr, tigris, and sf
#Run the following code to load the packages into your library:

#Test


library(ggplot2)
library(maps)
library(dplyr)
library(tigris)
library(sf)

#Run the following code:
options(tigris_use_cache = TRUE)


state_data <- cbind(
  State = rownames(state.x77),
  as.data.frame(state.x77)
)

rownames(state_data) <- NULL

head(state_data)

state_frost_data <- state_data %>% select(State, Frost)

head(state_frost_data)

states <- states(cb = TRUE)

states <- states %>% rename(State = NAME)

us_states_frost <- left_join(states, state_frost_data, by = c("State"))

ggplot(us_states_frost) +
  geom_sf(aes(fill = Frost), color = "blue") +
  theme_minimal() +
  labs(fill = "Number of Frost Days", title = "United States Frost Data")



# ---------------------------------------------------------------------------- #
## OBJECTIVES:
# 1. Understand when and why we may want to use R to build maps
# 2. Understand that there are many different ways to map spatial data within RStudio framework
# 3. Use packages such as maps and ggplot to map spatial data 
# 4. To learn how to find and import environmental spatial data sets



#HELLOOOOOO


# MAPPING SPECIMEN OCCURRENCE DATA ------------------------------------------

# In this section, we are going to learn how to find and plot mammal occurrence
# data from North Carolina. First, we need to find a dataset to download. 

# To find an appropriate dataset, I queried the opensource museum data sharing
# platform Arctos (arctos.org) to gather mammal records North Carolina.
# Here is the link to the website: https://arctos.database.museum/

# It is free to make an account and search+download records, but I shared a csv 
# file in the the email I sent out for those who do not have an account already 
# made. 

# To filter the records, I specified "Mammalia" in the "Any taxon, ID, common name"
# box within the Identification field, and "North Carolina" in the "state_prov" 
# within the Place field

# Once we have the csv file saved in our UNCG_DataWrangling folder on our 
# desktops, we will need to begin cleaning the file to make it easier to work with

# LOAD REQUIRED PACKAGES
library(tidyverse)
library(ggplot2)
library(maps)
library(sf)
library(dplyr)

# To read in the data, create an object titled "mammal_data" from the NC_mamm_data csv 
mammal_data <- read.csv("NC_mamm_data.csv")

# Review your data using the unique() function, pulling from the object mammal_data to see the column names, the unique localities, unique genera, and unique orders
colnames(mammal_data)
unique(mammal_data$locality) #238 unique localities
unique(mammal_data$genus) #50 unique genera
unique(mammal_data$order) #15 unique orders - for the sake of this assignment, we will plot specimens groupped by color 

# Remove the 'USE_LICENSE_URL' column because it is not needed for plotting
mammal_data <- mammal_data %>%
  select(-USE_LICENSE_URL)

# Rename remaining columns
colnames(mammal_data) <- c("country", "state", "locality", "date", "lat", "long", "sex", "life_stage", "genus", "order", "family")

# Clean NA values from specified columns
clean_data <- mammal_data %>%
  drop_na(long, lat, locality, genus)

# Get North Carolina county map
nc_map <- map_data("county", region = "north carolina")

# Create the combined map
ggplot() +
  geom_polygon(data = nc_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  geom_point(data = clean_data,
             aes(x = long, y = lat, color = order),
             size = 1,
             alpha = 0.7) +
  coord_fixed(1.3) +
  theme_classic() +
  labs(title = "Mammal captures in North Carolina",
       x = "Longitude",
       y = "Latitude",
       color = "Order")


# MAPPING SPECIES RICHNESS ------------------------------------------------

# Using the same csv we used for our map above, we can create a map that colors counties along a gradient based on species richness 


# convert data from the csv to an sf file using st_as_sf() function 