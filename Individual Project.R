#Loading in any packages I might need
library(tidyverse)
library(stringr)
library(lubridate)
#Loading the data set into my script
plant_pollinators<-read.csv("SA02601_v6.csv", stringsAsFactors = FALSE)
#Going through the names to see how I might need to adjust them
colnames(plant_pollinators)
#Getting a full idea of all the types of observations I have
str(plant_pollinators)
summary(plant_pollinators)
head(plant_pollinators)
# Convert all titles to lowercase, so they are a more standard format
names(plant_pollinators) <- str_to_lower(names(plant_pollinators))
# Replace spaces or weird characters with underscore, to match naming formats
names(plant_pollinators) <- gsub(" ", "_", names(plant_pollinators))
names(plant_pollinators) <- gsub("\\.", "_", names(plant_pollinators))
#checking the names after adjusting them
names(plant_pollinators)
#To ensure that there are no human error extra characters, we are using the str_trim function on the priority columns
plant_pollinators <- plant_pollinators %>%
  mutate(
    pltsp_name = str_trim(pltsp_name),
    vissp_name = str_trim(vissp_name),
    meadow = str_trim(meadow),
    observer = str_trim(observer))
# Remove any columns that are difficult to understand or are not applicable, etc.
plant_pollinators <- plant_pollinators %>%
  select( -start_time, -end_time, -pltsp_code,-vissp_code, -ref_no, -vissp_no, 
          -qc_notes)
# Remove rows missing species info
plant_pollinators <- plant_pollinators %>%
  filter(!is.na(pltsp_name), !is.na(vissp_name))
# Remove empty strings
plant_pollinators <- plant_pollinators %>%
  filter(pltsp_name != "", vissp_name != "")
#Change any names that are very difficult to understand
plant_pollinators<-plant_pollinators %>%
  rename(plant_species=pltsp_name,
         visiter_name=vissp_name,
         visiter_type=vissp_type,)

#Code to go through and edit to how I want it ####
#Counting species interactions
interaction_counts <- plant_pollinators %>%
  group_by(plant_species, visiter_name) %>%
  summarise(visits = n(), .groups = "drop")

plant_visits <- plant_pollinators %>%
  group_by(plant_species) %>%
  summarise(total_visits = n(), .groups = "drop")

pollinator_visits <- plant_pollinators %>%
  group_by(visiter_name) %>%
  summarise(total_visits = n(), .groups = "drop")

#Top species code
top_plants <- plant_visits %>%
  arrange(desc(total_visits)) %>%
  slice(1:10)

top_pollinators <- pollinator_visits %>%
  arrange(desc(total_visits)) %>%
  slice(1:10)

#Top plants figure
ggplot(top_plants, aes(x = reorder(plant_species, total_visits), y = total_visits)) +
  geom_col(fill = "darkgreen") +
  coord_flip() +
  labs(
    title = "Top Plant Species by Visits",
    x = "Plant Species",
    y = "Visits"
  ) +
  theme_minimal()

#Top Pollinators Figure
ggplot(top_pollinators, aes(x = reorder(visiter_name, total_visits), y = total_visits)) +
  geom_col(fill = "orange") +
  coord_flip() +
  labs(
    title = "Top Pollinator Species",
    x = "Pollinator Species",
    y = "Visits"
  ) +
  theme_minimal()

#Heatmap figure
top_interactions <- interaction_counts %>%
  filter(plant_species %in% top_plants$plant_species,
         visiter_name %in% top_pollinators$visiter_name)

ggplot(top_interactions,
       aes(x = plant_species, y = visiter_name, fill = visits)) +
  geom_tile() +
  scale_fill_viridis_c() +
  labs(
    title = "Plant–Pollinator Interaction Heatmap",
    x = "Plant",
    y = "Pollinator"
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#individual project take 2
#link:https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-and.5216.8
#Citation:Seo, E., J.A. Jones, R.A. Hutchinson, and V.W. Pfeiffer. 2022. Plant Pollinator data at HJ Andrews Experimental Forest, 2011 to 2021 ver 8. Environmental Data Initiative. https://doi.org/10.6073/pasta/eec55cbc3dbfc56428629773737ab3e5 (Accessed 2026-03-15).

#This is a set of data that is a record of plants and their pollinators an how environmental factors such as soil moisture, temperature, and size of a meadow influences plant/pollinator relationships.Based on the data set the data was recorded by having someone watch a meadow and observe the plants in the meadow, and each time there was a pollinator and plant interaction a new observation was logged. Most meadow watches seemed to be about 3min, but it varies between person it looks like. This data set along with other collected by this set of people was done to add to the limited amount of long term recorded data about plant/pollinator relationships.This data was collected from 18 meadows in the Willamette national forest which is located in Oregon. Although the overall experiments tests influence of meadow size and soil moisture, the data set used for this project primarily records occurrence of plant pollinator interactions. Weather and wind measurements are consistently recorded throughout the data set, but temperature is not. There are large gaps throughout the data set that is missing temperature data which means I will be focusing on how temperature influences pollinators rather than the plants themselves since I do not have that soil temp recording. 

#Some things that I am interested in looking it as the the relationship between abiotic and biotic factors. I wonder if there is a correlation between wind or clouds and what type of insects visit the plant. My suspicion is that there will be less pollinators on windier days and cloudier days. I would also like to look at the types of insects that visit each type of plant.From a brief look at the data it looks like the genus Epicauta primarily has fly and beetle visitors rather than bee visitors.Although I am not provided info about the size of each meadow in this data set, I can compare the different meadows and plots to see differences in species diversity between them, and because this is a long term study I suspect that there will be plant diversity differences between the years.So, another one of my question is how has plant and pollinator diversity shifted overtime, and which meadows have more diversity, and which have less.

#When it comes to cleaning this data the first thing I would do is remove any information that is extra or unnecessary for the end dataset. That means columns such as DBCode and entity will be merged, observer will be removed, notes will be removed. All of the id information might be condensed so that there is less visual clutter. For example there is both a plotId and plot column when the plotId includes the plot column so there does not need to be both. I will want to move the minute observed closer to the species of the plant and visitor. I also am going to figure out what plant species there is the most data for and use that species of plant as the basis for my figures. There are some variables that I do not understand what they mean so I will change the contents of wind and clouds to contain descriptions that make more sense. I will get rid of the species code and visitor code columns and change the names of the species name and visitor name to be easier to understand.I then want to take the data and produce a histogram that shows how many insects visit each  species of plant. Then I would also like to make a dot plot that shows # of insects that arrive on a temperature gradient. To look at diversity overtime, I might need to make a mini dataset that contains summaries of how many occurrences per meadow per year there are, and this would be another data set that would benefit from choosing one species of plant rather than the many included in this data set.

