# Map building in RStudio

# ---------------------------------------------------------------------------- #
## OBJECTIVES:
# 1. Understand when and why we may want to use R to build maps
# 2. Understand that there are many different ways to map spatial data within RStudio framework
# 3. Use packages such as maps and ggplot to map spatial data 
# 4. To learn how to find and import environmental spatial data sets


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

# Read in the data
mammal_data <- read.csv("NC_mamm_data.csv")

# Check data
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
             size = 2,
             alpha = 0.7) +
  coord_fixed(1.3) +
  theme_classic() +
  labs(title = "Mammal captures in North Carolina",
       x = "Longitude",
       y = "Latitude",
       color = "Order")



# MAPPING SPECIES RICHNESS IN NORTH CAROLINA ---------------------------------
# This script calculates mammal specie richness by country and maps the result.
# Make sure to start with tidyverse package first. Let's go ahead and run that.
#-----------------------------------------------------------------------------#
# IMPORT DATA 
#-----------------------------------------------------------------------------# 
# Make sure run tidyverse before starting this section. 
library(tidyverse)
# Read in mammal occurrence data.
mammal_data <- read.csv("NC_mamm_data.csv")

