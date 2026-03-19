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
library(tigris) #??????????????????????????????????????????????
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

# Using the mammal_data object, clean NA values from columns 'lon', 'lat', 'locality' and 'genus'. Create new object for this cleaned data titled 'clean_data'
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
# TASK: With a plus sign between sections, if you begin typing 'theme' on the next line, options will appear that you can browse through! 


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

# QUESTION: Why did I decide to color the points by species order? What happens if you color the points (within the geom_point section) by genus instead? 


# Note: If we wanted to, we could subset out dataframe by species while still working in the data cleaning section, and only plot one species at a time, or focus on different families, etc.

# This shows us that  data cleaning provides many different opportunities for visualization! 


# MAPPING SPECIES RICHNESS ------------------------------------------------

# Using the same object we used for our map above (clean_data), we can create a map that colors counties along a gradient, based on species richness

# QUESTION: What package allows us to work with spatial vector data in R?
######### this question should come after you have them convert to sf. without explaining what you are doing, they won't know the answer to this question unless you explain it beforehand 


# QUESTION: How many columns are in the 'clean_data' dataset?

# Examine the structure of the dataset. 
str(clean_data)

# QUESTION: Which two columns contain the geographic coordinates?

# Check for missing coordinates. 
# TASK: Write the code for finding the missing coordinates. 
################ I think this is a good question to ask, but because I already removed all of the NA coordinates to create the clean_data object that I was plotting with, it wont really make sense. 

#QUESTION: Why is it important to check for missing coordinates? 
############ this question could still be added, but maybe explain somehow that we already removed NA rows within the lat and lon columns. 




# TASK: Convert data from the csv to an sf file using st_as_sf() function 
########################## there is no code for how this would be done in your answer key

# QUESTION: What coordinate reference system (CRS) did we assign?
############## they aren't going to know how to answer this question unless you just provide the code for the task above. you could add a "using this code" section to your comment and then just copy/paste your answer key answer 


# Confirm the object is now spatial. Run this code. 
class(mammal_data)

# QUESTION: What new class was added to the object?


# Load up the sf() function. We are going to convert the table to an sf object.
mammal_sf <- st_as_sf(
  clean_data,
  coords = c("lon", "lat"),
  crs = 4326
)

###########your previous code was pulling from an object called mammal_clean_data, which does not exist anywhere as far as I can tell, because you did not specify a title to have other people assign to the object they create. I updated the code to just pull from the 'clean_data' object I built in my section

# TASK: Check that the object exists
class(mammal_sf)

# Now let's plot the spatial points. Run this code. 
plot(st_geometry(mammal_sf))

# QUESTION: What does each point on the map represent?

# Calculate the species richness by genus. Let's run this code to find out:
richness_table <- mammal_sf %>%
  group_by(genus) %>%
  summarise(count = n())

# QUESTION: What function was used to count observations? 
######################### you could also ask them what the three most common species were, or something similar to see if they are understanding how that part works

# TASK: Now your turn to try. As we did above, count the number of observations
# per state. Write the code. 

####################### your answer key does not show how to do this, so I don't know how you got the state_counts object? 

# Inspect results
print(state_counts)

# QUESTION: Which state has the most records?

# Now we move on to making a simple map using our ggplot() function. Make sure 
# to load tidyverse and dplyr function before running the code below. 
ggplot(data = mammal_sf) + 
  geom_sf(aes(color = family)) +
  theme_minimal()


# QUESTION: What variable controls the color of points?

# TASK:Let's calculate the richness per family. Write out the code that can do 
# this for us. (HINT: we just did this above)

####################### once again, answer key needs to show how this is done


# View results
family_richness

# QUESTION: What does species_count represent?

# Let's create a gradient map based on richness. Run this code.
ggplot(mammal_sf) +
  geom_sf(aes(color = as.numeric(as.factor(genus)))) +
  scale_color_viridis_c() +
  theme_minimal()




################### this code might need to be fixed, because on my end, it is still plotting the dots in a gradient (presumably based on which genus was more common, which is good) rather than the counties


# QUESTION: What type of color scale is used here?

# Save the spatial dataset to your working directory. 

write.csv(mammal_sf, "mammal_sf.csv", row.names = FALSE)
saveRDS(mammal_sf, "mammal_sf.rds")

# QUESTION: What file type did we export? 



