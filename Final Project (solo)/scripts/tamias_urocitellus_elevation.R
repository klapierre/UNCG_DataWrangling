# Load packages
library(ggplot2)
library(tidyverse)
library(maps)
library(mapview)
library(terra)
library(sf)
library(geodata)

species_accounts <- read.csv("all_accounts.csv")

colnames(species_accounts)

# remove columns
species_accounts <- species_accounts %>%
select(-gbifID, -datasetKey, -occurrenceID,
       -kingdom, -phylum, -class, -infraspecificEpithet,
       -taxonRank,
       -scientificName, -verbatimScientificName,
       -verbatimScientificNameAuthorship,
       -occurrenceStatus,
       -individualCount,
       -publishingOrgKey,
       -coordinateUncertaintyInMeters, -coordinatePrecision,
       -elevationAccuracy,
       -depth, -depthAccuracy,
       -day, -month,
       -taxonKey, -speciesKey,
       -collectionCode, -catalogNumber, -recordNumber,
       -identifiedBy, -dateIdentified,
       -license, -rightsHolder, -recordedBy, -typeStatus,
       -establishmentMeans, -lastInterpreted, 
       -mediaType, -issue)

# Rename columns 
species_accounts <- rename(.data=species_accounts,   
                   country=countryCode,
                   state=stateProvince,,
                   date=eventDate,
                   lat=decimalLatitude,
                   lon=decimalLongitude,
                   institution=institutionCode)



# removing rows without elevation data
species_accounts <- species_accounts %>%
  drop_na(elevation)



# subset tamias genus data 
tamias <- species_accounts %>%
  filter(species == "Tamias minimus" | species == "Tamias umbrinus")


# subset urocitellus genus data
urocitellus <- species_accounts %>%
  filter(species == "Urocitellus mollis" | species == "Urocitellus beldingi")



# creating Tamias histogram based on elevation 
ggplot(tamias, aes(x = elevation,
                   fill = species)) + 
  scale_fill_manual(values = c("#88bc5e", "#364b25")) +
  geom_histogram(binwidth=80) +
  xlim(1000, 3500) +
  ylim(0, 150) +
  theme_classic() +
  labs(title = "Tamias elevation")

# creating Urocitellus histogram based on elevation 
ggplot(urocitellus, aes(x = elevation,
                        fill = species)) + 
  scale_fill_manual(values = c("#812c1f", "#d74a35")) +
  geom_histogram(binwidth=80) +
  xlim(1000, 3000) +
  ylim(0, 30) +
  theme_classic() +
  labs(title = "Urocitellus elevation")

