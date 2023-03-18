# R markdown 8.2 つ ◕_◕༽つ

#load lib
library(tidyverse)

#load df
df <- read.csv("TEMPEST_SERC_understory sppcomp_2021.csv", header = T)

#set a theme
theme_minimal()

# Create df: A species list that contains a column of all plant species found within the experiment 
# (no repeats and be sure to remove non-plants!).

splistnottidy <- as.data.frame(unique(df$species)) %>% rename("species" = "unique(df$species)")

#remove non plants
#identify rows by hand of non-plants bc lazy
# 1 is infrastructure cover so rm that
# 65 is bare ground so rm that

specieslist <- as.data.frame(splistnottidy[-c(1,65),]) %>% rename("species" = "splistnottidy[-c(1, 65), ]")

#create another df Just the treatment information (not species), a new column for replicate that pastes together 
#the plot and subplot columns (be sure to specify a separator), and a column that verbalized what each plot will be 
#(C=control, F=freshwater inundation, S=saltwater inundation). Also get rid of junk columns for less visual clutter

treatmentinfo <- df %>% select(-species) %>% mutate(replicate = paste(plot, subplot, sep = "")) %>% 
  mutate(plottype = ifelse(plot %in% "C", "Control", plot)) %>% 
           mutate(plottype = ifelse(plot %in% "F", "Freshwater inundation", plottype)) %>%
  mutate(plottype = ifelse(plot %in% "S", "Saltwater inundation", plottype)) %>% 
  select(-c("project_name":"season"))


              
                                  
