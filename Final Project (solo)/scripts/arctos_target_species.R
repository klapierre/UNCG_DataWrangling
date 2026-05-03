# working with arctos data

# Load packages
library(ggplot2)
library(tidyverse)
library(maps)
library(mapview)
library(terra)
library(sf)
library(geodata)

arctos_data <- read.csv("arctos_target_species.csv")

colnames(arctos_data)

# cleaning data: removing columns
arctos_data <- arctos_data %>%
  select(-USE_LICENSE_URL,
         -MINIMUM_ELEVATION)
         
# changing column names
arctos_data <- rename(.data=arctos_data,                                                              country=COUNTRY,
                      state=STATE_PROV,
                      locality=SPEC_LOCALITY,
                      date=VERBATIM_DATE,
                      lat=DEC_LAT,
                      lon=DEC_LONG,
                      elevation=MAXIMUM_ELEVATION,
                      sex=SEX,
                      life_stage=LIFE_STAGE,
                      genus=GENUS,
                      order=PHYLORDER,
                      family=FAMILY,
                      species=SPECIES)

# removing rows without elevation data
arctos_data <- arctos_data %>%
  drop_na(elevation)



# subset tamias minimus 
tamias_minimus <- arctos_data %>%
  filter(species == "Tamias minimus")

# subset tamias umbrinus 
tamias_umbrinus <- arctos_data %>%
  filter(species == "Tamias umbrinus")

# subset urocitellus mollis
urocitellus_mollis <- arctos_data %>%
  filter(species == "Urocitellus mollis")

# subset urocitellus beldingi
urocitellus_beldingi <- arctos_data %>%
  filter(species == "Urocitellus beldingi")


# creating Tamias minimus (low elevation) historgrams based on elevation 
ggplot(tamias_minimus, aes(x = elevation)) + 
  geom_histogram(binwidth=100) +
  labs(title = "Tamias minimus elevation")

# creating Tamias umbrinus (high elevation) historgrams based on elevation 
ggplot(tamias_umbrinus, aes(x = elevation)) + 
  geom_histogram(binwidth=100) +
  labs(title = "Tamias umbrinus elevation")

# creating Urocitellus mollis (low elevation) historgrams based on elevation 
ggplot(urocitellus_mollis, aes(x = elevation)) + 
  geom_histogram(binwidth=100) +
  labs(title = "Urocitellus mollis elevation")

# creating Urocitellus beldingi (high elevation) historgrams based on elevation 
ggplot(urocitellus_beldingi, aes(x = elevation)) + 
  geom_histogram(binwidth=100) +
  labs(title = "Urocitellus beldingi elevation")











# subset tamias  
tamias <- arctos_data %>%
  filter(species == "Tamias minimus" | species == "Tamias umbrinus")

# subset urocitellus 
urocitellus <- arctos_data %>%
  filter(species == "Urocitellus mollis" | species == "Urocitellus beldingi")

# creating Tamias histogram based on elevation 
ggplot(tamias, aes(x = elevation,
                   fill = species)) + 
  scale_fill_manual(values = c("#88bc5e", "#364b25")) +
  geom_histogram(binwidth=100) +
  xlim(1500, 10000) +
  theme_classic() +
  labs(title = "Tamias elevation")

# creating Urocitellus based on elevation 
# fix mollis beldingi order on legend
ggplot(urocitellus, aes(x = elevation,
                        fill = species)) + 
  scale_fill_manual(values = c("#812c1f", "#d74a35")) +
  geom_histogram(binwidth=100) +
  xlim(1500, 10000) +
  theme_classic() +
  labs(title = "Urocitellus elevation")





