
# Individual Project

library(tidyverse)
library(ggplot2)


# Setting working directory 

setwd("/Users/amaliya/Desktop/IndividualProject/wnv_data")

# Loading the data

afrotropical <- read.csv("Afrotropical_region.csv")
palaearctic <- read.csv("Palaearctic_region.csv")

# Making a function to change temperature from kelvins * 10 to celsius.

kelvin_to_celsius <- function(temp_k) 
{temp_c <- (temp_k/10) - 273.15
return(temp_c)
}

# Cleaning and Renaming Columns

afrotropical_clean <- afrotropical %>% 
  select(HEX10_ID, BIO1, BIO5_MEAN, BIO6_MEAN, BIO7, BIO12, DENS_POB, DISTCENPOB, DISRT_RAIL, DIST_ROAD, FWNVetio, F_combinado, Region, Continent) %>% 
  rename(Temp_Mean_C = BIO1, 
         Temp_Max_C = BIO5_MEAN, 
         Temp_Min_C = BIO6_MEAN, 
         Temp_Range_C = BIO7,
         Annual_Precipitation_Kg = BIO12,
         Population_Density_Km = DENS_POB, 
         Distance_to_Cities_m = DISTCENPOB, 
         Distance_to_Railroals_m = DISRT_RAIL, 
         Distance_to_Roads_m = DIST_ROAD, 
         WNV_Frequency = FWNVetio) %>% 
  mutate(across(c(Temp_Mean_C, Temp_Max_C, Temp_Min_C), kelvin_to_celsius) %>% 
           mutate(Temp_Range_C = (Temp_Range_C) / 10))


palearctic_clean <- palaearctic %>% 
  select(HEX10_ID, BIO1, BIO5_MEAN, BIO6_MEAN, BIO7, BIO12, DENS_POB, DISTCENPOB, DISRT_RAIL, DIST_ROAD, FWNVpal, F_combinado, Region, Continent) %>%
  rename(Temp_Mean_C = BIO1, 
         Temp_Max_C = BIO5_MEAN, 
         Temp_Min_C = BIO6_MEAN, 
         Temp_Range_C = BIO7,
         Annual_Precipitation_Kg = BIO12,
         Population_Density_Km = DENS_POB, 
         Distance_to_Cities_m = DISTCENPOB, 
         Distance_to_Railroals_m = DISRT_RAIL, 
         Distance_to_Roads_m = DIST_ROAD, 
         WNV_Frequency = FWNVpal) %>% 
  mutate(across(c(Temp_Mean_C, Temp_Max_C, Temp_Min_C), kelvin_to_celsius) %>% 
           mutate(Temp_Range_C = (Temp_Range_C) / 10))

# Plotting

