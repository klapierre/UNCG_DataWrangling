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

# 1.0: kelvin_to_celsius converts Kelvins * 10 to Celsius.

kelvin_to_celsius <- function(temp_k) 
{temp_c <- (temp_k/10) - 273.15
return(temp_c)
}

# 1.1: making tidy afrotropical and palaearctic dataframes.

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
  
  # 2.0: wnv_corr dataframe shows the overall correlation between 
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
    
  # 2.1: using ggplot to create bar graphs showing the correlation between 
  # ecological variables and WNV incidence in afrotropical vs palaearctic regions. 
  
  ggplot(wnv_corr, aes(x = reorder(Variable, Correlation), y = Correlation, fill = Region)) +
    geom_col(position = position_dodge(width = 0.9)) +
    coord_flip() +
    geom_text(aes(label = round(Correlation, 2), hjust = ifelse(Correlation >= 0, -0.5, 1.3)), 
              position = position_dodge(width = 0.9),
              fontface = "bold",size = 3.5, color = "#5b6482") +
    facet_wrap(~Type, scales = "free_y", labeller = 
                 as_labeller(c("Ecological" = "Ecological Factors",
                               "Population" = "Population Factors"))) + 
    scale_y_continuous(expand = expansion(mult = c(0.1, 0.2))) +
    scale_fill_manual(values = c("Afrotropical" = "#ffbe5d", "Palaearctic" = "#a650a8")) +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 14,
                                    margin = margin(b = 15, t = 15)),
      axis.title.x = element_text(face = "bold", size = 12,
                                  margin = margin(t = 15)),
      axis.text.y = element_text(face = "bold", color = "black", size = 10), 
      axis.text.x = element_text(face = "bold", color = "black"),
      strip.text = element_text(face = "bold", size = 12, color = "#324ea8"),
      legend.title = element_text(face = "bold", size = 12),
      legend.text = element_text(face = "bold", size = 10),
      legend.position = "bottom") + 
    scale_x_discrete(labels = c(
      "corr_mean_temp" = "Avgerage Temp", "corr_max_temp" = "Maximum Temp", 
      "corr_min_temp" = "Minimum Temp", "corr_precip" = "Annual Precipitation",
      "corr_pop" = "Population Density", "corr_cities" = "Distance to Cities",
      "corr_roads" = "Distance to Roads", "corr_railroads" = "Distance to Railroads")) +
    labs(title = "Correlation of Select Ecological and Population 
    Demographic Factors on WNV Incidence in Afrotropical and Palaearctic Regions",
      x = NULL, 
      y = "Correlation Coefficient")
    
 
