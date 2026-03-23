# MAP BUILDING IN RSTUDIO

# ---------------------------------------------------------------------------- #
# OBJECTIVES:
# 1. Understand when and why we may want to use R to build maps
# 2. Understand that there are many different ways to map spatial data within RStudio framework
# 3. Use packages such as maps and ggplot to map spatial data 
# 4. To learn how to find and import environmental spatial data sets



# Part 1: Loading packages ------------------------------------------------

# NOTE: you may need to write the line install.packages(" ") before loading these packages into your library if you have not used them before!
library(tidyverse)
library(ggplot2)
library(maps)
library(dplyr)
library(tigris)
library(sf)

#Run the following code:
options(tigris_use_cache = TRUE)

# Part 2: SECTION TITLE  ------------------------------------------------------

#Task: We will start by loading the state.x77 dataset
#into R as a dataframe and using the cbind() function to create a column named
#"State" with all states listed from the row names in the state.x77 dataset.

state_data <- cbind(
  State = rownames(state.x77),
  as.data.frame(state.x77))

#Run the following code to display your data
head(state_data)

#Question: What do you notice about the rownames and the data within the "State" 
#column? 

#Task: Run the following code:
rownames(state_data) <- NULL

#Question: Write code to display your dataset once again. What did the previous
#code change within the dataset? What did NULL do to the rownames?

#Task: Because we have loaded the dyplr package, we can create a new dataframe
#with just State and Frost data. Write a code to select the State and Frost columns
#from the state_data dataframe and name the new dataframe state_frost_data. 
#View the new dataset and confirm that it is correct.
state_frost_data <- state_data %>% select(State, Frost)

#Now we need to use the tigris package to download a shapefile called 'states'
#of all of US states that we would like to plaot. We set cb = TRUE 
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

ggplot(us_states_frost_2) +
  geom_sf(aes(fill = Frost), color = "blue") +
  theme_minimal() +
  labs(fill = "Number of Frost Days", title = "United States Frost Data")

#Question: Do you see a map under the "plots" tab?
#Question: What do dark blue states represent? What do light blue states represent?
#Question: Does florida or NC have more frost days? How do you know this?

#What do you notice about the size of this map? Suppose we only want
#to study frost data of mainland US states. Are there states we could omit from
#this map to better visualize the data? HINT ** to help determine which states we may 
#want to omit, check out the us_states_frost_2 tab at the different States included
#in the dataframe.

#To filter out states or islands not connected to the mainland US, we can use the 
#dplyr function.

#Task: Run the following code to filter out and omit states that are islands
#not connected to the mainland US.

us_states_frost_2 <- us_states_frost %>%
  dplyr::filter(State != "Alaska" & State != "Hawaii" & State != "Guam" & State != 
                  "American Samoa" & State != "United States Virgin Islands" & 
                  State != "Puerto Rico" 
                & State != "Commonwealth of the Northern Mariana Islands")


#Task: Write code to reate a map of your choice using another column of data from
#the state.x77 dataset. You can reference the pevious steps of this assignment
#while you work through this task. make the color of the map any color that is
#not blue (as we have already used this color) **Make sure to write the code
#because your code will be viewed for grading, not the map itself!

# Part 3: MAPPING SPECIMEN OCCURRENCE DATA -------------------------------------

# In this section, we are going to learn how to find and plot specimen (or species) occurrence data from North Carolina. First, we need to find a dataset to download. I want to map mammals collected in North Carolina. 

# To find an appropriate dataset, I queried the opensource museum data sharing
# platform Arctos to gather mammal records North Carolina.
# Here is the link to the website: https://arctos.database.museum/

# To filter the records, I specified "Mammalia" in the "Any taxon, ID, common    # name" box within the Identification field, and "North Carolina" in the
# "state_prov" box within the Place field. 

# It is free to make an account and search+download records, but I shared a csv 
# file in the the email I sent out for those who do not have an account already 
# made. 

# TASK: Download the NC_mamm_data.csv into your UNCG_DataWrangling folder on your desktop

# TASK: Create an object titled "mammal_data" from the NC_mamm_data csv 
mammal_data <- read.csv("NC_mamm_data.csv")


# Review your data using the unique() function, pulling from the object mammal_data to see the column names, the unique localities, unique genera, and unique orders
colnames(mammal_data)
unique(mammal_data$locality) #238 unique localities
unique(mammal_data$genus) #50 unique genera
unique(mammal_data$order) #15 unique orders - for the sake of this assignment, we will plot specimens grouped by color 

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

# QUESTION: What package allows us to work with spatial vector data in R?

# Import the dataset. run this code.
mammal_data <- read.csv("NC_mamm_data.csv")

# Inspect first rows
head(mammal_data)

# QUESTION: How many columns are in the dataset?

# Examine the structure of the dataset. 
str(mammal_data)

# QUESTION: Which two columns contain the geographic coordinates?

# Check for missing coordinates. 
# TASK: Write the code for finding the missing coordinates. 

#QUESTION: Why is it important to check for missing coordinates? 


# TASK: Convert data from the csv to an sf file using st_as_sf() function 

# QUESTION: What coordinate reference system (CRS) did we assign?

# Confirm the object is now spatial. Run this code. 
class(mammal_data)

# QUESTION: What new class was added to the object?


# Load up the sf() function. We are going to convert the table to an sf object.
mammal_sf <- st_as_sf(
  mammal_data_clean,
  coords = c("DEC_LONG", "DEC_LAT"),
  crs = 4326
)

# Check that the object exists.
class(mammal_sf)

# Now let's plot the spatial points. Run this code. 
plot(st_geometry(mammal_sf))

# QUESTION: What does each point on the map represent?

# Calculate the species richness by genus. Le't run this code to find out.
richness_table <- mammal_sf %>%
  group_by(GENUS) %>%
  summarise(count = n())

# QUESTION: What function was used to count observations? 

# TASK: Now your turn to try. As we did above, count the number of observations
# per state. Write the code. 

# Inspect results
print(state_counts)

# QUESTION: Which state has the most records?

# Now we move on to making a simple map using our ggplot() function. Make sure 
# to load tidyverse and dplyr function before running the code below. 
ggplot(data = mammal_sf) + 
  geom_sf(aes(color = FAMILY)) +
  theme_minimal()

library(tidyverse)
library(dplyr)

# QUESTION: What variable controls the color of points?

# TASK:Let's calculate the richness per family. Write out the code that can do 
# this for us. (HINT: we just did this above)

# View results
family_richness

# QUESTION: What does species_count represent?

# Let's create a gradient map based on richness. Run this code.
ggplot(mammal_sf) +
  geom_sf(aes(color = as.numeric(as.factor(GENUS)))) +
  scale_color_viridis_c() +
  theme_minimal()

# QUESTION: What type of color scale is used here?

# Save the spatial dataset to your working directory. 

write.csv(mammal_sf, "mammal_sf.csv", row.names = FALSE)
saveRDS(mammal_sf, "mammal_sf.rds")

# QUESTION: What file type did we export? 



