#First I will download both datasets from the 'DRYAD' website:
##Link to website: https://datadryad.org/dataset/doi:10.5061/dryad.1g1jwsv6d#readme
###Download and load datasets: BB_Diss_Traits_10-22-24.csv & Bombus_PikesPeak_07_24_24.csv
library(readr)
read_csv("Bombus_PikesPeak_07_24_24.csv")
read_csv("BB_Diss_Traits_10-22-24.csv")
#I viewed both datasets:
View(Bombus_PikesPeak_07_24_24)
View(BB_Diss_Traits_10-22-24)
#The 'BB_Diss_Traits_10_22_24' dataset contains bumble bee trait data such as species, body size, phenology, and tongue length.
#For convience, I renamed the dataset to 'bumble_bee_traits'
bumble_bee_traits<-read_csv("BB_Diss_Traits_10-22-24.csv")
#The 'Bombus_PikesPeak_07_24_24' dataset contains bumble bee and flower interaction data.
#For convience, I renamed the dataset to 'bee_flower'
bee_flower<-read_csv("Bombus_PikesPeak_07_24_24.csv")
#The first question I would like to adress is whether there is a trait overlap (body size, phenology, and tnogue length) as elevation increases.
##First I want to select the 'pol_sp' and 'ele_m' columns from 'bee_flower' data into a new dataset 'bee_elevation'. 
###This allows me to analyze bumble bee species vs elevation. 
library(dplyr)
bee_elevation<-bee_flower %>% 
  select(pol_sp,ele_m)
#There are duplicated species. I created a new dataset 'avg_bee_elevation' and fixed this by grouping the pol_sp column from 'bee_elevation' data. 
##I calculated the average of elevation (ele_m column) for each species from 'bee_elevation' data. 
avg_bee_elevation<-bee_elevation %>% 
  group_by(pol_sp) %>% 
  summarise(mean_ele_m=mean(ele_m,na.rm = TRUE))
#I renamed the 'pol_sp' and 'mean_ele_m' columns to 'species' and 'elevation'
avg_bee_elevation<-avg_bee_elevation %>% 
  rename(species=pol_sp,
       elevation=mean_ele_m)
#I added the 'species' and 'elevation' column from the 'avg_bee_elevation' dataset into a new dataset 'bee_trait_elevation'.
bee_trait_elevation<-avg_bee_elevation %>% 
  select(species,elevation )
#From 'bumble_bee_traits' dataset, I renamed the 'bb.species' column to 'species'.
bumble_bee_traits<-bumble_bee_traits %>% 
  rename(species=bb.species)
#In the 'bumble_bee_traits' dataset, I selected the following average/mean columns for traits: wbsmidwilliams, phenologyavgw, and wtonguemean into the dataset 'bee_trait_elevation'
bee_trait_elevation<-avg_bee_elevation %>% 
  left_join(
    bumble_bee_traits %>% 
      select(species, wbsmidwilliams, phenologyavgw, wtonguemean),
    by="species")
#The Bombus insularis specie in row 12 has 'NA' values for wbsmidwilliams, phenologyavgw, and wtonguemean. I filtered this row out since we will not be able to plot it's traits.
bee_trait_elevation<-bee_trait_elevation %>% 
  filter(species !="Bombus insularis")
#I renamed the columns so that I understand each trait better.
  bee_trait_elevation<-bee_trait_elevation %>% 
    rename(bodysize=wbsmidwilliams,
           phenology=phenologyavgw,
           tongue_length=wtonguemean)
#I loaded the tidyverse package
##Plot 'bodysize' (y-axis) in mm vs 'elevation' (x-axis) in meters based on the 'bee_trait_elevation" data.
###Each point was colored by 'species'and sized to 0.6
####I added appropitate labels for the title, both axis, and legend 
#####I decided to use a black and white theme.
library(tidyverse)    
ggplot(bee_trait_elevation, aes(x=elevation,
                                y=bodysize,
                                color=species))+
  geom_point(alpha=0.6)+
  geom_smooth()+
  labs(
    title = "Body-size Overlap Across Elevation",
    x="Elevation (m)",
    y="Body-size (mm)",
    color="Bumble Bee Species")+
  theme_bw()
#Next, I plot 'Phenology' (y-axis) in day of year (1-365) vs 'elevation' (x-axis) in meters based on the 'bee_trait_elevation" data.
###Each point was colored by 'species'and sized to 0.6
####I added appropitate labels for the title, both axis, and legend 
#####I decided to use a black and white theme.
ggplot(bee_trait_elevation, aes(x=elevation,
                                y=phenology,
                                color=species))+
  geom_point(alpha=0.6)+
  geom_smooth()+
  labs(
    title = "Phenology Overlap Across Elevation",
    x="Elevation (m)",
    y="Phenology (day of year)",
    color="Bumble Bee Species")+
  theme_bw()
#Next, I plot 'Tongue-length' (y-axis) in mm vs 'elevation' (x-axis) in meters based on the 'bee_trait_elevation" data.
###Each point was colored by 'species'and sized to 0.6
####I added appropitate labels for the title, both axis, and legend 
#####I decided to use a black and white theme.
ggplot(bee_trait_elevation, aes(x=elevation,
                                y=tongue_length,
                                color=species))+
  geom_point(alpha=0.6)+
  geom_smooth()+
  labs(
    title = "Tongue-length Overlap Across Elevation",
    x="Elevation (m)",
    y="Tongue-length (mm)",
    color="Bumble Bee Species")+
  theme_bw()
#Since I plotted all traits overlaps across elevation to solve my first question, I will begin plotting to answer my second question.
##I would like to plot the number of flowers observed across elevation. 
###Based on the 'bee_flower' dataset, I used 'ele_m' for my x-axis, 'num_flow' for my y-axis.
####Each point was sized to 0.5 and represents each flower observed.
#####I added a smooth trend line through the data using the LOESS method. This method is able to connect many small regressions.
######I added appropirate labels for the title, x-axis and y-axis.
#######I added a black and white theme.

ggplot(bee_flower, aes(x=ele_m, y=num_flow))+
  geom_point(alpha=0.5)+
  geom_smooth(method="loess")+
  labs(
    title="Number of Flowers Across Elevation",
    x="Elevation (m)",
    y="Number of Flowers Observed")+
  theme_bw()
