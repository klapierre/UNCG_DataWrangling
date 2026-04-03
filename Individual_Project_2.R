# Amaliya Brown Doyoyo
# BIO 456
# May 4 2026
# Individual Project

# -----------------------------------------------------------------------
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##### Comparing the Effects of Ecological vs Population Factors on West 
#### Nile Virus Incidence in Afrotropical vs Palearctic Regions 
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

