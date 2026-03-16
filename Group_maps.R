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

# Read in mammal occurrence data
mammal_data <- read.csv("NC_mamm_data.csv")

#QUESTION: How many mammal records are included in this dataset, and how many
# different taxonomic groups represented?

# Inspect the structure of the dataset. Run this code.
str(mammal_data)

# View column names. Run this code.
colnames(mammal_data)

# Count number of unique genera. Run this code.
unique(mammal_data$genus)

# Count number of unique orders. Run this code. 
unique(mammal_data$order)

# Check number of unique localities. Run this code. 
unique(mammal_data$locality)

# TASK: Calculate the total number of records and count unique genera, families,
# and orders. 

#-----------------------------------------------------------------------------#
# DATA CLEANING
#-----------------------------------------------------------------------------#
# QUESTION: Which counties contain the highest number of mammal specimen records?
# TASK: Count how many observations occur in each county.


# Rename columns for easier use. Run this code.
colnames(mammal_data) <- c(
  "country",
  "state",
  "locality",
  "data",
  "lat",
  "long",
  "sex",
  "life_stage",
  "genus",
  "order",
  "family"
)

# Remove rows with missing coordinates or taxonomy information. Run this code.
clean_data <- mammal_data %>%
  drop_na(long, lat, locality, genus)

# Check the cleaned dataset. Run this code.
head(clean_data)

# Check the number of rows remaining. Run this code.
nrow(clean_data)

# QUESTION: Do counties with more sampling effort also show higher species
# richness?
# TASK: Join the record counts and richness values together. 
#-----------------------------------------------------------------------------#
# IMPORT NORTH CAROLINA COUNTRY MAP
#-----------------------------------------------------------------------------#
# QUESTION: What life stages are represented in the dataset?
# (HINT: run this code below)
life_stage_counts <- clean_data %>%
  count(life_stage)
life_stage_counts

# Get North Carolina county boundaries from maps package. Run this code.
nc_map <- map_data("county", region = "north carolina")

# Convert map to sf() format. Run this code. 
nc_countries <- st_as_sf(
  map("county", region = "north carolina", plot = FALSE, fill = TRUE)
)

# Check county data. Run this code. 
head(nc_countries)

#-----------------------------------------------------------------------------#
# SPATIAL JOIN
#-----------------------------------------------------------------------------#
# QUESTION: Which mammal orders appear most frequently in the dataset?

# Assign each mammal observation to a county polygon. Run this code.
mammal_county_join <- st_join(
  mammal_sf,
  nc_countries
)

# Inspect joined dataset. Run this code. 
head(mammal_county_join)

# TASK: Calculate the number of observations per order and visualize the results.

#------------------------------------------------------------------------------#
# CALCULATE SPECIES RICHNESS
#------------------------------------------------------------------------------#
# QUESTION: Which counties in North Carolina have the highest mammal species 
# richness?

# Calculate richness as number of unique genera per county. Run this code.
richness_table <- mammal_county_join %>%
  group_by(ID) %>%
  summarise(
    richness = n_distinct(genus)
)

# #QUESTION: How do different mammal orders appear spatially across the state?

# Inspect richness results. Run the code. 
head(richness_table)

#------------------------------------------------------------------------------#
# MERGE RICHNESS WITH COUNTY MAP
#------------------------------------------------------------------------------#

# Join richness values back to county polygons. Run this code.
nc_richness_map <- left_join(
  nc_counties,
  richness_table,
  by = "ID"
)

# Check merged dataset. Run this code.
head(nc_richness_map)

#QUESTION: Which countries appear to be biodiversity hotspots for mammals?
#TASK: Sort counties by richness to identify the top areas. 
#------------------------------------------------------------------------------#
# CREATE SPECIES RICHNESS MAP
#------------------------------------------------------------------------------#
#QUESTION: How does mammal species richness vary spatially across North Carolina?
# Plot the species richness map. Run this code. 
ggplot(data = nc_richness_map) +
  geom_sf(aes(fill = richness), color = "black") +
  scale_fill_viridis_c(
    option = "plasma",
    na.value = "gray90"
  ) + 
  theme_classic() +
  labs(
    title = "Mammal Species Richness Across North Carolina Counties",
    subtitle = "Based on museum specimen occurrence data",
    x = "Longitude",
    y = "Latitude",
    fill = "Species Richness"
)
# TASK: Create a choropleth map where counties are colored based on species 
# richness.
#------------------------------------------------------------------------------#
# SAVE THE MAP
#------------------------------------------------------------------------------#

# Save the map to file.
ggsave(
  filename = "NC_mammal_species_richness_map.png",
  width = 8,
  height = 6,
  dpi = 300
)
