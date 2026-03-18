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
#code change within our dataset?

#Task: Because we have loaded the dyplr package, we can create a new dataframe
#with just State and Frost data. Write a code to select the State and Frost columns
#from the state_data dataframe and name the new dataframe state_frost_data. 
#View the new dataset and confirm that it is correct.

state_frost_data <- state_data %>% select(State, Frost)



states <- states(cb = TRUE)

states <- states %>% rename(State = NAME)

us_states_frost <- left_join(states, state_frost_data, by = c("State"))

ggplot(us_states_frost) +
  geom_sf(aes(fill = Frost), color = "blue") +
  theme_minimal() +
  labs(fill = "Number of Frost Days", title = "United States Frost Data")

# Part 3: MAPPING SPECIMEN OCCURRENCE DATA -----------------------------------

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

# TASK: Using the colnames() function, review what columns exist in your current dataset
colnames(mammal_data)

# TASK: Remove the 'USE_LICENSE_URL' column using a pipe and the select(- ) 
# function because it is not needed for plotting
mammal_data <- mammal_data %>%
  select(-USE_LICENSE_URL)

# Using the rename() function introduced in assignment 4, rename the remaining 11 columns in the following order: country, state, locality, date, lat, long, sex, life_stage, genus, order, family

mammal_data <- rename(.data=mammal_data,                                                             country=COUNTRY,
                      state=STATE_PROV,
                      locality=SPEC_LOCALITY,
                      date=VERBATIM_DATE,
                      lat=DEC_LAT,
                      lon=DEC_LONG,
                      sex=SEX,
                      life_stage=LIFE_STAGE,
                      genus=GENUS,
                      order=PHYLORDER,
                      family=FAMILY)

# Clean NA values from specified columns
clean_data <- mammal_data %>%
  drop_na(lon, lat, locality, genus)

# Great, now our data is clean and easier to work with! 


# BUILDING THE MAP

# First, using the function map_data() within the maps package we loaded at the start, we can build a dataframe that provides all counties within the United States. 

# TASK: Run this line of code, and look at the dataframe that appears in our environment box
counties <- map_data("county")

# Great, now we have a very large dataframe that gives us coordinates for every county in the United States. 
# TASK: To plot this, run the line of code below: 
ggplot() +
  geom_polygon(data = counties,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") 

# QUESTION: What do you think the geom_polygon function is doing here?


# TASK: Create a new dataframe that only has North Carolina counties by specifying the region as it appears in the counties dataframe previously built
nc_map <- map_data("county", region = "north carolina")


# plot the map
ggplot() +
  geom_polygon(data = counties,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") 








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



