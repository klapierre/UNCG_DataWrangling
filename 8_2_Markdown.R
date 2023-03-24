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

dfplants <- df %>% filter(!str_detect(species,c("infrastructure")))  %>% filter(!str_detect(species,c("bare"))) %>% filter(!str_detect(species,c("basal"))) %>% 
  filter(!str_detect(subplot,c("additional")))

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
  select(-c("project_name":"season")) %>% select(-sampler,-notes, -species,-cover)

#Calculate the total herbaceous plant cover (remove non-plants) for each subplot in a new data frame, removing any "additional" species. 
#The join that data frame back onto the original cover data. Calculate the relative cover for each species as 100*(species cover/total cover).

totalHERBcover <- dfplants %>% group_by(subplot) %>% mutate(totalcover = sum(cover)) %>% ungroup()

Speciesrelativecover <- totalHERBcover %>% group_by(species) %>% mutate(relativecover = (100 * (cover/totalcover))) %>% ungroup()

#calculate plant species richness (the total number of plant species) for each subplot.

subplotsprich <- dfplants %>% group_by(subplot) %>% mutate(subplotrichness = n_distinct(species)) %>% ungroup()

plotrichness <- subplotsprich %>% group_by(plot) %>% mutate(plotrichness = n_distinct(species)) %>% ungroup()

# make funtion to calc St err bc lazy lol

std.error <- function(x) sd(x)/sqrt(length(x))

#calc mean sp rich @ plot level

MeanSpRichandStdErr <- plotrichness %>%  group_by(plot) %>% mutate(meanspeciesrichness = mean(subplotrichness)) %>% 
  mutate(speciesrichnessSTDERR = std.error(subplotrichness)) %>% ungroup()

# In another dataframe, calculate plant species richness at the plot level (including the additional species not found in the subplot data).

PlantSpeciesRichOnly <- MeanSpRichandStdErr %>% group_by(plot) %>% summarise(speciesrich = n_distinct(species)) %>% ungroup()

#Bar graph of richness per plot (plot on x-axis) showing the mean and standard error across subplots.

ggplot(MeanSpRichandStdErr, aes(x = plot, y = meanspeciesrichness), fill = as.factor(plot)) +
  geom_bar(stat = "identity") +
  geom_errorbar(aes(ymin = meanspeciesrichness - speciesrichnessSTDERR, 
                    ymax = meanspeciesrichness + speciesrichnessSTDERR)) + ylim(0, 50) + xlab("Plot") + ylab("Mean Subplot Species Richness")

#Another bar graph showing the richness at the plot level (plot on x-axis).  
ggplot(PlantSpeciesRichOnly, aes(x = plot, y = speciesrich)) +
  geom_bar(stat = "identity") + xlab("Plot") + ylab("Species Richness (at plot level)")



#Calculate the average relative cover for each species across all subplots within each plot. Then calculate the average relative cover for each species across all plots. 
#In the end you should have a data frame with two columns: species and average relative cover.

species_cover <- dfplants %>%
  group_by(plot, species) %>%
  summarise(avg_rel_cover = mean(cover))

# Calculate the average relative cover for each species across all plots

species_cover_all <- species_cover %>%
  group_by(species) %>%
  summarise(avg_rel_cover = mean(avg_rel_cover))

#Sort the data frame you created from highest to lowest relative cover. Hint: use code to do this otherwise it won't stick! 
#Look into the arrange() function if you're unsure.

?arrange

Sp_cov_ranked <- species_cover_all %>% arrange(desc(avg_rel_cover))

#Create a new column in your data frame that gives each species a rank (number from 1 to X) based on their abundance where 1=most abundant.

Sp_cov_ranked <- Sp_cov_ranked %>% mutate(number = 1:91)

#ake a figure with points connected by lines of the rank on the x-axis and the relative cover on the y-axis. 
#Use geom_text to label your points with the species names and be sure to give your axes intelligible labels.

ggplot(Sp_cov_ranked, aes(x = number, y = avg_rel_cover)) +
  geom_point() +
  geom_line() +
  geom_text(aes(label = species)) +
  xlab("Rank") +
  ylab("Avg Relative Cover")


#Calculate the mean and standard error for each species relative cover by plot. Make a bar graph of these means and 
#standard errors, with plot on the x-axis and faceted by species, for the following species: 
#Berberis thunbergii, Botrychium dissectum, Carex sp, Elaeagnus umbellata, Epifagus virginiana, 
#Gallium circaezans, Ilex opaca, Lindera benzoin, Lonicera japonica, Mitchella repens, Parthenocissus 
#quinquefolia, Polygonum virginianum, Rhus radicans, Rubus phoenicolasius, Sceptridium biternatum, 
#Symphotrichium lateriflorum. Be sure to allow y-axis scale to vary in your facet statement.

species_cover_plot_mean_se <- dfplants %>%
  group_by(plot, species) %>%
  mutate(avg_rel_cover = mean(cover)) %>% mutate(stderror = std.error(cover)) %>% ungroup()


#make subest idk

subsetneeded <- species_cover_plot_mean_se %>% filter(str_detect(species,c("Berberis thunbergii", "Botrychium dissectum", "Carex sp", "Elaeagnus umbellata", "Epifagus virginiana", 
"Gallium circaezans", "Ilex opaca", "Lindera benzoin", "Lonicera japonica", "Mitchella repens", "Parthenocissus 
quinquefolia", "Polygonum virginianum", "Rhus radicans", "Rubus phoenicolasius", "Sceptridium biternatum", 
"Symphotrichium lateriflorum")))

ggplot(subsetneeded, aes(x = plot, y = avg_rel_cover), fill = as.factor(plot)) +
  geom_bar(stat = "identity") +
  geom_errorbar(aes(ymin = avg_rel_cover - stderror, 
                    ymax = avg_rel_cover + stderror)) +
  facet_wrap(~species, scales = "free")


















