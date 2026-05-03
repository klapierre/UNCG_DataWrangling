# mapping additional species: 
# Load packages
library(ggplot2)
library(tidyverse)
library(maps)
library(mapview)
library(terra)
library(sf)
library(geodata)

# Read data
umbrinus <- read.csv("tamias_umbrinus_data.csv")

minimus <- read.csv("tamias_minimus_data.csv")

urocitellus <- read.csv("urocitellus_data.csv")

sorex <- read.csv("sorex_data.csv")

# data cleaning steps ----------------------------------------------------------

# Cleaning Tamias umbrinus (Uinta chipmunk) data
umbrinus <- umbrinus %>%
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

# Cleaning Tamias minimus (Least chipmunk) data
minimus <- minimus %>%
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

# Cleaning Urocitellus beldingi/mollis (Beldings ground squirrel and Piute ground squirrel) data
urocitellus <- urocitellus %>%
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

# Cleaning sorex (shrew) data
sorex <- sorex %>%
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
umbrinus <- rename(.data=umbrinus,   
                   country=countryCode,
                   state=stateProvince,,
                   date=eventDate,
                   lat=decimalLatitude,
                   lon=decimalLongitude,
                   institution=institutionCode)

minimus <- rename(.data=minimus,   
                  country=countryCode,
                  state=stateProvince,,
                  date=eventDate,
                  lat=decimalLatitude,
                  lon=decimalLongitude,
                  institution=institutionCode)

urocitellus <- rename(.data=urocitellus,   
                      country=countryCode,
                      state=stateProvince,,
                      date=eventDate,
                      lat=decimalLatitude,
                      lon=decimalLongitude,
                      institution=institutionCode)

sorex <- rename(.data=sorex,   
                      country=countryCode,
                      state=stateProvince,,
                      date=eventDate,
                      lat=decimalLatitude,
                      lon=decimalLongitude,
                      institution=institutionCode)

# Combining dataframes so all species are represented in one df
NV_mammal_data <- rbind(minimus, umbrinus, urocitellus, sorex)

tamias <- rbind(umbrinus, minimus)

# Save mammal_data object ------------------------------------------------------

# Now I am going to save this cleaned up dataframe as an object so I don't have to re-run all of those lines each time I need the object: 
save(NV_mammal_data, file = "NV_mammal_data")
load("NV_mammal_data")

# saving by genus - sorex
save(sorex, file = "sorex_data")
load("sorex_data")

# saving by genus - tamias
save(tamias, file = "tamias_data")
load("tamias_data")

# saving by genus - urocitellus
save(urocitellus, file = "urocitellus_data")
load("urocitellus_data")

# Building map with elevation raster -------------------------------------------
library(geodata)

# global administrative data level 1 is state
NEV <- gadm(country = "USA", level = 1, path = ".")

# level 2 is counties
NV_county <- gadm(country = "USA", level = 2, path = ".")

# remove counties outside of nevada for map clarity: 
NV_county <- NV_county[NV_county$NAME_1 == "Nevada", ]

# plot shape of nevada no details
plot(NEV[NEV$NAME_1 == "Nevada", ]) 
nev <- NEV[NEV$NAME_1 == "Nevada", ]

# get elevation (30 seconds resolution)
nv_elevation <- elevation_30s(country = "USA", path = ".", mask=TRUE)

# mask to nevada - cropping just reduces the extent
nv_elevation <- crop(nv_elevation, nev, mask = TRUE) 

# using terra to map
plot(nv_elevation, col = terrain.colors(215))

# plot the counties on top of map 
NV_map <- lines(NV_county)


# convert mammal data to georeferenced object (joining lat and long)
sf_mamm_NV <- NV_mammal_data %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
NV_mamm_vect <- vect(sf_mamm_NV)

# Make sure CRS matches raster
crs(NV_mamm_vect) <- crs(nv_elevation)


# Now plot together and save as JPEG:
# Open a high-quality JPEG device
jpeg("nv_summer_species.jpg", width = 3000, height = 3000, res = 300)

# Plot elevation
plot(nv_crop, col = hcl.colors(100, palette = "BluYl"))

# Add county boundaries
lines(NV_county, alpha = .4)

# Assign custom species point colors
species_colors <- c("Sorex vagrans" = "hotpink",
                    "Sorex palustris" = "black",
                    "Urocitellus mollis" = "#FF6347",
                    "Urocitellus beldingi" = "grey30",
                    "Tamias minimus" = "#CDCD00",
                    "Tamias umbrinus" = "white")

point_cols <- species_colors[NV_mamm_vect$species]

# Plot points onto map
points(NV_mamm_vect,
       col = scales::alpha(point_cols, 0.5),
       pch = 16,
       cex = 1,
       alpha = 0.6)

# Add legend
legend("topleft",
       inset = c(0.20, 0.05), 
       legend = names(species_colors),
       col = species_colors,
       pch = 16,
       title = "Species")

# Close the device 
dev.off()
