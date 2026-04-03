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
  
  # 2.1 wnv_corr dataframe shows the overall correlation between 
  # WNV frequency and different variables for both regions and 
  # assigns each value a type (ecological vs population).
  
  wnv_corr <- bind_rows(afro_clean, pala_clean) 
  
  wnv_corr <- wnv_corr %>% 
    group_by(Region) %>% 
    summarize(
      corr_mean_temp = cor(Temp_Mean, WNV_Frequency, use = "complete.obs"),
      corr_max_temp  = cor(Temp_Max, WNV_Frequency, use = "complete.obs"),
      corr_min_temp  = cor(Temp_Min, WNV_Frequency, use = "complete.obs"),
      corr_precip = cor(Annual_Precipitation, WNV_Frequency, use = "complete.obs"),
      corr_pop = cor(Population_Density, WNV_Frequency, use = "complete.obs"),
      corr_cities = cor(Distance_Cities, WNV_Frequency, use = "complete.obs"),
      corr_roads = cor(Distance_Roads, WNV_Frequency, use = "complete.obs"),
      corr_railroads = cor(Distance_Railroals, WNV_Frequency, use = "complete.obs")) %>% 
    pivot_longer(cols = -Region, names_to = "Variable", values_to = "Correlation") %>% 
    mutate(Type = case_when(
      Variable %in% c("corr_mean_temp", "corr_max_temp", "corr_min_temp", "corr_precip") ~ "Ecological",
      Variable %in% c("corr_pop", "corr_cities", "corr_roads", "corr_railroads") ~ "Population")) %>% 
    ungroup()
    
    
 
