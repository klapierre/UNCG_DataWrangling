title: "Larrea Population"
author: "Mariii Huff"
date:  "May 2026"


## Project Overview ----------------------------------------------------------
This project analyzes a dataset examining variation in growth environment among 
populations of Larrea species. The dataset was obtained from the repository 
maintained by the Environmental Data Initiative and includes observations 
collected between 2006 and 2009 from multiple geographic locations across 
North and South America. The study focuses on two species, Larrea tridentata 
and Larrea divaricata, which are desert shrubs commonly found in arid 
environments. Data were collected from several sites including the Sevilleta 
National Wildlife Refuge in New Mexico, locations in Mexico, and sites in 
Argentina. The dataset includes variables such as species, site location, 
latitude, and growth environment, which allow researchers to examine how 
environmental conditions differ across plant populations. The goal of this 
project is to investigate how growth environment varies among Larrea populations
across species and geographic locations. Specifically, this project will explore
whether patterns in growth environment differ between species or across different 
sites. I hypothesize that growth environment will vary among locations because 
plants growing in different regions experience different environmental conditions 
such as temperature, soil composition, and water availability. Understanding 
these patterns may help explain how environmental factors influence plant 
populations and contribute to processes such as Local Adaptation.
## Pseudocode------------------------------------------------------------------ 
  First, the dataset will be imported into R from the downloaded CSV file. 
Next, the structure of the dataset will be examined to identify the variables 
and check for missing values. The data will then be cleaned by filtering out 
rows with missing values in key variables such as species, latitude, and growth
environment. After cleaning the data, summary statistics will be calculated to 
understand the distribution of observations across species and growth 
environments. Several visualizations will then be created, including bar graphs
and scatterplots, to explore patterns between species, geographic location, 
and growth environment. Finally, the patterns observed in the graphs will 
be interpreted to determine whether growth environments vary among Larrea 
populations across different locations.
 ## Objectives-----------------------------------------------------------------
  1. To examine variation in Larrea species across different environmental 
conditions.
  2. To compare the distribution of Larrea species between high and low latitude 
categories.
  3. To explore differences in species occurence across growth environments. 
-------------------------------------------------------------------------------
## Load Libraries------------------
## Install if needed 
install.packages("tidyverse")
## Load packages 
library(tidyverse)
--------------------------------------------------------------------------------
## Import the dataset---------------
NOTE: Link to datset is below. Please use the dataset that under the file named
"sev227_larreafreeze_20140107.csv"
https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-sev.227.275475
## Download the csv file and then put it in your working directory
## Read in the dataset
larrea_data <- read_csv("sev227_larreafreeze_20140107.csv")
-------------------------------------------------------------------------------
## Explore the datset------
##  View structure 
str(larrea_data)
## Summary statistics 
summary(larrea_data)
## Preview dataset
head(larrea_data)
--------------------------------------------------------------------------------
## Clean the dataset------
## NOTE: Adjust column names if they are slightly different; if so, run this code
## and then tweak the code to match 
colnames(larrea_data)
## Remove missing values in key variables
clean_data <- larrea_data %>%
  drop_na(species,latitude,growth_environment)
## Check results 
summary(clean_data)
--------------------------------------------------------------------------------
## Summary Statistics -----------
## Count the number of observations by species 
clean_data %>%
  count(species)
## Count the number of observations by species and growth environment
clean_data %>%
  count(species,growth_environment)
## NOTE: Run these two lines of code first before running the next part
str(clean_data$latitude)
clean_data <- clean_data %>%
  mutate(latitude = as.numeric(latitude))
## Summary of latitude by species 
clean_data %>%
  group_by(species)%>%
  summarise(
    mean_latitude = mean(latitude, na.rm = TRUE),
    sd_latitude = sd(latitude, na.rm = TRUE)
  )
--------------------------------------------------------------------------------
## Visualizations------
## Bar graph: Growth environment by species 
ggplot(clean_data,aes(x=growth_environment,fill=species))+
  geom_bar(position = "dodge")+
  labs(
    title = "Growth Environment by Species",
    x = "Growth Environment", 
    y = " Count"
  ) +
  theme_minimal()
## NOTE: run this code for the graph
rm(clean_data)
clean_data <- larrea_data
nrow(clean_data)
table(clean_data$latitude)

##  Facet by site 
ggplot(clean_data,aes(x=latitude, y=growth_environment,color=species))+ 
  geom_jitter(alpha = 0.7) +
  facet_wrap(~ population) +
  theme_minimal()

