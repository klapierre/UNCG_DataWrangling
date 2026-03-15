library(tidyverse)

morphology<-read.csv("Morphological Trait .csv")
mortality_vascular_epiphytes<-read.csv("Percent mortality for Vascular Epiphytes.csv")
pressure_volume<-read.csv("Pressure Volume Curve Metrics.csv")
vascular_growth<-read.csv("Vascular_Epiphyte_Growth_Number_Leaves.csv")
elaphoglossum_leafsize<-read.csv("Elaphoglossum sp._Growth_Leaf_Length.csv")
foliar_uptake<-read.csv("Foliar Water Uptake Capacity.csv")
spathulifolia_growth<-read.csv("Growth_Pleurothallis spathulifolia_Number_Individuals.csv")
complanata_growth<-read.csv("Growth_Tillandsia complanata_Height.csv")
efficiency_photochemistry<-read.csv("Maximum Efficiency of PSII Photochemistry.csv")
minimum_conductance<-read.csv("Minimal Conductance (Gmin).csv")

#Link to data: https://portal.edirepository.org/nis/mapbrowse?packageid=edi.1629.1
# Citation: Anders, E., S. Gotsch, M. Vadeboncoeur, H. Asbjornsen, D. Metcalfe, D. Bartholomew, and A. Horwath. 2025. Leaf traits plus growth and dieback data for cloud forest epiphytes in a cloud exclusion treatment at Wayqecha Biological Station, Peru ver 1. Environmental Data Initiative. https://doi.org/10.6073/pasta/4eb85bc373653c42053b3f38f394cf4e (Accessed 2026-03-15).

#I had trouble finding super dirty data, but this set is pretty all over the place, so I think it will be interesting to try to clean up. Let me know what you think though because I am very open to suggestions.

#Above is all of the data sets that were collected in an experiment to understand how fog in cloud forests influence the epiphytes growing in the area. These measurements were done at the Wayqecha Biological Station in Peru, and experiments were done in two plots. The first plot was a control plot with the typical cloud forest conditions, and the second plot was the experimental or treatment plot that had reduced fog using curtains.I would really like to focus specifically on the data that is about the vascular plants simply because I understand vascular plants better than non-vascular plants. The main question that I would like to ask is how does reduction of fog influence foliar water uptake? Then I am also interested to see if possible changes in water uptake correlate with morphological and physiological traits of the plants. I suspect that as fog lowers, foliar uptake will lower, and epiphytic vascular plants will not grow as much resulting in smaller leaves. Data was collects by harvesting stems and leaves from epiphytic plants 1-2 meters off of the ground. If the plant was in an experimental group it was insured that the specimen was close to the curtain blocking the fog so that plants with he most fog interception were the ones being experimentally evaluated.

#When it comes to cleaning the data, I have a lot of data that is divided into individual sets to work with, so my challenge will be turning all of that information into one data set. The first thing I would want to do is remove all of the data for non-vascular plants, and to remove all data for plant die back since I would like to focus on the phenotypic plasticity on the plant, and I have the PSII photochemistry efficiency to determine stress upon the plant. I would want to sort most of the sets by genus/species, and plot so that it is easier to combine data sets and delete or merge any column that are repetitive. For example ever data set has a plot column. One of my biggest challenges and the plants don't have individual ids, all of the data sets just mark them with the genus and species, but there is no indication of which plants are which between data sets. I am playing with the idea of summarizing the information for each genus because of this, but that might make it difficult to then convert to figures. Since different species were measured in different ways I want to make sure that empty columns are marked with N/A. When it comes to plotting the data. I really want to show deviation of foliar uptake by making two box plots, one across maybe all of the plants in the control and one of the experimental group to see if there is any overall difference amongst all of the plants. Then I am very interested in a dot plot using the PSII Photochemistry data and the foliar uptake. And then I would like to make a histogram that looks at physiological changes, and how much the plant grew based on if it is a control plant or experimental plant.

#*There is so much going on with the data that hopefully peer and professor evaluations will really help me narrow down the data and all my possibilities to what will be the most productive.

