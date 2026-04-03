# Amaliya Brown Doyoyo
# BIO 456
# May 4 2026
# Individual Project

# -----------------------------------------------------------------------
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##### Comparing the Effects of Ecological vs Population Factors on West 
#### Nile Virus Incidence in Afrotropical vs Palaearctic Regions 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# -----------------------------------------------------------------------

# I. Preparing Workspace
library(tidyverse)
library(ggplot2)
library(sf)
library(rnaturalearth)

setwd("/Users/amaliya/Desktop/IndividualProject/wnv_data")

# II. Downloading Data
afrotropical <- read.csv("Afrotropical_region.csv")
palaearctic <- read.csv("Palaearctic_region.csv")

# ---------------------------
# PART ONE: Tidying the Data
# ---------------------------

# 1.1: kelvin_to_celsius converts Kelvins * 10 to Celsius.

kelvin_to_celsius <- function(temp_k) 
{temp_c <- (temp_k/10) - 273.15
return(temp_c)
}

# 1.2: making tidy afrotropical and palaearctic dataframes.

 # Tidy afrotropical dataframe
 afro_clean <- afrotropical %>% 
    select(BIO1, BIO5_MEAN, BIO6_MEAN, BIO12, DENS_POB, 
           DISTCENPOB, DISRT_RAIL, DIST_ROAD, FWNVetio, Region) %>% 
    rename(Temp_Mean = BIO1, Temp_Max = BIO5_MEAN, 
           Temp_Min = BIO6_MEAN,
           Annual_Precipitation = BIO12, Population_Density = DENS_POB, 
           Distance_Cities = DISTCENPOB,
           Distance_Railroals = DISRT_RAIL, 
           Distance_Roads = DIST_ROAD, WNV_Frequency = FWNVetio) %>% 
    mutate(across(c(Temp_Mean, Temp_Max, Temp_Min), kelvin_to_celsius)) %>% 
    mutate(across(c(Population_Density, Distance_Cities, 
                    Distance_Railroals, Distance_Roads, 
                    WNV_Frequency), as.numeric)) %>% 
    drop_na() %>% 
    mutate(Region = "Afrotropical")

  # Tidy palaearctic dataframe
  pala_clean <- palaearctic %>% 
    select(BIO1, BIO5_MEAN, BIO6_MEAN, BIO12, DENS_POB, 
           DISTCENPOB, DISRT_RAIL, DIST_ROAD, FWNVpal, Region) %>% 
    rename(Temp_Mean = BIO1, Temp_Max = BIO5_MEAN, 
           Temp_Min = BIO6_MEAN,
           Annual_Precipitation = BIO12, Population_Density = DENS_POB, 
           Distance_Cities = DISTCENPOB,
           Distance_Railroals = DISRT_RAIL, 
           Distance_Roads = DIST_ROAD, WNV_Frequency = FWNVpal) %>% 
    mutate(across(c(Temp_Mean, Temp_Max, Temp_Min), kelvin_to_celsius)) %>% 
    mutate(across(c(Population_Density, Distance_Cities, 
                    Distance_Railroals, Distance_Roads, 
                    WNV_Frequency), as.numeric)) %>% 
    drop_na() %>% 
    mutate(Region = "Palaearctic")
  
  # ---------------------------
  # PART TWO: Bar Graphs
  # ---------------------------
  
  
