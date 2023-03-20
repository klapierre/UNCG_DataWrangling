# R markdown 8.2 つ ◕_◕༽つ

#load lib
library(tidyverse)

#load df
df <- read.csv("TEMPEST_SERC_understory sppcomp_2021.csv", header = T)

#set a theme
theme_minimal()

#Get list of unique in species

unique(df$species)

#Get rid of rows that have non plant entries

dfplants <- df %>% filter(!str_detect(species,c("infrastructure")))  %>% filter(!str_detect(species,c("bare")))

# Create df: A species list that contains a column of all plant species found within the experiment 
# (no repeats and be sure to remove non-plants!).

SpeciesList <- as.data.frame(unique(dfplants$species)) %>% rename("species" = "unique(dfplants$species)")

#create another df Just the treatment information (not species), a new column for replicate that pastes together 
#the plot and subplot columns (be sure to specify a separator), and a column that verbalized what each plot will be 
#(C=control, F=freshwater inundation, S=saltwater inundation). Also get rid of junk columns for less visual clutter

treatmentinfo <- dfplants %>% mutate(replicate = paste(plot, subplot, sep = "")) %>% 
  mutate(plottype = ifelse(plot %in% "C", "Control", plot)) %>% 
  mutate(plottype = ifelse(plot %in% "F", "Freshwater inundation", plottype)) %>%
  mutate(plottype = ifelse(plot %in% "S", "Saltwater inundation", plottype)) %>% 
  select(-c("project_name":"season")) %>% select(-sampler,-notes)

#calculate plant species richness (the total number of plant species) for each subplot.

subplotsprich <- treatmentinfo %>% group_by(subplot) %>% summarise(richness = n_distinct(species)) %>% ungroup()

mean_richness <- dfplants %>%
  group_by(plot) %>%
  summarise(mean_richness = mean(n_distinct(species), na.rm = TRUE))






