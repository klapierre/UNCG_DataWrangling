# BAILEY SECTIONNNNNN


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

# TASK: Using the colnames() function, review what columns exist in your current dataset

# TASK: Remove the 'USE_LICENSE_URL' column using a pipe and the select(- ) 
# function because it is not needed for plotting

# Using the rename() function introduced in assignment 4, rename the remaining 11 columns in the following order: country, state, locality, date, lat, long, sex, life_stage, genus, order, family

# Using the mammal_data object, clean NA values from columns 'lon', 'lat', 'locality' and 'genus'. Create new object for this cleaned data titled 'clean_data'

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

# TASK: plot the map using your new nc_map dataframe using the previous map code as your guide
# HINT: to adjust the map size, add the function coord_fixed(1.5) to the end of the code


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

