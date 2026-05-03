# Dixon final project 

# Load packages
library(ggplot2)
library(tidyverse)
library(maps)
library(mapview)
library(terra)

# Read data
umbrinus <- read.csv("tamias_umbrinus_data.csv")

minimus <- read.csv("tamias_minimus_data.csv")

urocitellus <- read.csv("urocitellus_data.csv")

# Check data 
colnames(umbrinus)
colnames(minimus)
colnames(urocitellus)

# Each file has the same 50 columns, in the same order (a BLESSING)
# I will start by removing the columns that contain data I do not need for mapping (which is a lot of them) 

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


# Building the map using maps() data ------------------------------------------

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

install.packages("geodata")
library(geodata)

#global administrative data level 1 is state
NEV <- gadm(country = "USA", level = 1, path = ".")
NEV$NAME_1 #get state names 

#level 2 is counties
NV_county <- gadm(country = "USA", level = 2, path = ".")
NV_county <- NV_county[NV_county$NAME_1 == "Nevada", ]

#plot shape of nevada no details
plot(NEV[NEV$NAME_1 == "Nevada", ]) 
nev <- NEV[NEV$NAME_1 == "Nevada", ]

# get elevation (30 seconds resolution)
nv_elevation <- elevation_30s(country = "USA", path = ".", mask=TRUE)

# mask to nevada - cropping just reduces the extent
nv_elevation <- crop(nv_elevation, nev, mask = TRUE) 

# using terra to map, color from baseR
plot(nv_elevation, col = terrain.colors(215))

# plot the counties on top of map 
NV_map <- lines(NV_county)



# returning to Dr. Terui's textbook to figure out how I might be able to join these pieces of information:
# convert mammal data to georeferenced object (joining lat and long)
sf_mamm <- mammal_data %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)


 # Now asking for help on combining all of these pieces of data: 

# Now convert the sf file to a spatial vector:
mamm_vect <- vect(sf_mamm)

# Make sure CRS matches raster
crs(mamm_vect) <- crs(nv_elevation)


# Now plot it all together 


# set colors for elevation
elev_cols <- colorRampPalette(c("darkgreen", "gold", "brown", "black"))

# Plot elevation with custom color palette:
plot(nv_elevation, col = elev_cols(215))

# Add county boundaries
lines(NV_county)

#Assign point colors 
species_colors <- c("Tamias minimus" = "blue",
                    "Tamias umbrinus" = "green",
                    "Urocitellus beldingi" = "red",
                    "Urocitellus mollis" = "yellow")

point_cols <- species_colors[mamm_vect$species]

# Add mammal points to map
points(mamm_vect,
       col = point_cols,
       pch = 16,
       alpha = 1,
       cex = 0.5)











