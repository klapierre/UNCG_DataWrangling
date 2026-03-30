# Cleaned up final project

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

# Check data 
colnames(umbrinus)
colnames(minimus)
colnames(urocitellus)

# Each file has the same 50 columns, in the same order (a BLESSING)
# I will start by removing the columns that contain data I do not need for mapping (which is a majority of them) 

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

# Check data again 
colnames(umbrinus)
colnames(minimus)
colnames(urocitellus)

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

# Combining dataframes so all species are represented in one df
mammal_data <- rbind(minimus, umbrinus, urocitellus)

# Save mammal_data object ------------------------------------------------------
# Now I am going to save this cleaned up dataframe as an object so I don't have to re-run all of those lines each time I need the object: 
save(mammal_data, file = "mammal_data")

load("mammal_data")
# When I open this file directly clicking the GUI in my folder, it shows up as an illegible text file with a bunch of totally random characters. 
# Not sure why this is, but its working so I wont worry about it

# Building the map using maps() ------------------------------------------------

# Using the function map_data() within the maps package, we can build a dataframe that provides all counties within Nevada
NV_map <- map_data("county", region = "nevada")

# Plotting Nevada map with target species captures
ggplot() +
  geom_polygon(data = NV_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  theme_classic() +
  coord_fixed(1.25) +
  geom_point(data = mammal_data,
             aes(x = lon, y = lat, color = species),
             size = 1,
             alpha = 0.7)


# Different method for building map with elevation raster----------------------

# This is how a former undergrad mentor of mine taught me how to read in climate/elevational data using the geodata package. I am now trying to figure out how to combine my ggplot/dataframe point data from above with the chunk of code below, but the following material is creating spatial vectors, so I will need to transform my mammal dataframe as well 

library(geodata)

#global administrative data level 1 is state
NEV <- gadm(country = "USA", level = 1, path = ".")

# level 2 is counties
NV_county <- gadm(country = "USA", level = 2, path = ".")

# remove counties outside of nevada for map clarity: 
NV_county <- NV_county[NV_county$NAME_1 == "Nevada", ]

#plot shape of nevada no details
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

# Now that I have this base map built, I need to fix my data point object so that I can combine the material

# Because the elevation map is being plotted with plot() (base R), the sf or dataframe points won’t automatically layer on top unless the are converted to a compatible spatial format.


# convert mammal data to georeferenced object (joining lat and long)
sf_mamm <- mammal_data %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
mamm_vect <- vect(sf_mamm)

# Make sure CRS matches raster
crs(mamm_vect) <- crs(nv_elevation)


# Now plot together: ----------------------------------------------------------

# Make custom elevation color pallete: 
# elev_cols <- colorRampPalette(c("#26A63A", "#A3B40A", "#FFC9B6", "#F39BA4", "#F9F1F1"))
# I wanted to make the sky islands pop better, but I realized that the colors I was initially using were not colorblind friendly, so I decided to stick with the built-in terrain colors option

# Plot elevation
plot(nv_elevation, col = terrain.colors(215))

# Add county boundaries
lines(NV_county, alpha = .3)

# Assign custom species point colors: 
species_colors <- c("Tamias minimus" = "#0293C7",
                    "Tamias umbrinus" = "white",
                    "Urocitellus beldingi" = "#CD0000",
                    "Urocitellus mollis" = "black")

point_cols <- species_colors[mamm_vect$species]

# Plot points onto map
points(mamm_vect,
       col = point_cols,
       pch = 16,
       cex = 1,
       alpha = 0.7)









#  SAVE HIGH RESOLUTION ??????????????????????????????????????????????????????
png("target_captures.png", width = 166, height = 130, units = "mm", res = 600)











# UNCG specimen map -----------------------------------------------------------

# Now I want to make the same map, but only plot specimens collected by UNCG
# I already have a cleaned dataset of UNCG specimens that I downloaded from Arctos, where more of our most recent capture data has been uploaded

# filter only UNCG specimens from institution column
UNCG_mammal_data <- read_csv("NV_targets_species.csv")

unique(UNCG_mammal_data$species)

# Nevada map
NV_map <- map_data("county", region = "nevada")

# Plotting Nevada map with target species captures
ggplot() +
  geom_polygon(data = NV_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  theme_classic() +
  coord_fixed(1.25) +
  geom_point(data = UNCG_mammal_data,
             aes(x = lon, y = lat, color = species),
             size = 1,
             alpha = 0.7) 


# Applying elevation raster to map
library(geodata)

#global administrative data level 1 is state
NEV <- gadm(country = "USA", level = 1, path = ".")

# level 2 is counties
NV_county <- gadm(country = "USA", level = 2, path = ".")

# remove counties outside of nevada for map clarity: 
NV_county <- NV_county[NV_county$NAME_1 == "Nevada", ]

#plot shape of nevada no details
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
UNCG_sf_mamm <- UNCG_mammal_data %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
UNCG_mamm_vect <- vect(UNCG_sf_mamm)

# Make sure CRS matches raster
crs(UNCG_mamm_vect) <- crs(nv_elevation)


# Now plot together: ----------------------------------------------------------

# Plot elevation
plot(nv_elevation, col = terrain.colors(215))

# Add county boundaries
lines(NV_county, alpha = .3)

# Assign custom species point colors (changing from previous map because we have no mollis so the colors here look a little worse)
species_colors <- c("Tamias minimus" = "#0293C7",
                    "Tamias umbrinus" = "white",
                    "Urocitellus beldingi" = "#CD0000")

point_cols <- species_colors[UNCG_mamm_vect$species]

# Plot points onto map
points(UNCG_mamm_vect,
       col = point_cols,
       pch = 16,
       cex = 1,
       alpha = 0.7)













#  SAVE HIGH RESOLUTION ??????????????????????????????????????????????????????
png("UNCG_target_captures.png", width = 166, height = 130, units = "mm", res = 600)
















