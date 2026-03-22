# MAP BUILDING IN RSTUDIO

# ---------------------------------------------------------------------------- #
# OBJECTIVES:
# 1. Understand when and why we may want to use R to build maps
# 2. Understand that there are many different ways to map spatial data within RStudio framework
# 3. Use packages such as maps and ggplot to map spatial data 
# 4. To learn how to find and import environmental spatial data sets

# Part 1: LOAD PACKAGES --------------------------------------------------------

# NOTE: you may need to write the line install.packages(" ") before loading these packages into your library if you have not used them before!
library(tidyverse)
library(ggplot2)
library(maps)
library(dplyr)
library(tigris)
library(sf)

#Run the following code:
options(tigris_use_cache = TRUE)

# Part 2: MAPPING WITH INTERNAL GGPLOT DATASETS --------------------------------

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

# TASK: Create an object titled "mammal_data" from the NC_mamm_data csv 
mammal_data <- read.csv("NC_mamm_data.csv")

# TASK: Using the colnames() function, review what columns exist in your current dataset
colnames(mammal_data)

# TASK: Remove the 'USE_LICENSE_URL' column using a pipe and the select(- ) 
# function because it is not needed for plotting
mammal_data <- mammal_data %>%
  select(-USE_LICENSE_URL)

# Using the rename() function introduced in assignment 4, rename the remaining 11 columns in the following order: country, state, locality, date, lat, long, sex, life_stage, genus, order, family

mammal_data <- rename(.data=mammal_data,                                               country=COUNTRY,
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

# Using the mammal_data object, clean NA values from columns 'lon', 'lat', 'locality' and 'genus'. Create new object for this cleaned data titled 'clean_data'
clean_data <- mammal_data %>%
  drop_na(lon, lat, locality, genus)

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

# TASK: Create a new dataframe titled 'nc_map' that only has North Carolina counties by specifying the region as it appears in the counties dataframe previously built
nc_map <- map_data("county", region = "north carolina")

# TASK: plot the map using your new nc_map dataframe using the previous map code as your guide
# HINT: to adjust the map size, add the function coord_fixed(1.5) to the end of the code
ggplot() +
  geom_polygon(data = nc_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  theme_bw() +
  coord_fixed(1.5) 
  
# QUESTION: What do you think the 'coord_fixed' function is doing here? 

# ADDING THE DATA POINTS TO NC MAP---------------------------------------------

# Using the 'clean_data' df we created, we can map these points onto out North Carolina map to see species occurrences! 
# To do this, we can add the geom_point function to our previous chunk of code.

# TASK: With a plus sign between the sections, add the lines below to the above code:
geom_point(data = clean_data,
           aes(x = lon, y = lat, color = order),
           size = 1,
           alpha = 0.7)

# From here, you can adjust the theme to your liking. 
# NOTE: With a plus sign between sections, if you begin typing 'theme' on the next line, options will appear that you can browse through! 


# TASK: after adding a theme to the plot, add and title and an x and y axis label with the labs() function. 


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

# HINT: the unique() function allows us to see how many unique values are in each of our columns 
unique(clean_data$genus)
unique(clean_data$family)
unique(clean_data$order)


# Note: If we wanted to, we could subset out dataframe by species while still working in the data cleaning section, and only plot one species at a time, or focus on different families, etc.


# This shows us that  data cleaning provides many different opportunities for visualization! 

# MAPPING SPECIES RICHNESS ---------------------------------------------------

# Using the same object we used for our map above (clean_data), we can create a map that colors counties along a gradient, based on species richness from our capture data.

# In this section, we will build on our previous map by calculating and mapping
# species richness across North Carolina counties. Species richness refers to
# the number of unique species (or taxa) observed in a given area.

# Instead of plotting individual points, we will summarize how many different
# genera occur within each county and display this as a gradient map.

# ---------------------------------------------------------------------------- #
# PREPARING DATA FOR SPECIES RICHNESS -----------------------------------------

# TASK: Load necessary library for spatial joins
library(dplyr)

# TASK: Inspect the clean_data dataframe again
head(clean_data)

# QUESTION: What columns could we use to represent "species richness"?

#TASK: Create NC county map 
nc_map <- map_data("county", region = "north carolina")



# ---------------------------------------------------------------------------- #
# CALCULATING SPECIES RICHNESS ------------------------------------------------
# Now we calculate richness based on the number of unique orders per county

#TASK: Group data county and calculate richness using 'order' 
richness_data <- clean_data%>%
  group_by(locality)%>%
  summarize(richness = n_distinct(order))
 

# ---------------------------------------------------------------------------- #
# ASSIGNING COUNTIES TO EACH POINT--------------------------------------------

# Make names match 
clean_data$locality <- tolower(clean_data$locality)
nc_map$subregion <- tolower(nc_map$subregion)

# TASK Join richness to map
nc_richness_map <-nc_map%>%
  left_join(richness_data, by = c("subregion" = "locality"))

# Replace NA with 0
nc_richness_map$richness[is.na(nc_richness_map$richness)] <- 0
# ---------------------------------------------------------------------------- #
# BUILDING THE RICHNESS MAP ---------------------------------------------------

# TASK: Plot the North Carolina counties and fill by richness values
library(ggplot2)

ggplot() +
  geom_polygon(data = nc_richness_map,
               aes(x = long, y = lat, group = group, fill = richness), 
               color = "black") +
 theme_bw() + 
  coord_fixed(1.5)+ 
  scale_fill_viridis_c(option = "plasma", na.value = "gray90") + 
  labs(title = "Order Richness of Mammals in North Carolina", 
       fill = "Richness", 
       x = "Longitude",
       y = "Latitude" )

# QUESTION: Why were some counties removed in the original map?

# ---------------------------------------------------------------------------- #
# IMPROVING THE MAP -----------------------------------------------------------

# Now that we have added a title and labels, we can further improve the map by
# adjusting the color scale and overall appearance to make patterns easier to see.

# TASK: Customize the color gradient to better highlight differences in richness
ggplot() +
  geom_polygon(data = nc_richness_map,
               aes(x = long, y = lat, group = group, fill = richness), 
               color = "black") +
  scale_fill_viridis_c(option = "inferno", direction = -1) +
  theme_bw() +
  labs(title = " Order Richness of Mammals in North Carolina",
       fill = "Richness",
       x = "Longitude",
       y = "Latitude")

# QUESTION: What does changing the 'option' in scale_fill_viridis_c() do?

# ---------------------------------------------------------------------------- #

# TASK: Remove county borders to create a smoother, cleaner map appearance
ggplot() +
  geom_polygon(data = nc_richness_map, 
               aes(x = long, y = lat, group = group, fill = richness), 
               color = NA) +
  scale_fill_viridis_c(option = "magma") +
  theme_minimal() +
  labs(title = "Order Richness of Mammals in North Carolina",
       fill = "Richness")

# QUESTION: How does removing borders change the look of the map?


# ---------------------------------------------------------------------------- #

# TASK: Adjust legend position for better readability
ggplot() +
  geom_polygon(data = nc_richness_map,
               aes(x = long, y = lat, group = group, fill = richness), 
               color = "black") +
  scale_fill_viridis_c() +
  theme_bw() +
  theme(legend.position = "right") +
  labs(title = " Order Richness of Mammals in North Carolina",
       fill = "Richness",
       x = "Longitude",
       y = "Latitude")

# QUESTION: Why might changing the legend position be useful?

# ---------------------------------------------------------------------------- #
# INTERPRETING THE MAP --------------------------------------------------------

# QUESTION: What does a darker color indicate on this map?

# QUESTION: Why might some counties have lower richness values? 


# TASK: Save your most recent plot as an image file to your folder. 
ggsave("nc_species_richness_map.png",width = 8, height = 6, dpi = 300)
